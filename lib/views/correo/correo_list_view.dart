// lib/views/categoria_list_view.dart
import 'package:flutter/material.dart';
import 'package:crud/models/correo.dart';
import 'package:crud/services/api_services.dart';
import 'package:go_router/go_router.dart';

class CorreoListView extends StatefulWidget {
  const CorreoListView({super.key});

  @override
  State<CorreoListView> createState() => _CorreoListViewState();
}

class _CorreoListViewState extends State<CorreoListView> {
  late Future<List<Correo>> futureCorreo;

  @override
  void initState() {
    super.initState();
    futureCorreo = ApiService().getCorreos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Correos')),
      body: FutureBuilder<List<Correo>>(
        future: futureCorreo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Errors: ${snapshot.error}'));
          } else {
            final correo = snapshot.data!;
            return ListView.builder(
              itemCount: correo.length,
              itemBuilder: (context, index) {
                final categoria = correo[index];
                return ListTile(
                  title: Text(categoria.correo),
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
