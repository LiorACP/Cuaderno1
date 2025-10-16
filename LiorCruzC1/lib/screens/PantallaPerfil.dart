import 'package:flutter/material.dart';
import 'package:cuaderno1/utils/CustomButton.dart';
import 'package:cuaderno1/screens/pantallaPrincipal.dart';
import 'package:cuaderno1/widgets/drawerGeneral.dart';
import 'package:cuaderno1/widgets/ImagenPerfil.dart';
import 'package:cuaderno1/widgets/dato.dart';

class Pantallaperfil extends StatelessWidget {
  const Pantallaperfil({super.key});

  @override
  Widget build(BuildContext context) {
    // Comprobamos si hay usuario logueado
    final usuario = usuarioActual;

    if (usuario == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Mi perfil"),
          backgroundColor: const Color.fromARGB(255, 101, 181, 247),
        ),
        body: const Center(
          child: Text(
            "No hay un usuario logueado.",
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      ////////////////////////////////////////APPBAR////////////////////////////////////////
      appBar: AppBar(
        title: const Text("Mi perfil"),
        backgroundColor: const Color.fromARGB(255, 101, 181, 247),
      ),
      ////////////////////////////////////////BODY////////////////////////////////////////
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              //////////////////////////////////////////Imagen de perfil///////////////////////////////////////////////////
              //llama al widget ImagenPerfil
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: ImagenPerfil(usuario: usuario),
              ),

              const SizedBox(height: 20),

              ////////////////////////////////Información del usuario///////////////////////////////////////////////
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      dato(titulo: "Tratamiento:", valor: usuario.trato),
                      dato(titulo: "Nombre:", valor: usuario.nombre),
                      dato(titulo: "Edad:", valor: "${usuario.edad} años"),
                      dato(
                        titulo: "Lugar de nacimiento:",
                        valor: usuario.lugarNacimiento,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              /// Botón de cerrar sesión
              ElevatedButton(
                style: customButtonStyle2(),
                onPressed: () {
                  usuarioActual = null;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Pantallaprincipal(),
                    ),
                    (route) => false,
                  );
                },
                child: const Text("Cerrar sesión"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
