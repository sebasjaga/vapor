class Categoria {
  final int id_categoria;
  final String nombre_categoria;

  Categoria({required this.id_categoria, required this.nombre_categoria});

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id_categoria: json['id_categoria'] is int
          ? json['id_categoria']
          : int.parse(json['id_categoria'].toString()),
      nombre_categoria: json['nombre_categoria'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_categoria': id_categoria,
      'nombre_categoria': nombre_categoria,
    };
  }
}
