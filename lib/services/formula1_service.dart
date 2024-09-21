import 'dart:convert';
import 'package:http/http.dart' as http;

class Formula1Service {
  final String apiKey = '0c6a1251ff3ff8ae46757fa7d5b5b22e';
  final String baseUrl = 'https://v1.formula-1.api-sports.io/';

  Future<List<dynamic>> fetchFormula1Races() async {
    
    final response = await http.get(
      Uri.parse('$baseUrl/races?season=2024'),
      headers: {
        'x-apisports-key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['response'];
    } else {
      throw Exception('Error al cargar las carreras de Fórmula 1');
    }
  }
}
