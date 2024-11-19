import 'package:calendario/Controlador/Ccalendario';
import 'package:calendario/Modelo/ListaCitas.dart';
import 'package:calendario/Vistas/Vcalendario.dart';
import 'package:calendario/Modelo/Cita.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class P1 extends StatelessWidget {
  const P1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendario de Citas"),
      ),
      body: const CalendarioWidget(), // Este widget muestra las citas en el calendario
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Muestra un formulario para agregar una cita
          _mostrarFormularioAgregarCita(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Método para mostrar el formulario de agregar cita
  void _mostrarFormularioAgregarCita(BuildContext context) {

    // Obtener la instancia de Ccalendario desde el provider
   final ccalendario = Provider.of<Ccalendario>(context, listen: false);


    // Controladores de texto para cada campo
    TextEditingController clienteController = TextEditingController();
    TextEditingController trabajadorController = TextEditingController();
    TextEditingController trabajoController = TextEditingController();
    TextEditingController estadoController = TextEditingController();
    TextEditingController ingresoController = TextEditingController();
    TextEditingController notasController = TextEditingController();

    // Usar la fecha seleccionada, si existe, de lo contrario la fecha actual
    DateTime fechaSeleccionada = ccalendario.fechaSeleccionada ?? DateTime.now();


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar nueva cita'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(labelText: 'Cliente'),
                  controller: clienteController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Trabajador'),
                  controller: trabajadorController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Trabajo'),
                  controller: trabajoController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Estado'),
                  controller: estadoController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Ingreso'),
                  controller: ingresoController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Notas'),
                  controller: notasController,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Crear la cita con los valores de los TextFields
                Cita nuevaCita = Cita
                (
                  fecha: fechaSeleccionada, // Usar la fecha seleccionada
                  trabajador: trabajadorController.text,
                  cliente: clienteController.text,
                  estado: estadoController.text,
                  trabajo: trabajoController.text,
                  ingreso: ingresoController.text,
                  notas: notasController.text,
                );
                
                // Agregar la cita a la lista de citas utilizando el provider
                final listaCitas = Provider.of<ListaCitas>(context, listen: false);
                listaCitas.agregarCita(nuevaCita);

                Navigator.of(context).pop(); // Cierra el formulario
              },
              child: const Text('Guardar'),
            ),
            TextButton
            (
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el formulario
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}