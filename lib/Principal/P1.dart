import 'package:calendario/Principal/CalendarioWidget.dart';
import 'package:calendario/Principal/ListaCitas.dart';
import 'package:calendario/Principal/Cita.dart';
import 'package:flutter/material.dart';



class P1 extends StatefulWidget {
  @override
  _P1State createState() => _P1State();
}

class _P1State extends State<P1> {
  final ListaCitas listaCitas = ListaCitas();
  DateTime? _fechaSeleccionada;
  TimeOfDay? _horaSeleccionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendario de Citas'),
      ),
      body: Column(
        children: [
          CalendarioWidget(
            citas: listaCitas.todasLasCitas,
          ),
          // Asegúrate de tener un widget para seleccionar la fecha
          // Por ejemplo, puedes usar un GestureDetector que llame a _actualizarFechaSeleccionada
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarSelectorFechaYHora,
        child: Icon(Icons.add),
      ),
    );
  }

  // Método para mostrar un selector de fecha y hora
  void _mostrarSelectorFechaYHora() {
    // Si no se ha seleccionado una fecha, muestra un mensaje
    if (_fechaSeleccionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, selecciona primero una fecha en el calendario.')),
      );
      return;
    }

    // Seleccionar la hora
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((hora) {
      if (hora != null) {
        setState(() {
          _horaSeleccionada = hora;
        });
        _agregarCita();
      }
    });
  }

  // Método para agregar la cita
  void _agregarCita() {
    if (_fechaSeleccionada != null && _horaSeleccionada != null) {
      DateTime fechaCita = DateTime(
        _fechaSeleccionada!.year,
        _fechaSeleccionada!.month,
        _fechaSeleccionada!.day,
        _horaSeleccionada!.hour,
        _horaSeleccionada!.minute,
      );

      // Crear la nueva cita
      Cita nuevaCita = Cita(fecha: fechaCita, hora: _horaSeleccionada!);

      // Agregar la cita a la lista
      listaCitas.agregarCita(nuevaCita);

      // Actualizar el calendario
      final calendario = context.findAncestorStateOfType<_CalendarioWidgetState>();
      if (calendario != null) {
        calendario.actualizar(listaCitas.todasLasCitas);
      }

      // Restablecer la fecha y hora seleccionadas
      setState(() {
        _fechaSeleccionada = null;
        _horaSeleccionada = null;
      });
    }
  }

  // Método para obtener la fecha seleccionada del calendario
  void _actualizarFechaSeleccionada(DateTime fecha) {
    setState(() {
      _fechaSeleccionada = fecha;
    });
  }
}