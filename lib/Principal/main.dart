import 'package:calendario/Principal/Utilidad.dart';
import 'package:flutter/material.dart';
import 'calendario.dart'; // Importa el widget Calendario


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda de Citas',
      home: PaginaCalendario(),
    );
  }
}

class PaginaCalendario extends StatelessWidget {
  final Calendario calendarioWidget = Calendario();

  PaginaCalendario({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Color(0xFFa4a2fe),
      title: const Text('Calendario de Citas'),
    ),
    body: calendarioWidget,
    floatingActionButton: Builder(
  builder: (context) => FloatingActionButton(
    onPressed: () {
      print('Agregando cita aleatoria');
      final citaAleatoria = Utilidad.generarCitaAleatoria(DateTime.now());
      calendarioWidget.agregarCitaDirectamente(context, citaAleatoria);
    },
    child: const Icon(Icons.add),
  ),
),
  );
}
}
