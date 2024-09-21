import 'dart:convert';
import 'package:http/http.dart' as http;

class Formula1Service {
  final String apiKey = '0c6a1251ff3ff8ae46757fa7d5b5b22e';
  final String baseUrl = 'https://v1.formula-1.api-sports.io/competitions';

  Future<List<dynamic>> fetchFormula1Races() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'x-rapidapi-key': apiKey,
          'x-rapidapi-host': 'v1.formula-1.api-sports.io',  // Agrega si es necesario
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['response'];
      } else {
        print('Error: Status code ${response.statusCode}');
        throw Exception('Error al cargar las carreras de Fórmula 1');
      }
    } catch (error) {
      print('Error en fetchFormula1Races: $error');
      throw Exception('Error de red o en la API');
    }
  }
}
