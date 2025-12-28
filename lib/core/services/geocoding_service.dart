import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeocodingService {
  static const _baseUrl =
      "https://maps.googleapis.com/maps/api/geocode/json";

  /// Cache for reverse geocoding results to avoid redundant API calls
  static final Map<String, String> _geoCache = {};

  /// Reverse geocode latitude and longitude to get formatted address
  /// Implements caching to reduce API costs
  static Future<String> reverseGeocode(
    double lat,
    double lng,
  ) async {
    // Check cache first
    final cacheKey = "${lat.toStringAsFixed(6)},${lng.toStringAsFixed(6)}";
    if (_geoCache.containsKey(cacheKey)) {
      return _geoCache[cacheKey]!;
    }

    final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
    if (apiKey.isEmpty) {
      throw Exception("Google Maps API key not configured");
    }

    final uri = Uri.parse(
      "$_baseUrl?latlng=$lat,$lng&key=$apiKey",
    );

    try {
      final res = await http.get(uri);
      final data = jsonDecode(res.body);

      if (data["status"] != "OK") {
        throw Exception("Geocoding failed: ${data["status"]}");
      }

      final address = data["results"][0]["formatted_address"] as String;
      
      // Cache the result
      _geoCache[cacheKey] = address;
      
      return address;
    } catch (e) {
      throw Exception("Failed to reverse geocode: $e");
    }
  }

  /// Get detailed address components from coordinates
  static Future<Map<String, dynamic>> getAddressComponents(
    double lat,
    double lng,
  ) async {
    final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
    if (apiKey.isEmpty) {
      throw Exception("Google Maps API key not configured");
    }

    final uri = Uri.parse(
      "$_baseUrl?latlng=$lat,$lng&key=$apiKey",
    );

    try {
      final res = await http.get(uri);
      final data = jsonDecode(res.body);

      if (data["status"] != "OK") {
        throw Exception("Geocoding failed: ${data["status"]}");
      }

      final result = data["results"][0];
      final components = result["address_components"] as List;

      String locality = '';
      String city = '';
      String state = '';
      String postalCode = '';

      for (var component in components) {
        final types = component["types"] as List;
        if (types.contains("locality")) {
          locality = component["long_name"];
        } else if (types.contains("administrative_area_level_2")) {
          city = component["long_name"];
        } else if (types.contains("administrative_area_level_1")) {
          state = component["long_name"];
        } else if (types.contains("postal_code")) {
          postalCode = component["long_name"];
        }
      }

      return {
        'formatted_address': result["formatted_address"],
        'locality': locality,
        'city': city,
        'state': state,
        'postal_code': postalCode,
      };
    } catch (e) {
      throw Exception("Failed to get address components: $e");
    }
  }

  /// Clear the geocoding cache
  static void clearCache() {
    _geoCache.clear();
  }
}
