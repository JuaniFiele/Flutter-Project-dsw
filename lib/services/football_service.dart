import 'dart:convert';
import 'package:http/http.dart' as http;

class FootballService {
  final String apiKey = '0c6a1251ff3ff8ae46757fa7d5b5b22e';
  final String baseUrl = 'https://v3.football.api-sports.io';

  Future<List<dynamic>> fetchFootballFixtures(String timezone) async {
    final response = await http.get(
      Uri.parse('$baseUrl/fixtures?timezone=$timezone&date=${DateTime.now().toIso8601String().split('T')[0]}'),
      headers: {
        'x-apisports-key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Devolvemos solo los partidos del día actual
      return data['response'];
    } else {
      throw Exception('Error al cargar los partidos de fútbol');
    }
  }
}
