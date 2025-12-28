import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PlaceDetailsService {
  static const _baseUrl =
      "https://maps.googleapis.com/maps/api/place/details/json";

  /// Get latitude and longitude from a place ID
  static Future<LatLng> getLatLng(String placeId) async {
    final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
    if (apiKey.isEmpty) {
      throw Exception("Google Maps API key not configured");
    }

    final uri = Uri.parse(
      "$_baseUrl?place_id=$placeId&key=$apiKey",
    );

    try {
      final res = await http.get(uri);
      final data = jsonDecode(res.body);

      if (data["status"] != "OK") {
        throw Exception("Place details failed: ${data["status"]}");
      }

      final loc = data["result"]["geometry"]["location"];
      return LatLng(loc["lat"], loc["lng"]);
    } catch (e) {
      throw Exception("Failed to get place details: $e");
    }
  }

  /// Get full place details including address components
  static Future<Map<String, dynamic>> getPlaceDetails(String placeId) async {
    final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
    if (apiKey.isEmpty) {
      throw Exception("Google Maps API key not configured");
    }

    final uri = Uri.parse(
      "$_baseUrl?place_id=$placeId&key=$apiKey",
    );

    try {
      final res = await http.get(uri);
      final data = jsonDecode(res.body);

      if (data["status"] != "OK") {
        throw Exception("Place details failed: ${data["status"]}");
      }

      return data["result"];
    } catch (e) {
      throw Exception("Failed to get place details: $e");
    }
  }
}
