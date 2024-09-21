import 'dart:convert';
import 'package:http/http.dart' as http;

class BasketballService {
  final String apiKey = '0c6a1251ff3ff8ae46757fa7d5b5b22e';
  final String baseUrl = 'v2.nba.api-sports.io';

  Future<List<dynamic>> fetchBasketballGames() async {
    // Asegúrate de reemplazar YOUR_LEAGUE_ID y YOUR_SEASON_YEAR con valores válidos
    final response = await http.get(
      Uri.parse('https://v2.nba.api-sports.io/leagues'),
      headers: {
        'x-apisports-key': apiKey,  // Aquí es donde debes poner tu API Key
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['response'];
    } else {
      throw Exception('Error al cargar los partidos de baloncesto');
    }
  }
}
