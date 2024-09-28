import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/football_service.dart';

class LeagueProvider with ChangeNotifier {
  List<Map<String, dynamic>> _leagues = [];
  bool _loading = false;
  final FootballService _footballService = FootballService();

  List<Map<String, dynamic>> get leagues => _leagues;
  bool get loading => _loading;

  Future<void> fetchFootballLeagues() async {
    _loading = true;
    notifyListeners();

    try {
      List<dynamic> fetchedLeagues = await _footballService.fetchFootballLeagues();
      _leagues = fetchedLeagues.map((league) => league as Map<String, dynamic>).toList();
    } catch (error) {
      print('Error fetching leagues: $error');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
