import 'package:flutter/material.dart';

class Preguntar {
  // Este método estático muestra un diálogo de confirmación con un mensaje dado
  static Future<bool> mostrar(BuildContext context, String mensaje) async 
  {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // Evita que se cierre al tocar fuera de la alerta
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false); // Retorna false al pulsar No
              },
            ),
            TextButton(
              child: const Text('Sí'),
              onPressed: () {
                Navigator.of(context).pop(true); // Retorna true al pulsar Sí
              },
            ),
          ],
        );
      },
    ).then((value) => value ?? false); // Asegura que no sea null
  }




}


