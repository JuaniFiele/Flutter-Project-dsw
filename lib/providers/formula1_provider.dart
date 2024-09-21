import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Formula1Provider with ChangeNotifier {
  bool loading = false;
  List<dynamic> races = [];

  Future<void> fetchFormula1Races() async {
    try {
      loading = true;
      notifyListeners();
      
      final response = await http.get(Uri.parse('https://v1.formula-1.api-sports.io/races?season=2024'));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        races = data['response'];
      } else {
        throw Exception('Error al cargar las carreras');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
