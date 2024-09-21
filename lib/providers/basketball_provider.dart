import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BasketballProvider with ChangeNotifier {
  bool loading = false;
  List<dynamic> games = [];

  Future<void> fetchBasketballGames() async {
    try {
      loading = true;
      notifyListeners();
      
      final response = await http.get(Uri.parse('https://v2.nba.api-sports.io/leagues'));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        games = data['response']; // Asegúrate de que esto coincida con la estructura de tu respuesta
      } else {
        throw Exception('Error al cargar los juegos de baloncesto');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
