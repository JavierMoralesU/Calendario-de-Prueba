import 'package:calendario/Principal/Cita.dart';

class ListaCitas {

  // Ejemplo de nueva instancia vacia es: ListaCitas()
  final List<Cita> _citas = [];

  // Método para agregar una cita
  void agregarCita(Cita cita) {
    _citas.add(cita);
  }

  // Método para eliminar una cita
  void eliminarCita(Cita cita) {
    _citas.remove(cita);
  }

  // Método para obtener las citas de un día específico
  List<Cita> obtenerCitasPorFecha(DateTime fecha) {
    return _citas.where((cita) =>
        cita.fecha.year == fecha.year &&
        cita.fecha.month == fecha.month &&
        cita.fecha.day == fecha.day).toList();
  }

  // Método para obtener todas las citas
  List<Cita> get todasLasCitas => _citas;
}