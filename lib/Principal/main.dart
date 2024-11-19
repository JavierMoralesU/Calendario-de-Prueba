
import 'package:calendario/Controlador/Ccalendario';
import 'package:calendario/Modelo/ListaCitas.dart';
import 'package:calendario/Principal/P1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Proveedor de ListaCitas
        ChangeNotifierProvider<ListaCitas> //antes del otro, antes de Ccalendario
        (
          create: (context) => ListaCitas(),
        ),
        // Proveedor de Ccalendario, pasando la instancia de ListaCitas
        ChangeNotifierProvider<Ccalendario>
        (
          create: (context) {
            // Obtener la instancia de ListaCitas creada arriba
            final listaCitas = Provider.of<ListaCitas>(context, listen: false);
            return Ccalendario(listaCitas); // Pasar ListaCitas al constructor
          },
        ),
      ],
      child: MaterialApp(
        title: 'Agenda de Citas',
        home: P1(),
      ),
    );
  }
}


