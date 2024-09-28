import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/football_provider.dart';
import './providers/basketball_provider.dart';
import './providers/formula1_provider.dart';
import './providers/league_provider.dart'; // Asegúrate de importar LeagueProvider
import './screens/home_screen.dart';
import './screens/sport_selection_screen.dart';
import './screens/live_screen.dart'; // Importa LiveScreen

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FootballProvider()),
        ChangeNotifierProvider(create: (_) => BasketballProvider()),
        ChangeNotifierProvider(create: (_) => Formula1Provider()),
        ChangeNotifierProvider(create: (_) => LeagueProvider()), // Incluye LeagueProvider aquí
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deportes en Vivo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: TextTheme(
          headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.deepPurple,
          titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      home: SportSelectionScreen(),
      routes: {
        '/live_screen': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return LiveScreen(
            leagueId: args['leagueId'],
            leagueName: args['leagueName'],
          );
        },
      },
    );
  }
}
