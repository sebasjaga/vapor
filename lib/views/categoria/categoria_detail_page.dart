import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:crud/models/categoria.dart';
import 'package:crud/services/api_services.dart';

class CategoriaDetailPage extends StatelessWidget {
  final int id;

  const CategoriaDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de Categoría')),
      body: FutureBuilder<Categoria>(
        future: ApiService().getCategoria(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final categoria = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('id: ${categoria.id_categoria}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('nombre: ${categoria.nombre_categoria}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          context.push('/edit/${categoria.id_categoria}');
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Aquí puedes agregar la lógica para eliminar la categoría
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
