class Correo {
  final String correo;

  Correo({required this.correo});

  factory Correo.fromJson(Map<String, dynamic> json) {
    return Correo(correo: json['correo ']);
  }
}
