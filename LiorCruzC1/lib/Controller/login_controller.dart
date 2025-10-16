import 'package:flutter/material.dart';

class LoginController {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();

  void dispose() {
    nombreController.dispose();
    contrasenaController.dispose();
  }
}
