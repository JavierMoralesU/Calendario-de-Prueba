
class Cita {
  final DateTime fecha; // Representa la fecha y hora de la cita
  final String trabajador; // Nombre del trabajador
  final String cliente; // Nombre del cliente
  final String estado; // Estado de la cita (e.g., "Pendiente", "Completada")
  final String trabajo; // Descripción del trabajo
  final String ingreso; // Monto del ingreso (puede ser un monto o "pendiente")
  final String notas; // Notas adicionales sobre la cita

  Cita({
    required this.fecha,
    required this.trabajador,
    required this.cliente,
    required this.estado,
    required this.trabajo,
    required this.ingreso,
    required this.notas,
  });

  // Método para mostrar la fecha y hora de forma legible
  String formatoFechaHora() {
    return "${fecha.day}/${fecha.month}/${fecha.year} - ${fecha.hour}:${fecha.minute}";
  }

  // Método para mostrar todos los detalles de la cita
  String detallesCita() {
    return """
Fecha y hora: ${formatoFechaHora()}
Trabajador: $trabajador
Cliente: $cliente
Estado: $estado
Trabajo: $trabajo
Ingreso: $ingreso
Notas: $notas
""";
  }

  @override
  String toString() {
    return "Cita con $cliente para $trabajo el ${formatoFechaHora()} (Estado: $estado)";
  }
}