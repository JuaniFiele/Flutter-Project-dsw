import 'dart:convert';
import 'package:http/http.dart' as http;

class BasketballService {
  final String apiKey = '0c6a1251ff3ff8ae46757fa7d5b5b22e';
  final String baseUrl = 'https://v2.nba.api-sports.io';

  Future<List<dynamic>> fetchLiveBasketballGames() async {
    final response = await http.get(
      Uri.parse('$baseUrl/games?live=all'), // Cambiar a este endpoint
      headers: {
        'x-apisports-key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['response'];
    } else {
      throw Exception('Error al cargar los juegos de baloncesto');
    }
  }
}
