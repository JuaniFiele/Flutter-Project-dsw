import 'package:flutter/foundation.dart';
import '../services/football_service.dart';

class FootballProvider with ChangeNotifier {
  List<Map<String, dynamic>> _fixtures = [];
  bool _loading = false;
  final FootballService _footballService = FootballService();

  List<Map<String, dynamic>> get fixtures => _fixtures;
  bool get loading => _loading;

  Future<void> fetchFootballFixtures(int leagueId) async {
    _loading = true;
    notifyListeners();

    try {
      // Llamada al servicio
      List<Map<String, dynamic>> fetchedFixtures = await _footballService.fetchFootballFixtures(leagueId);
      
      if (fetchedFixtures.isNotEmpty) {
        _fixtures = fetchedFixtures.map((fixture) => fixture as Map<String, dynamic>).toList();
        print('Fixtures obtenidos: $_fixtures');
      } else {
        print('No se encontraron partidos para la liga y fecha seleccionada.');
        _fixtures = [];
      }
    } catch (error) {
      print('Error al cargar los partidos: $error');
      _fixtures = [];
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
