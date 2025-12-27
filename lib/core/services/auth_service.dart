import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import '../api/models/auth_model.dart';
import '../service_locator.dart' as sl;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final Logger _logger = Logger();
  bool _initialized = false;

  // Initialize Google Sign In
  Future<void> initialize() async {
    if (_initialized) return;

    final serverClientId = dotenv.env['GOOGLE_WEB_CLIENT_ID'];
    await _googleSignIn.initialize(serverClientId: serverClientId);
    _initialized = true;
  }

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Ensure initialized
      await initialize();

      // Trigger the Google Sign-In flow
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      // Get the authentication details
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // Create a new credential with the ID token
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      final userCredential = await _auth.signInWithCredential(credential);

      // Get Firebase ID token (NOT Google OAuth token)
      final firebaseIdToken = await userCredential.user?.getIdToken();

      if (firebaseIdToken != null) {
        await _authenticateWithBackend(firebaseIdToken);
      } else {
        _logger.w('No Firebase ID token available');
      }

      return userCredential;
    } catch (e) {
      _logger.e('Error signing in with Google', error: e);
      rethrow;
    }
  }

  // Authenticate with backend and store tokens
  Future<void> _authenticateWithBackend(String idToken) async {
    try {
      _logger.d('Sending Firebase ID token to backend...');
      final request = GoogleAuthRequest(idToken: idToken);
      final response = await sl.serviceLocator.authApi.googleCallback(request);

      _logger.d('Received tokens from backend');
      _logger.d('Access token length: ${response.accessToken.length}');

      // Store JWT tokens from backend
      await sl.serviceLocator.secureStorage.write(
        key: 'access_token',
        value: response.accessToken,
      );
      await sl.serviceLocator.secureStorage.write(
        key: 'refresh_token',
        value: response.refreshToken,
      );

      // Verify tokens were stored
      final storedToken = await sl.serviceLocator.secureStorage.read(
        key: 'access_token',
      );
      _logger.d('Token stored successfully: ${storedToken != null}');

      // Fetch and cache user data from backend
      await sl.serviceLocator.userRepository.fetchAndCacheUser();

      _logger.i('Backend authentication successful');
    } catch (e) {
      _logger.e('Failed to authenticate with backend', error: e);
      // Don't throw - allow user to continue with Firebase auth only
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      // Revoke backend tokens
      final refreshToken = await sl.serviceLocator.secureStorage.read(
        key: 'refresh_token',
      );

      if (refreshToken != null) {
        try {
          await sl.serviceLocator.authApi.logout(
            TokenRefreshRequest(refreshToken: refreshToken),
          );
        } catch (e) {
          _logger.e('Failed to logout from backend', error: e);
        }
      }

      // Clear stored tokens
      // Clear cached user data
      await sl.serviceLocator.userRepository.clearCache();

      // Clear appointments cache
      await sl.serviceLocator.database.clearAppointments();

      // Sign out from Firebase and Google
      await _auth.signOut();
      await _googleSignIn.disconnect();
    } catch (e) {
      _logger.e('Error during sign out', error: e);
      rethrow;
    }
  }
}
