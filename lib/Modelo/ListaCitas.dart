import 'package:calendario/Modelo/Cita.dart';
import 'package:flutter/material.dart';

class ListaCitas with ChangeNotifier {

  // Ejemplo de nueva instancia vacia es: ListaCitas()
  final List<Cita> _citas ;

    ListaCitas() : _citas = [];
    // Constructor para crear una nueva lista de citas
    ListaCitas._conLista(List<Cita> citas) : _citas = List.from(citas);

    List<Cita> get todasLasCitas => List.unmodifiable(_citas);


  Future<bool> agregarCita(Cita nuevaCita) async 
  {
    if 
    (
      _citas.any((cita) => 
      cita.cliente == nuevaCita.cliente &&
      cita.fecha.year == nuevaCita.fecha.year &&
      cita.fecha.month == nuevaCita.fecha.month &&
      cita.fecha.day == nuevaCita.fecha.day)
    ) 
    {
     return false; // Ya existe una cita del mismo cliente en el mismo día
    } 
    _citas.add(nuevaCita);
    notifyListeners(); // Notifica a los widgets que dependen de esta lista
   return true;
  }

  void actualizarCita(Cita citaAntigua, Cita citaNueva) 
  {
   int index = _citas.indexOf(citaAntigua);
   if (index != -1) 
   {
    _citas[index] = citaNueva;
    notifyListeners(); // Notifica a los widgets que dependen de esta lista

   }
  } 

  // Método para eliminar una cita
  void eliminarCita(Cita cita) {
    _citas.remove(cita);
    notifyListeners(); // Notifica a los widgets que dependen de esta lista

  }

  // Filtros y ordenamientos


  List<Cita> filtrar({ DateTime? fecha, String? cliente,String? estado,}) 
  {
    return _citas.where((cita)
    {
      final coincideFecha   = fecha == null || (cita.fecha.year == fecha.year && cita.fecha.month == fecha.month && cita.fecha.day == fecha.day);
      final coincideCliente = cliente == null || cita.cliente == cliente;
      final coincideEstado  = estado == null || cita.estado == estado;

      return coincideFecha && coincideCliente && coincideEstado;
    }).toList();
  }

  

  
  ListaCitas ordenarPorFecha({DateTime? fecha,String? cliente,String? estado,}) 
  {
    final listaFiltrada = filtrar( fecha: fecha,cliente: cliente,estado: estado,);

    listaFiltrada.sort((a, b) => a.fecha.compareTo(b.fecha));
    return ListaCitas._conLista(listaFiltrada);
  }

  ListaCitas ordenarPorCliente({DateTime? fecha, String? cliente, String? estado, }) 
  {
    final listaFiltrada = filtrar(fecha: fecha, cliente: cliente, estado: estado, );
    listaFiltrada.sort((a, b) => a.cliente.compareTo(b.cliente));
    return ListaCitas._conLista(listaFiltrada);
  }

  ListaCitas ordenarPorEstado({DateTime? fecha, String? cliente, String? estado, }) 
  {
    final listaFiltrada = filtrar( fecha: fecha, cliente: cliente, estado: estado,);
    listaFiltrada.sort((a, b) => a.estado.compareTo(b.estado));
    return ListaCitas._conLista(listaFiltrada);
  }


  


  void ordenarListaActualPorFecha() 
  {
    _citas.sort((a, b) => a.fecha.compareTo(b.fecha));
  }



// Método para obtener una cita específica por cliente y fecha
  Cita? obtenerCita(String cliente, DateTime fecha) 
  {
    return _citas.firstWhere
    (
      (cita) => cita.cliente == cliente && 
                cita.fecha.year == fecha.year && 
                cita.fecha.month == fecha.month && 
                cita.fecha.day == fecha.day,
      orElse: null,  // Devuelve null si no se encuentra la cita
    );
  }

  // Método para imprimir la información de una cita
  String imprimirInformacionCita(Cita cita) {
    return 'Cita para el cliente ${cita.cliente} en la fecha ${cita.fecha.toLocal()} con estado: ${cita.estado}';
  }





}