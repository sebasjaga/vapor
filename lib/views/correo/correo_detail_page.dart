import 'package:flutter/material.dart';
//import 'package:go_router/go_router.dart';
import 'package:crud/models/correo.dart';
import 'package:crud/services/api_services.dart';

class CorreoDetailPage extends StatelessWidget {
  final int id;

  const CorreoDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de Correo')),
      body: FutureBuilder<Correo>(
        future: ApiService().getCorreo(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final correo = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('nombre: ${correo.correo}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
