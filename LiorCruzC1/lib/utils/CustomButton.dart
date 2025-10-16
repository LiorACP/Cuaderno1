import 'package:flutter/material.dart';

ButtonStyle customButtonStyle() {

  return ElevatedButton.styleFrom(//devuelve un styleFrom del ElevatedButton
    backgroundColor:  Colors.lightBlue,//fondo del boton
    foregroundColor: Colors.white,  // Color del texto del boton
    side: const BorderSide(color: Colors.blue),  // Borde azul
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),  // Radio del borde
    ),
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),  // Padding para el centrado del texto
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600), // Estilo del texto
    elevation: 3,  // Elevación
    minimumSize: const Size.fromHeight(48),  // Tamaño mínimo
  );
}

ButtonStyle customButtonStyle2() {

  return ElevatedButton.styleFrom(//devuelve un styleFrom del ElevatedButton
    backgroundColor:  Colors.white,//fondo del boton
    foregroundColor: Colors.lightBlue,  // Color del texto del boton
    side: const BorderSide(color: Colors.blue),  // Borde azul
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),  // Radio del borde
    ),
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),  // Padding para el centrado del texto
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600), // Estilo del texto
    elevation: 3,  // Elevación
    minimumSize: const Size.fromHeight(48),  // Tamaño mínimo
  );
}



