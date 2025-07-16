import 'dart:convert';
import 'package:doa_sehari_hari_app/data/model/doa.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String? _baseUrl = dotenv.env['BASE_URL'];

  Future<dynamic> getDoaList() async {
    final response = await http.get(Uri.parse('$_baseUrl/api/doa'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load doa list from API');
    }
  }

  Future<Doa> getDoaDetail(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/api/doa/$id'));
    if (response.statusCode == 200) {
      return Doa.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load detail doa from API');
    }
  }
}
