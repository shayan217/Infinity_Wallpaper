import 'dart:convert';
import 'package:apis_integration/model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _apiKey = '3G2nR33SWnvyAiDR1KsTXvNHvLqI5zkaJkvQTD3iNlh3RK3oPsDFd9FL';
  static const String _baseUrl = 'https://api.pexels.com/v1';

  static Future<List<Wallpaper>> fetchWallpapers(int page) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/curated?per_page=30&page=$page'),
      headers: {'Authorization': _apiKey},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> wallpapersJson = data['photos'];
      return wallpapersJson.map((json) => Wallpaper.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load wallpapers');
    }
  }
}