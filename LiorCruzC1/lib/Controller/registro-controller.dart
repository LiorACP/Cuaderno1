import 'package:flutter/material.dart';

class RegistroController {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController edadController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();
  final TextEditingController repetirContrasenaController = TextEditingController();

  void dispose() {
    nombreController.dispose();
    edadController.dispose();
    contrasenaController.dispose();
    repetirContrasenaController.dispose();
  }
}