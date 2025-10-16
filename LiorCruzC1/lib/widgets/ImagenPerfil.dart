import 'dart:io';
import 'package:flutter/foundation.dart'; 
import 'package:flutter/material.dart';
import 'package:cuaderno1/models/usuario.dart';
//widget custom para que la imagen pueda ser visualizada desde web(chrome) o desde el emulador de movil
class ImagenPerfil extends StatelessWidget {
  final Usuario usuario;
  final double size;

  const ImagenPerfil({
    Key? key,
    required this.usuario,
    this.size = 150.0,
  }) : super(key: key);

  @override
  //Sobreescribimos el widget build
  Widget build(BuildContext context) {
    if (usuario.imagen != null && usuario.imagen!.isNotEmpty) {//si la imagen no esta vacia devolvera estos valores
      if (kIsWeb) {
        //desde web
        return Image.network(
          usuario.imagen!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>//por si llega a fallar icono por defecto
              Icon(Icons.account_circle, size: size, color: Colors.grey),
        );
      } else {
        //desde android
        return Image.file(
          File(usuario.imagen!),
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>//por si llega a fallar icono por defecto
              Icon(Icons.account_circle, size: size, color: Colors.grey),
        );
      }
    } else {//icono por defecto si el usuario no escoge una imagen
      return Icon(Icons.account_circle, size: size, color: Colors.grey);
    }
  }
}
