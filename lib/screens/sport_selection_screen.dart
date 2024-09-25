import 'package:flutter/material.dart';
import './home_screen.dart';

class SportSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccione un Deporte'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildSportOption(context, 'Fútbol', 'football'),
            SizedBox(height: 20),
            buildSportOption(context, 'Baloncesto', 'basketball'),
            SizedBox(height: 20),
            buildSportOption(context, 'Fórmula 1', 'formula1'),
          ],
        ),
      ),
    );
  }

  Widget buildSportOption(BuildContext context, String sportName, String sportKey) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(sport: sportKey)),
        );
      },
      child: Container(
        width: 250,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent, // Fondo del recuadro
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            sportName,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
