import 'package:cuaderno1/sevices/LogicaUsuario.dart';
import 'package:cuaderno1/utils/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:cuaderno1/screens/PantallaRegistro.dart';
import 'package:cuaderno1/screens/PantallaInicioSesion.dart';
import 'package:cuaderno1/widgets/drawerGeneral.dart';
import 'package:cuaderno1/models/usuario.dart';
import 'package:cuaderno1/controller/login_controller.dart';

class Pantallaprincipal extends StatefulWidget {
  @override
  State<Pantallaprincipal> createState() => _PantallaprincipalState();
}

class _PantallaprincipalState extends State<Pantallaprincipal> {
  final _formKey = GlobalKey<FormState>();
  final LoginController _controller = LoginController();

  void dispose() {
  _controller.dispose(); // Libera los controladores(evita fugas de memoria)
  super.dispose();
}

  void _PantallaRegistro() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PantallaRegistro()),
    );
  }

  void _Pantallainiciosesion() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Pantallainiciosesion()),
    );
  }

  void _validarCampos() {
    if (_formKey.currentState!.validate()) {//Comprueba si todos los campos del formulario son válidos
      final username = _controller.nombreController.text.trim();
      final password = _controller.contrasenaController.text.trim();


      final logica = Logicausuario.instance;
      final autenticado = logica.authenticate(username, password);

      if (autenticado) {//valores si entras como admin
        if (username == 'admin') {
          usuarioActual = Usuario(
            trato: "Administrador",
            nombre: "admin",
            contrasena: "admin",
            edad: 0,
            lugarNacimiento: "Sistema",
            imagen: "",
            aceptoTeminos: true,
          );
        } else {
          usuarioActual = logica.findByUsername(username);
        }

        _Pantallainiciosesion();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Usuario o contraseña incorrectos")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ////////////////////////////////////////APPBAR////////////////////////////////////////
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 101, 181, 247),
        title: const Text(
          "Pantalla Principal",
          style: TextStyle(color: Color.fromRGBO(10, 10, 10, 1)),
        ),
      ),
      ////////////////////////////////////////BODY////////////////////////////////////////
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 100),
                Image.asset("assets/images/icons8-youtube-150.png"),
                const SizedBox(height: 20),

                // Form nombre
                Container(
                  width: 350,
                  child: TextFormField(
                    controller: _controller.nombreController,
                    decoration: InputDecoration(
                      labelText: "Nombre",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Este campo es obligatorio";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),

                // Form contraseña
                Container(
                  width: 350,
                  child: TextFormField(
                    controller: _controller.contrasenaController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Contraseña",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Este campo es obligatorio";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30),

                // Botón de inicio
                Container(
                  width: 170,
                  child: ElevatedButton(
                    style: customButtonStyle(),
                    onPressed: _validarCampos,
                    child: const Text("Iniciar Sesión"),
                  ),
                ),
                const SizedBox(height: 10),

                // Botón de registro
                Container(
                  width: 150,
                  child: ElevatedButton(
                    style: customButtonStyle2(),
                    onPressed: _PantallaRegistro,
                    child: const Text("Registrarse"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
