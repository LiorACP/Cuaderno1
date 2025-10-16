import 'package:cuaderno1/utils/CustomButton.dart';
import 'package:cuaderno1/widgets/drawerGeneral.dart';
import 'package:flutter/material.dart';
import 'package:cuaderno1/screens/pantallaPrincipal.dart';

class Pantallainiciosesion extends StatefulWidget {
  const Pantallainiciosesion({super.key});

  @override
  State<Pantallainiciosesion> createState() => _PantallainiciosesionState();
}

class _PantallainiciosesionState extends State<Pantallainiciosesion> {
  void _Pantallaprincipal() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Pantallaprincipal()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      ////////////////////////////////////////APPBAR////////////////////////////////////////
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 101, 181, 247),
        title: Row(
          children: [
            /*Espacio entre el texto y el borde*/
            SizedBox(width: 5),
            Text(
              "Pagina Secundaria",
              style: TextStyle(color: Color.fromRGBO(10, 10, 10, 1)),
            ),
          ],
        ),
      ),
      ////////////////////////////////////////BODY////////////////////////////////////////
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 250),
              Container(
                width: 210,
                child: ElevatedButton(
                  style: customButtonStyle(),
                  onPressed: _Pantallaprincipal,
                  child: Row(
                    children: [Icon(Icons.house_rounded), Text("Pantalla Principal")],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
