import 'dart:math';
import 'package:calendario/Modelo/Cita.dart';


class Utilidad {


  static Cita generarCitaAleatoria(DateTime fechaBase) {
  final random = Random();
  
  // Generar fecha aleatoria (desplazamiento de -5 a +5 días)
  final diasDesplazamiento = random.nextInt(11) - 5; 
  final fechaAleatoria = fechaBase.add(Duration(days: diasDesplazamiento));
  
  // Generar valores aleatorios para otros atributos
  final trabajadores = ["Juan Pérez", "Ana Gómez", "Luis Martínez"];
  final clientes = ["María López", "Carlos Rivera", "Luisa Fernández"];
  final estados = ["Pendiente", "Completada", "Cancelada"];
  final trabajos = ["Reparación eléctrica", "Instalación de aire acondicionado", "Pintura interior"];
  final ingresos = ["100.00 USD", "200.00 USD", "300.00 USD"];
  final notas = 
  [
    "Cliente solicitó materiales adicionales",
    "Requiere una segunda visita",
    "Trabajo urgente"
  ];

  // Seleccionar valores aleatorios
  final trabajadorAleatorio = trabajadores[random.nextInt(trabajadores.length)];
  final clienteAleatorio    = clientes    [random.nextInt(clientes.length)];
  final estadoAleatorio     = estados     [random.nextInt(estados.length)];
  final trabajoAleatorio    = trabajos    [random.nextInt(trabajos.length)];
  final ingresoAleatorio    = ingresos    [random.nextInt(ingresos.length)];
  final notaAleatoria       = notas       [random.nextInt(notas.length)];
  
  // Crear y devolver la cita aleatoria
  return Cita
  (
    fecha: fechaAleatoria,
    trabajador: trabajadorAleatorio,
    cliente: clienteAleatorio,
    estado: estadoAleatorio,
    trabajo: trabajoAleatorio,
    ingreso: ingresoAleatorio,
    notas: notaAleatoria,
  );

}

  
}




