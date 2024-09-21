import 'dart:convert';
import 'package:http/http.dart' as http;

class FootballService {
  final String apiKey = '0c6a1251ff3ff8ae46757fa7d5b5b22e';
  final String baseUrl = 'https://v3.football.api-sports.io';

  Future<List<dynamic>> fetchFootballMatches(String leagueId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/fixtures?league=$leagueId'), // Agrega el parámetro de liga
      headers: {
        'x-apisports-key': apiKey, // Cambia la clave del header
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['response'];
    } else {
      throw Exception('Error al cargar los partidos de fútbol');
    }
  }
}
