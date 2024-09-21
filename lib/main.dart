import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/football_provider.dart';
import './providers/basketball_provider.dart';
import './providers/formula1_provider.dart';
import './screens/home_screen.dart';
import './screens/sport_selection_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FootballProvider()),
        ChangeNotifierProvider(create: (_) => BasketballProvider()),
        ChangeNotifierProvider(create: (_) => Formula1Provider()),
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
        primarySwatch: Colors.blue,
      ),
      home: SportSelectionScreen(), // Cambia aquí para mostrar el menú principal
    );
  }
}
