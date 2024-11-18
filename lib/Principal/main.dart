
import 'package:calendario/Controlador/Ccalendario';
import 'package:calendario/Principal/P1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
      title: 'Agenda de Citas',
      home: ChangeNotifierProvider<Ccalendario>
      (  // Define explícitamente el tipo
        create: (context) => Ccalendario(),  // Aquí proporcionas la instancia de Ccalendario
        child: P1(),  // P1 es tu widget inicial
      ),
    );
  }
}


