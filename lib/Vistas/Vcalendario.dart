import 'package:calendario/Controlador/Ccalendario';
import 'package:calendario/Modelo/Cita.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class CalendarioWidget extends StatelessWidget {

  const CalendarioWidget({super.key});

  @override
  Widget build(BuildContext context)
   {
    final calendario = Provider.of<Ccalendario>(context);

    return Column
    (
      children:
      [
        _buildHeader(calendario), //Cambio de mes 
        _buildDaysOfWeekHeader(), //lunes, martes, etc
        Expanded(child: _buildCalendarGrid(calendario)), //Dias del mes
      ],
    );
  }

  // Header: Muestra el año y mes actual con botones de navegación
  Widget _buildHeader(Ccalendario calendario) 
  {
    String mes = calendario.obtenerNombreMes(calendario.fechaActual.month);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: 
      [
        IconButton
        (
          icon: Icon(Icons.arrow_back),
          onPressed: () => calendario.cambiarMes(-1),
        ),
        Text
        (
          "${calendario.fechaActual.year} - $mes",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: () => calendario.cambiarMes(1),
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
  Widget _buildCalendarGrid(Ccalendario calendario) {
    final primerDiaDelMes = DateTime(calendario.fechaActual.year, calendario.fechaActual.month, 1);
    final primerDiaSemana = primerDiaDelMes.weekday - 1;
    final diasEnMes = DateUtils.getDaysInMonth(calendario.fechaActual.year, calendario.fechaActual.month);

    List<Widget> dias = List.generate(
      42, // 6 filas (7 días * 6 filas)
      (index) {
        if (index < primerDiaSemana || index >= primerDiaSemana + diasEnMes) {
          return SizedBox.shrink();
        } else {
          final dia = index - primerDiaSemana + 1;
          final fecha = DateTime(calendario.fechaActual.year, calendario.fechaActual.month, dia);
          return _buildDia(fecha, calendario);
        }
      },
    );

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      children: dias,
      physics: NeverScrollableScrollPhysics(),
    );
  }

  // Widget para cada día en el calendario
  Widget _buildDia(DateTime fecha, Ccalendario calendario) {
    List<Cita> citasDelDia = calendario.obtenerCitasPorFecha(fecha);

    Color colorDia = calendario.determinarColorDia(citasDelDia);

    return GestureDetector(
      onTap: () {
        calendario.seleccionarFecha(fecha);
      },
      child: Container(
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: colorDia,
          border: Border.all(
              color: calendario.fechaSeleccionada == fecha ? Colors.blue : Colors.grey,
              width: calendario.fechaSeleccionada == fecha ? 3 : 1),
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
}