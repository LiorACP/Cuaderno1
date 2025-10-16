class Usuario {
  final String trato;
  final String nombre;
  final String contrasena;
  final int edad;
  final String lugarNacimiento;
  final String? imagen;
  final bool aceptoTeminos;

  Usuario({
    required this.trato,
    required this.nombre,
    required this.contrasena,
    required this.edad,
    required this.lugarNacimiento,
    this.imagen,
    required this.aceptoTeminos
  });

  
}