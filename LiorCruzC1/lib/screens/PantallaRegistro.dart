import 'package:flutter/material.dart';
import 'package:cuaderno1/sevices/LogicaUsuario.dart';
import 'package:cuaderno1/screens/pantallaPrincipal.dart';
import 'package:cuaderno1/utils/camera.dart';
import 'package:cuaderno1/utils/CustomButton.dart';
import 'package:cuaderno1/models/usuario.dart';
import 'package:cuaderno1/Controller/registro-controller.dart';

class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({super.key});

  @override
  State<PantallaRegistro> createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  ////////////////////////////// declaracion de variables //////////////////////////////
  final _formKey = GlobalKey<FormState>();

  final RegistroController _controller = RegistroController();

  bool _aceptoTerminos = false;
  String? photoPath;
  String selectedOption = "Zaragoza";
  int? _sr;
  String? _tratoSeleccionado;
  ////////////////////////////// logica de navegacion //////////////////////////////
  
  void dispose() {
  _controller.dispose(); // Libera los controladores(evita fugas de memoria)
  super.dispose();
}
  void _Pantallaprincipal() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Pantallaprincipal()),
    );
  }
  ////////////////////////////// registro de usuario //////////////////////////////
  void _registrarUsuario() {
    if (_formKey.currentState!.validate()) {//Comprueba si todos los campos del formulario son válidos
      if (_controller.contrasenaController.text != _controller.repetirContrasenaController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Las contraseñas no coinciden")),
        );
        return;
      }
      if (!_aceptoTerminos) {//Comprueba si el usuario a aceptado los terminos
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Debes aceptar los términos y condiciones"),
          ),
        );
        return;
      }
      if (_sr == null) {//Comprueba si el usuario a escogido un tratamiento
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Debes elegir que trato quiere")),
        );
        return;
      }
      
      final nuevoUsuario = Usuario(//construye un objeto Usuario con todos los datos recolectados del formulario
        trato: _tratoSeleccionado ?? "Sr/Sra",
        nombre: _controller.nombreController.text,
        contrasena: _controller.contrasenaController.text,
        edad: int.parse(_controller.edadController.text),
        lugarNacimiento: selectedOption,
        imagen: photoPath,
        aceptoTeminos: _aceptoTerminos,
      );

      Logicausuario.instance.addUser(nuevoUsuario);//añade el nuevo usuario

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario registrado con éxito')),
      );

      _Pantallaprincipal();
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
          "Pantalla de Registro",
          style: TextStyle(color: Colors.white),
        ),
      ),
      ////////////////////////////////////////BODY////////////////////////////////////////
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                /////////////////////////Tratamiento/////////////////////////
                Container(
                  width: 350,
                  child: Row(
                    children: [
                      const Text("Tratamiento: "),
                      const SizedBox(width: 10),
                      Row(
                        children: [
                          Radio<int>(//Widget de tipo radio que acepta valores enteros (0 para "Sr.")
                            value: 0,
                            groupValue: _sr,
                            onChanged: (int? value) {//Se actualiza el estado de _sr con el nuevo valor "Sr"
                              setState(() {
                                _sr = value;
                                _tratoSeleccionado = "Sr.";
                              });
                            },
                          ),
                          const Text("Sr."),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Row(
                        children: [
                          Radio<int>(//Widget de tipo radio que acepta valores enteros (1 para "Sra.")
                            value: 1,
                            groupValue: _sr,
                            onChanged: (int? value) {//Se actualiza el estado de _sr con el nuevo valor "Sra"
                              setState(() {
                                _sr = value;
                                _tratoSeleccionado = "Sra.";
                              });
                            },
                          ),
                          const Text("Sra."),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                /////////////////////////////Formulario/////////////////////////////
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
                    validator: (value) {//comprueva que el campo no este vacio
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
                    obscureText: true, //es para que la contraseña no se vea
                    decoration: InputDecoration(
                      labelText: "Contraseña",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {//comprueva que el campo no este vacio
                      if (value == null || value.isEmpty) {
                        return "Este campo es obligatorio";
                      }
                      if (value.length < 4) {
                        return "La contraseña debe tener al menos 4 caracteres";
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 10),
                // Form repetir contraseña
                Container(
                  width: 350,
                  child: TextFormField(
                    controller: _controller.repetirContrasenaController,
                    obscureText: true, //es para que la contraseña no se vea
                    decoration: InputDecoration(
                      labelText: "Repetir Contraseña",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {//comprueva que el campo no este vacio
                      if (value == null || value.isEmpty) {
                        return "Este campo es obligatorio";
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 20),
                /////////////////////Añadir Imagen/////////////////////
                Container(
                  width: 350,
                  child: Row(
                    children: [
                      const Text("Añadir imagen"),
                      const SizedBox(width: 20),
                      Container(
                        width: 170,
                        child: ElevatedButton(
                          style: customButtonStyle2(),
                          onPressed: () {
                            showDialog(//ventana emergente que contiuene los boontes de galeria y camara
                              context: context,
                              builder: (_) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    15,
                                  ),
                                ),
                                title: const Text("Escoge una opcion"),
                                content: Text(
                                  "Seleccione el origen de la imagen:",
                                ),
                                actions: [
                                  TextButton.icon(//funcion para que el ususrio escoga una imagen desde la galeria
                                    icon: Icon(Icons.photo_library),
                                    label: Text("Galeria"),
                                    onPressed: () async {
                                      final path = await CameraGalleryService()
                                          .selectPhoto();
                                      if (path == null) return;
                                      setState(() {
                                        photoPath = path;
                                      });
                                    },
                                  ),

                                  TextButton.icon(//funcion para que el ususrio tome una foto desde su camara
                                    icon: Icon(Icons.camera_alt),
                                    label: Text("Camara"),
                                    onPressed: () async {
                                      final path = await CameraGalleryService()
                                          .takePhoto();
                                      if (path == null) return;
                                      setState(() {
                                        photoPath = path;
                                      });
                                    },
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cerrar"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text("Cargar Imagen"),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                /////////////////////////////Formulario/////////////////////////////
              // Form edad
                Container(
                  width: 350,
                  child: TextFormField(
                    controller: _controller.edadController,
                    decoration: InputDecoration(
                      labelText: "Edad",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {//comprueva que el campo no este vacio
                      if (value == null || value.isEmpty) {
                        return "Campo obligatorio";
                      }
                      final edad = int.tryParse(value);//comprueba que sea una letra o numero negativo
                      if (edad == null || edad <= 0) {
                        return "Ingrese una edad válida";
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 20),
                /////////////////////////////Desplegable/////////////////////////////
                Container(
                  width: 350,
                  child: DropdownButtonFormField<String>(//cada cadena del array se convierte en un DropdownMenuItem<String>
                    value: selectedOption,
                    items: <String>['Zaragoza', 'Huesca', 'Teruel']
                        .map(
                          (value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    onChanged: (String? newValue) {//Función que se ejecuta cuando el usuario selecciona una opción diferente
                      setState(() {
                        selectedOption = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      label: const Text("Lugar de nacimiento"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                /////////////////////////////Terminos/////////////////////////////
                Container(
                  width: 350,
                  child: CheckboxListTile(
                    title: const Text("Aceptar términos y condiciones"),
                    value: _aceptoTerminos,
                    onChanged: (bool? value) {
                      setState(() {
                        _aceptoTerminos = value ?? false;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 30),
                /////////////////////////////Botones/////////////////////////////
                Container(
                  width: 150,
                  child: ElevatedButton(
                    style: customButtonStyle(),
                    onPressed: _registrarUsuario,
                    child: const Text("Aceptar"),
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  width: 130,
                  child: ElevatedButton(
                    style: customButtonStyle2(),
                    onPressed: _Pantallaprincipal,
                    child: const Text("Cancelar"),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}