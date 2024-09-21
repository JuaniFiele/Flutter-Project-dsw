import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/football_provider.dart';
import '../providers/basketball_provider.dart';
import '../providers/formula1_provider.dart';

class HomeScreen extends StatefulWidget {
  final String sport;

  HomeScreen({required this.sport});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.sport == 'football') {
        Provider.of<FootballProvider>(context, listen: false).fetchFootballLeagues(); // Cambia aquí
      } else if (widget.sport == 'basketball') {
        Provider.of<BasketballProvider>(context, listen: false).fetchBasketballGames();
      } else if (widget.sport == 'formula1') {
        Provider.of<Formula1Provider>(context, listen: false).fetchFormula1Races();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deportes en Vivo - ${widget.sport}'),
      ),
      body: Column(
        children: [
        if (widget.sport == 'football')
          Expanded(
            child: Consumer<FootballProvider>(
              builder: (context, footballProvider, child) {
                if (footballProvider.loading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (footballProvider.leagues.isEmpty) {
                  return Center(child: Text('No hay ligas disponibles.'));
                }
                return ListView.builder(
                  itemCount: footballProvider.leagues.length,
                  itemBuilder: (context, index) {
                    final league = footballProvider.leagues[index];
                    return ListTile(
                      title: Text(league['league']['name']),
                      subtitle: Text(league['country']['name']),
                      leading: Image.network(league['league']['logo']),
                    );
                  },
                );
              },
            ),
          ),
        if (widget.sport == 'basketball')
          Expanded(
            child: Consumer<BasketballProvider>(builder: (context, basketballProvider, child) {
              if (basketballProvider.loading) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: basketballProvider.games.length,
                itemBuilder: (context, index) {
                  final game = basketballProvider.games[index];
                  return ListTile(
                    title: Text('${game['teams']['home']['name']} vs ${game['teams']['away']['name']}'), // Cambia según la estructura
                    subtitle: Text('Marcador: ${game['goals']['home']} - ${game['goals']['away']}'), // Asegúrate de que estas claves existan
                  );
                },
              );
            }),
          ),

          if (widget.sport == 'formula1')
            Expanded(
              child: Consumer<Formula1Provider>(builder: (context, formula1Provider, child) {
                if (formula1Provider.loading) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: formula1Provider.races.length,
                  itemBuilder: (context, index) {
                    final race = formula1Provider.races[index];
                    return ListTile(
                      title: Text('Carrera: ${race['name']} - ${race['location']['city']}, ${race['location']['country']}'),
                    );
                  },
                );
              }),
            ),
        ],
      ),
    );
  }
}
