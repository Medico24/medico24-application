import 'dart:async';
import 'dart:io';
import 'package:logger/logger.dart';

/// Service to check network connectivity
class ConnectivityService {
  final Logger _logger = Logger();

  /// Check if device has internet connection
  Future<bool> hasConnection() async {
    try {
      final result = await InternetAddress.lookup(
        'google.com',
      ).timeout(const Duration(seconds: 5));

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _logger.d('Device is online');
        return true;
      }

      _logger.d('Device is offline - no valid address');
      return false;
    } on SocketException catch (_) {
      _logger.d('Device is offline - socket exception');
      return false;
    } on TimeoutException catch (_) {
      _logger.d('Device is offline - timeout');
      return false;
    } catch (e) {
      _logger.e('Error checking connectivity: $e');
      return false;
    }
  }

  /// Check connection with custom host
  Future<bool> hasConnectionToHost(String host) async {
    try {
      final result = await InternetAddress.lookup(
        host,
      ).timeout(const Duration(seconds: 5));

      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      _logger.e('Error checking connectivity to $host: $e');
      return false;
    }
  }

  /// Stream that periodically checks connectivity
  Stream<bool> connectivityStream({
    Duration interval = const Duration(seconds: 30),
  }) async* {
    while (true) {
      yield await hasConnection();
      await Future.delayed(interval);
    }
  }
}
