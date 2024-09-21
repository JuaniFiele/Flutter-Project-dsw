import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Formula1Provider with ChangeNotifier {
  bool loading = false;
  String errorMessage = '';
  List<dynamic> races = [];

  Future<void> fetchFormula1Races() async {
    const String apiKey = '0c6a1251ff3ff8ae46757fa7d5b5b22e';
    
    try {
      loading = true;
      errorMessage = ''; // Limpiar el mensaje de error antes de cargar
      notifyListeners();

      final response = await http.get(
        Uri.parse('https://v1.formula-1.api-sports.io/competitions'),
        headers: {
          'x-apisports-key': apiKey,
          'x-rapidapi-host': 'v1.formula-1.api-sports.io'
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        races = data['response'];
      } else {
        errorMessage = 'Error al cargar las carreras: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage = 'Error: $e';
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
