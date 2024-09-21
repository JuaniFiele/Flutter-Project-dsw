import 'package:flutter/material.dart';
import './home_screen.dart';

class SportSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona un Deporte'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: Text('Fútbol'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(sport: 'football')),
              );
            },
          ),
          ListTile(
            title: Text('Baloncesto'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(sport: 'basketball')),
              );
            },
          ),
          ListTile(
            title: Text('Fórmula 1'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(sport: 'formula1')),
              );
            },
          ),
        ],
      ),
    );
  }
}
