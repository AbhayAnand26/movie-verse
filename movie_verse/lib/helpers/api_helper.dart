import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/show_models.dart';

class ApiHelper {
  static Future<List<Show>> fetchShows({int page = 0}) async {
    final uri = Uri.parse('https://api.tvmaze.com/shows?page=$page');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((e) => Show.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch shows (Status: ${response.statusCode})');
    }
  }

  /// Search shows by name dynamically
  static Future<List<Show>> searchShows(String query) async {
    final uri = Uri.parse('https://api.tvmaze.com/search/shows?q=$query');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((e) => Show.fromJson(e['show'])).toList();
    } else {
      throw Exception('Failed to search shows (Status: ${response.statusCode})');
    }
  }
}
