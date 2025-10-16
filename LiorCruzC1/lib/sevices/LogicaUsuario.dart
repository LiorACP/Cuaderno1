import 'package:cuaderno1/models/usuario.dart';

class Logicausuario {
  Logicausuario._privateConstructor();
  static final Logicausuario instance = Logicausuario._privateConstructor();

  final List<Usuario> _users = [];//guarda los usuarios

  List<Usuario> get users => List.unmodifiable(_users);//Getter

  void addUser(Usuario u) {//añadir un usuario
    _users.add(u);
  }

  Usuario? findByUsername(String username) {//Busca un usuario cuyo nombre coincida con el username si no lo encuentra delvolvera null
    try {
      return _users.firstWhere((u) => u.nombre == username);
    } catch (e) {
      return null;
    }
  }

  bool authenticate(String username, String password) {//funcion de admin para el login
    if (username == 'admin' && password == 'admin') return true;
    final u = findByUsername(username);
    if (u == null) return false;
    return u.contrasena == password;
  }
}