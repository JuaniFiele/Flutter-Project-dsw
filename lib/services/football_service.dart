import 'dart:convert';
import 'package:http/http.dart' as http;

class FootballService {
  final String apiKey = '0c6a1251ff3ff8ae46757fa7d5b5b22e';
  final String baseUrl = 'https://v3.football.api-sports.io';

  Future<List<Map<String, dynamic>>> fetchFootballFixtures(int leagueId) async {

    final response = await http.get(
      Uri.parse('$baseUrl/fixtures?league=$leagueId&from=2022-12-18&to=2022-12-18&season=2022'),
      headers: {
        'x-apisports-key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      
      if (data.containsKey('response')) {
        return List<Map<String, dynamic>>.from(data['response']);
      } else {
        throw Exception('Error: Respuesta inesperada al cargar los partidos de fútbol');
      }
    } else {
      throw Exception('Error ${response.statusCode}: No se pudo cargar los partidos de fútbol');
    }
  }

  Future<List<Map<String, dynamic>>> fetchFootballLeagues() async {
    final response = await http.get(
      Uri.parse('$baseUrl/leagues'),
      headers: {
        'x-apisports-key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      
      if (data.containsKey('response')) {
        return List<Map<String, dynamic>>.from(data['response']);
      } else {
        throw Exception('Error: Respuesta inesperada al cargar las ligas de fútbol');
      }
    } else {
      throw Exception('Error ${response.statusCode}: No se pudo cargar las ligas de fútbol');
    }
  }
}
