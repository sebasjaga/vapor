import 'package:crud/models/categoria.dart';
import 'package:crud/models/correo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.20.14/vapor/public/api/v1';

  Future<List<Categoria>> getCategorias() async {
    final response = await http.get(Uri.parse('$baseUrl/categorias'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      List<dynamic> categoriasJson = body['categorias'];
      return categoriasJson
          .map((dynamic item) => Categoria.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<Categoria> getCategoria(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/categoria/$id'));
    if (response.statusCode == 200) {
      return Categoria.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load category');
    }
  }

  Future<void> createCategoria(Categoria categoria) async {
    final response = await http.post(
      Uri.parse('$baseUrl/categoria/store'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(categoria.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create category');
    }
  }

  Future<void> updateCategoria(Categoria categoria) async {
    final response = await http.post(
      Uri.parse('$baseUrl/categoria/update'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(categoria.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update category');
    }
  }

  //Se crea el FutureList para correo
  Future<List<Correo>> getCorreos() async {
    final response = await http.get(Uri.parse('$baseUrl/correos'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      List<dynamic> correosJson = body['correos'];
      return correosJson.map((dynamic item) => Correo.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load emails');
    }
  }

  Future<Correo> getCorreo(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/correo/$id'));
    if (response.statusCode == 200) {
      return Correo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load email');
    }
  }
}
