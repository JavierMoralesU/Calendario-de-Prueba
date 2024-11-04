import 'package:calendario/Principal/Cita.dart';
import 'package:flutter/material.dart';

class CalendarioWidget extends StatefulWidget {
  final List<Cita> citas;

  CalendarioWidget({Key? key, required this.citas}) : super(key: key);

  @override
  _CalendarioWidgetState createState() => _CalendarioWidgetState();
}

class _CalendarioWidgetState extends State<CalendarioWidget> {
  DateTime _fechaActual = DateTime.now();
  DateTime? _fechaSeleccionada;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        _buildDaysOfWeekHeader(),
        Expanded(child: _buildCalendarGrid()),
      ],
    );
  }

  // Header: Muestra el año y mes actual con botones de navegación
  Widget _buildHeader() {
    String mes = _obtenerNombreMes(_fechaActual.month);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => _cambiarMes(-1),
        ),
        Text(
          "${_fechaActual.year} - $mes",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: () => _cambiarMes(1),
        ),
      ],
    );
  }

  // Encabezado de días de la semana
  Widget _buildDaysOfWeekHeader() {
    final diasSemana = ["Lun", "Mar", "Mié", "Jue", "Vie", "Sáb", "Dom"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: diasSemana.map((dia) {
        return Expanded(
          child: Center(child: Text(dia, style: TextStyle(fontWeight: FontWeight.bold))),
        );
      }).toList(),
    );
  }

  // Grid del calendario que muestra los días del mes actual
  Widget _buildCalendarGrid() {
    final primerDiaDelMes = DateTime(_fechaActual.year, _fechaActual.month, 1);
    final primerDiaSemana = primerDiaDelMes.weekday - 1;
    final diasEnMes = DateUtils.getDaysInMonth(_fechaActual.year, _fechaActual.month);

    List<Widget> dias = List.generate(
      42, // 6 filas (7 días * 6 filas) para evitar cambio de tamaño
      (index) {
        if (index < primerDiaSemana || index >= primerDiaSemana + diasEnMes) {
          return SizedBox.shrink(); // Días vacíos fuera del rango
        } else {
          final dia = index - primerDiaSemana + 1;
          final fecha = DateTime(_fechaActual.year, _fechaActual.month, dia);
          return _buildDia(fecha);
        }
      },
    );

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      children: dias,
      physics: NeverScrollableScrollPhysics(), // Evita el desplazamiento interno del grid
    );
  }

  // Widget para cada día en el calendario
  Widget _buildDia(DateTime fecha) {
    List<Cita> citasDelDia = widget.citas
        .where((cita) => cita.fecha.year == fecha.year && cita.fecha.month == fecha.month && cita.fecha.day == fecha.day)
        .toList();

    Color colorDia = _determinarColorDia(citasDelDia);

    return GestureDetector(
      onTap: () {
        setState(() {
          _fechaSeleccionada = fecha;
        });
      },
      child: Container(
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: colorDia,
          border: Border.all(color: _fechaSeleccionada == fecha ? Colors.blue : Colors.grey, width: _fechaSeleccionada == fecha ? 3 : 1), // Aumenta el grosor aquí
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.center,
        child: Text(
          "${fecha.day}",
          style: TextStyle(
            color: colorDia == Colors.transparent ? Colors.black : Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // Método para determinar el color del día basado en las citas
  Color _determinarColorDia(List<Cita> citasDelDia) {
    if (citasDelDia.isEmpty) return Colors.transparent;
    if (citasDelDia.length > 1) return Colors.purple;

    Cita cita = citasDelDia.first;
    int hora = cita.hora.hour;

    if (hora >= 6 && hora < 12) return Colors.red;
    if (hora >= 12 && hora < 18) return Colors.yellow;
    return Colors.blue.shade900;
  }

  // Método para cambiar de mes (navegación)
  void _cambiarMes(int incremento) {
    setState(() {
      _fechaActual = DateTime(_fechaActual.year, _fechaActual.month + incremento);
    });
  }

  // Obtener el nombre del mes
  String _obtenerNombreMes(int mes) {
    const nombresMeses = [
      "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
      "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"
    ];
    return nombresMeses[mes - 1];
  }

 // Método para actualizar el calendario con una nueva lista de citas
void actualizar(List<Cita> nuevasCitas) {
  setState(() {
    widget.citas.clear();
    widget.citas.addAll(nuevasCitas);
  });
}

  // Método para obtener la fecha seleccionada
  DateTime? get fechaSeleccionada => _fechaSeleccionada;
}