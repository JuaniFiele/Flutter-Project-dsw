import 'dart:convert';
import 'package:http/http.dart' as http;

class FootballService {
  final String apiKey = '0c6a1251ff3ff8ae46757fa7d5b5b22e';
  final String baseUrl = 'https://v3.football.api-sports.io';

  Future<List<dynamic>> fetchFootballLeagues() async {
    final response = await http.get(
      Uri.parse('$baseUrl/leagues'),
      headers: {
        'x-apisports-key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['response'];
    } else {
      throw Exception('Error al cargar las ligas de fútbol');
    }
  }
}
