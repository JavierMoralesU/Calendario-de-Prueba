import 'dart:math';
import 'package:calendario/Principal/Cita.dart';
import 'package:flutter/material.dart';


class Utilidad {


  static Cita generarCitaAleatoria(DateTime fechaBase) {
    final random = Random();
    final diasDesplazamiento = random.nextInt(11) - 5; // Desplazamiento entre -5 y +5 días
    final fechaAleatoria = fechaBase.add(Duration(days: diasDesplazamiento));

    final horaAleatoria = TimeOfDay(
      hour: random.nextInt(24), // Hora entre 0 y 23
      minute: random.nextInt(60), // Minutos entre 0 y 59
    );

    return Cita(fecha: fechaAleatoria, hora: horaAleatoria);
  }

  
}




