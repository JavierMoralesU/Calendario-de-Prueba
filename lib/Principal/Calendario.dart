import 'package:flutter/material.dart';
import 'package:calendario/Principal/Cita.dart';

class Calendario extends StatefulWidget {
  final List<Cita> citasIniciales;

  Calendario({this.citasIniciales = const []});

  // Método público para agregar una cita desde otro widget
void agregarCitaDirectamente(BuildContext context, Cita cita) 
{
  final state = context.findAncestorStateOfType<_CalendarioState>();
  if (state != null) 
  {
    state.agregarCita(cita);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Cita agregada para ${cita.fecha.day}/${cita.fecha.month} a las ${cita.hora.format(context)}")),
    );
  }
}

  @override
  _CalendarioState createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  List<Cita> citas = [];
  DateTime fechaActual = DateTime.now();

  @override
  void initState() {
    super.initState();
    citas = widget.citasIniciales;
  }

  void agregarCita(Cita cita) {
    setState(() {
      citas.add(cita);
    });
  }

  void eliminarCita(Cita cita) {
    setState(() {
      citas.remove(cita);
    });
  }

  List<Cita> obtenerCitasPorFecha(DateTime fecha) {
    return citas.where((cita) =>
        cita.fecha.year == fecha.year &&
        cita.fecha.month == fecha.month &&
        cita.fecha.day == fecha.day).toList();
  }

  Color obtenerColorCita(List<Cita> citasDelDia)
  {
    if (citasDelDia.length > 1) {
      return Colors.purple;
    } else if (citasDelDia.isNotEmpty) {
      final hora = citasDelDia.first.hora.hour;
      if (hora >= 6 && hora < 12) {
        return Colors.red;
      } else if (hora >= 12 && hora < 18) {
        return Colors.yellow;
      } else {
        return Colors.blue.shade900;
      }
    }
    return Colors.transparent;
  }

  void cambiarMes(int incremento)
  {
    setState(() {fechaActual = DateTime(fechaActual.year, fechaActual.month + incremento, 1);});
  }

  @override
  Widget build(BuildContext context) {
    final diasSemana = ["Lun", "Mar", "Mié", "Jue", "Vie", "Sáb", "Dom"];
    final primerDiaMes = DateTime(fechaActual.year, fechaActual.month, 1);
    final diasMes = DateTime(fechaActual.year, fechaActual.month + 1, 0).day;
    final offsetInicio = primerDiaMes.weekday - 1;

    return Column(
      children: 
      [
        // Encabezado de navegación entre meses
        Container
        (
          color: const Color( 0xFF6b77f0 ),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: 
            [
              IconButton
              (
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => cambiarMes(-1),
              ),
              Text
              (
                "${fechaActual.month}/${fechaActual.year}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              IconButton
              (
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                onPressed: () => cambiarMes(1),
              ),
            ],
          ),
        ),
        
        // Encabezado de días de la semana
        Row
        (
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: diasSemana.map((dia) => Text(dia, style: TextStyle(color: Colors.blue))).toList(),
        ),
        
        // Calendario de días
        Expanded
        (
          child: GridView.builder
          (
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount
            ( crossAxisCount: 7,),
            itemCount: diasMes + offsetInicio,
            itemBuilder: (context, index) 
            {
              if (index < offsetInicio) { return Container(); } //Celdas vacías al inicio

              final dia = index - offsetInicio + 1;
              final fecha = DateTime(fechaActual.year, fechaActual.month, dia);
              final citasDelDia = obtenerCitasPorFecha(fecha);

              return GestureDetector
              (
                onTap: () 
                {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text("Citas para ${fecha.day}/${fecha.month}/${fecha.year}"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: citasDelDia
                            .map((cita) => Text(cita.formatoFechaHora(context)))
                            .toList(),
                      ),
                    ),
                  );
                },
                child: Container
                (
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration
                  (
                    color: obtenerColorCita(citasDelDia),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text("$dia "),
                ),
              );

            },
          ),
        ),
      ],
    );
  }


}
