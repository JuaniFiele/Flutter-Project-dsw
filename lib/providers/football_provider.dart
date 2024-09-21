import 'package:flutter/material.dart';
import '../services/football_service.dart';

class FootballProvider with ChangeNotifier {
  List<dynamic> _matches = [];
  bool _loading = false;

  List<dynamic> get matches => _matches;
  bool get loading => _loading;

  final FootballService _footballService = FootballService();

  Future<void> fetchFootballMatches(String leagueId) async {
    _loading = true;
    notifyListeners();

    try {
      _matches = await _footballService.fetchFootballMatches(leagueId);
    } catch (error) {
      print(error);
    } finally {
      _loading = false;
      // Asegúrate de que notifyListeners() se llama después de que se complete la construcción actual.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }
}
