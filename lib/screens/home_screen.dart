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
        Provider.of<FootballProvider>(context, listen: false).fetchFootballLeagues();
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
        title: Text(
          'Deportes en Vivo - ${widget.sport.toUpperCase()}',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple, // Color del AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding general
        child: Column(
          children: [
            if (widget.sport == 'football')
              Expanded(
                child: Consumer<FootballProvider>(
                  builder: (context, footballProvider, child) {
                    if (footballProvider.loading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (footballProvider.leagues.isEmpty) {
                      return Center(
                        child: Text(
                          'No hay ligas disponibles.',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: footballProvider.leagues.length,
                      itemBuilder: (context, index) {
                        final league = footballProvider.leagues[index];
                        return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(league['league']['logo']),
                              radius: 25,
                            ),
                            title: Text(
                              league['league']['name'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(league['country']['name']),
                            trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            if (widget.sport == 'basketball')
              Expanded(
                child: Consumer<BasketballProvider>(
                    builder: (context, basketballProvider, child) {
                  if (basketballProvider.loading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: basketballProvider.games.length,
                    itemBuilder: (context, index) {
                      final game = basketballProvider.games[index];
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(
                            '${game['teams']['home']['name']} vs ${game['teams']['away']['name']}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Marcador: ${game['goals']['home']} - ${game['goals']['away']}',
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            if (widget.sport == 'formula1')
              Expanded(
                child: Consumer<Formula1Provider>(
                    builder: (context, formula1Provider, child) {
                  if (formula1Provider.loading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: formula1Provider.races.length,
                    itemBuilder: (context, index) {
                      final race = formula1Provider.races[index];
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(
                            'Carrera: ${race['name']}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${race['location']['city']}, ${race['location']['country']}',
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
          ],
        ),
      ),
    );
  }
}
