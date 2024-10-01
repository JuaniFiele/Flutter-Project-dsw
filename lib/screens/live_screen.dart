import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/football_provider.dart';

class LiveScreen extends StatefulWidget {
  final int leagueId;
  final String leagueName;

  LiveScreen({required this.leagueId, required this.leagueName});

  @override
  _LiveScreenState createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Llamar a la API con la fecha específica (ya se maneja en el provider)
      Provider.of<FootballProvider>(context, listen: false)
          .fetchFootballFixtures(widget.leagueId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Partidos del Día - ${widget.leagueName}',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Consumer<FootballProvider>(
                builder: (context, footballProvider, child) {
                  if (footballProvider.loading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  // Verificar si hay datos de fixtures
                  print('Fixtures obtenidos: ${footballProvider.fixtures}'); // Imprimir los fixtures

                  if (footballProvider.fixtures.isEmpty) {
                    return Center(
                      child: Text(
                        'No hay partidos disponibles en esta fecha.',
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    );
                  }

                  // Mostrar los partidos directamente sin filtrar por fecha
                  return ListView.builder(
                    itemCount: footballProvider.fixtures.length,
                    itemBuilder: (context, index) {
                      final fixture = footballProvider.fixtures[index] as Map<String, dynamic>;
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              fixture['league']['logo'] ?? 'https://example.com/default_logo.png',
                            ),
                            radius: 25,
                          ),
                          title: Text(
                            '${fixture['teams']['home']['name']} vs ${fixture['teams']['away']['name']}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text('Fecha: ${fixture['fixture']['date']}'),
                          trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                          onTap: () {
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
