import 'package:calendario/Vistas/Vcalendario.dart';
import 'package:calendario/Modelo/Cita.dart';
import 'package:calendario/Modelo/ListaCitas.dart';
import 'package:calendario/Utilidades/Preguntar.dart';
import 'package:flutter/material.dart';


class P1 extends StatelessWidget {
  final ListaCitas listaCitas = ListaCitas();

  P1() {
    // Ejemplo de inicialización con algunas citas
    listaCitas.agregarCita(
      Cita(
        fecha: DateTime.now(),
        trabajador: "Juan Pérez",
        cliente: "Carlos López",
        estado: "Pendiente",
        trabajo: "Reparación eléctrica",
        ingreso: "500",
        notas: "Prioritario",
      ),
    );
    listaCitas.agregarCita(
      Cita(
        fecha: DateTime.now().add(Duration(days: 1)),
        trabajador: "Ana Martínez",
        cliente: "Sofía Gómez",
        estado: "Confirmada",
        trabajo: "Instalación de aire acondicionado",
        ingreso: "Pendiente",
        notas: "Confirmar horario",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendario de Citas"),
      ),
      body: CalendarioWidget
      (
        // Pasar las citas al widget de calendario
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () 
        {
          Preguntar.mostrar(context, "Esta es un ejemlo de una de las citas ");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}