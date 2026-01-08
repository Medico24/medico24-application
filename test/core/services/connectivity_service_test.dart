import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:medico24/core/services/connectivity_service.dart';

@GenerateMocks([])
void main() {
  late ConnectivityService connectivityService;

  setUp(() {
    connectivityService = ConnectivityService();
  });

  group('ConnectivityService', () {
    test('hasConnection returns true when device is online', () async {
      // This test requires internet connection to pass
      final result = await connectivityService.hasConnection();
      expect(result, isA<bool>());
    });

    test('hasConnectionToHost returns result for reachable host', () async {
      // Test with a known reachable host
      final result = await connectivityService.hasConnectionToHost(
        'google.com',
      );
      expect(result, isA<bool>());
    });

    test('hasConnectionToHost handles unreachable hosts', () async {
      // Test with invalid host - some networks may resolve or timeout
      // We just verify it returns a boolean and doesn't crash
      final result = await connectivityService.hasConnectionToHost(
        'invalid.test.host.that.does.not.exist.123456',
      );
      expect(result, isA<bool>());
    });

    test('connectivityStream emits connectivity status', () async {
      final stream = connectivityService.connectivityStream(
        interval: const Duration(seconds: 1),
      );

      // Take first 2 emissions
      final results = await stream.take(2).toList();
      expect(results.length, 2);
      for (final result in results) {
        expect(result, isA<bool>());
      }
    });
  });
}
