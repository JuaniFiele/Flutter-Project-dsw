import 'package:flutter/foundation.dart';
import '../services/football_service.dart';

class FootballProvider with ChangeNotifier {
  List<dynamic> _leagues = [];
  bool _loading = false;

  List<dynamic> get leagues => _leagues;
  bool get loading => _loading;

  final FootballService _footballService = FootballService();

  Future<void> fetchFootballLeagues() async {
    _loading = true;
    notifyListeners();

    try {
      _leagues = await _footballService.fetchFootballLeagues();
    } catch (error) {
      print(error);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
