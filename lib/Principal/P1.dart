import 'package:calendario/Principal/CalendarioWidget.dart';
import 'package:calendario/Principal/ListaCitas.dart';
import 'package:flutter/material.dart';


class P1 extends StatelessWidget 
{

  final  lista = ListaCitas();


  final ListaCitas listaCitas = ListaCitas();

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar(
        title: Text('Calendario de Citas'),
      ),
      body:  CalendarioWidget(citas: lista.todasLasCitas),
      floatingActionButton: FloatingActionButton(
        onPressed: () 
        {
          // Aquí puedes agregar lógica para agregar nuevas citas
        },
        child: Icon(Icons.add),
      ),
    );
  }
}