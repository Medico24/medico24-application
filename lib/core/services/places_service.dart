import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PlaceSuggestion {
  final String description;
  final String placeId;

  PlaceSuggestion(this.description, this.placeId);

  factory PlaceSuggestion.fromJson(Map<String, dynamic> json) {
    return PlaceSuggestion(
      json["description"],
      json["place_id"],
    );
  }
}

class PlacesService {
  static const _baseUrl =
      "https://maps.googleapis.com/maps/api/place/autocomplete/json";
  
  // In-memory cache for autocomplete results
  static final Map<String, List<PlaceSuggestion>> _cache = {};
  static const int _cacheMaxSize = 50; // Limit cache size

  /// Get autocomplete suggestions for a given input
  /// Restricts results to India for better relevance
  /// Caches results to avoid duplicate API calls
  static Future<List<PlaceSuggestion>> autocomplete(String input) async {
    if (input.isEmpty) return [];

    // Check cache first
    if (_cache.containsKey(input)) {
      return _cache[input]!;
    }

    final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
    if (apiKey.isEmpty) {
      throw Exception("Google Maps API key not configured");
    }

    final uri = Uri.parse(
      "$_baseUrl?input=$input&key=$apiKey&components=country:in",
    );

    try {
      final res = await http.get(uri);
      final data = jsonDecode(res.body);

      if (data["status"] == "ZERO_RESULTS") {
        _cache[input] = [];
        return [];
      }

      if (data["status"] != "OK") {
        throw Exception("Places autocomplete failed: ${data["status"]}");
      }

      final suggestions = (data["predictions"] as List)
          .map((e) => PlaceSuggestion.fromJson(e))
          .toList();
      
      // Cache the result
      _cache[input] = suggestions;
      
      // Limit cache size
      if (_cache.length > _cacheMaxSize) {
        _cache.remove(_cache.keys.first);
      }
      
      return suggestions;
    } catch (e) {
      throw Exception("Failed to get place suggestions: $e");
    }
  }
  
  /// Clear the cache
  static void clearCache() {
    _cache.clear();
  }
}
