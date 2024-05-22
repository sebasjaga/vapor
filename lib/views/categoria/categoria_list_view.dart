// lib/views/categoria_list_view.dart
import 'package:flutter/material.dart';
import 'package:crud/models/categoria.dart';
import 'package:crud/services/api_services.dart';
import 'package:go_router/go_router.dart';

class CategoriaListView extends StatefulWidget {
  const CategoriaListView({super.key});

  @override
  State<CategoriaListView> createState() => _CategoriaListViewState();
}

class _CategoriaListViewState extends State<CategoriaListView> {
  late Future<List<Categoria>> futureCategorias;

  @override
  void initState() {
    super.initState();
    futureCategorias = ApiService().getCategorias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categorías')),
      body: FutureBuilder<List<Categoria>>(
        future: futureCategorias,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Errors: ${snapshot.error}'));
          } else {
            final categorias = snapshot.data!;
            return ListView.builder(
              itemCount: categorias.length,
              itemBuilder: (context, index) {
                final categoria = categorias[index];
                return ListTile(
                  title: Text(categoria.nombre_categoria),
                  onTap: () {
                    // context.push('/categoria/${categoria.id}');
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/create');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
