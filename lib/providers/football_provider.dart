import 'package:flutter/foundation.dart';
import '../services/football_service.dart';

class FootballProvider with ChangeNotifier {
  List<dynamic> _fixtures = [];
  bool _loading = false;

  List<dynamic> get fixtures => _fixtures;
  bool get loading => _loading;

  final FootballService _footballService = FootballService();

  Future<void> fetchFootballFixtures(String timezone) async {
    _loading = true;
    notifyListeners();

    try {
      _fixtures = await _footballService.fetchFootballFixtures(timezone);
    } catch (error) {
      print(error);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
