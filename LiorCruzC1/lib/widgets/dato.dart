import 'package:flutter/material.dart';
// Widget para mostrar cada línea de información de PantallaPerfil
class dato extends StatelessWidget {
  final String titulo;//variables
  final String valor;

  const dato ({//Constructor const
    Key? key,
    required this.titulo,
    required this.valor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {//Sobrescribe el método build
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            titulo,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Expanded(//Usa Expanded para que el valor ocupe todo el espacio y si es demasiado largo saldra "..."
            child: Text(
              valor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
