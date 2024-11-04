import 'package:flutter/material.dart';

class Cita {
  final DateTime fecha;
  final TimeOfDay hora;

  Cita({required this.fecha, required this.hora});

  // Método para mostrar la fecha y la hora como un string
  String formatoFechaHora(BuildContext context) {
    return "${fecha.day}/${fecha.month}/${fecha.year} - ${hora.format(context)}";
  }

  @override
  String toString() {
    return "Cita en: $fecha a las ${hora.hour}:${hora.minute}";
  }


//   Cita cita = Cita(fecha: DateTime.now(), hora: TimeOfDay.now());
// print(cita.formatoFechaHora(context)); // Usando el contexto en un widget

}
