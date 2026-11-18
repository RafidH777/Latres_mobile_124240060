import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/show_model.dart';

class ApiService {
  static const String baseUrl = 'https://api.tvmaze.com';

  // Fetch all shows from https://api.tvmaze.com/shows
  static Future<List<ShowModel>> getShows() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/shows'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => ShowModel.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Gagal memuat daftar show (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan saat mengambil data show: $e');
    }
  }

  // Fetch single show detail from https://api.tvmaze.com/shows/{id}
  static Future<ShowModel> getShowDetail(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/shows/$id'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return ShowModel.fromJson(data);
      } else {
        throw Exception('Gagal memuat detail show (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan saat mengambil detail show: $e');
    }
  }
}
