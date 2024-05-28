import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:crud/models/correo.dart';
import 'package:crud/services/api_services.dart';

class CorreoFormPage extends StatefulWidget {
  final Correo? correo;

  const CorreoFormPage({super.key, this.correo});

  @override
  State<CorreoFormPage> createState() => _CorreoFormPageState();
}

class _CorreoFormPageState extends State<CorreoFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;

  @override
  void initState() {
    super.initState();

    _nombreController =
        TextEditingController(text: widget.correo?.correo ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              widget.correo == null ? 'Crear Categoría' : 'Editar Categoría')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripción';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final categoria = Correo(
                      correo: _nombreController.text,
                    );
                    if (widget.correo == null) {
                      ApiService().createCorreo(categoria);
                    } else {
                      ApiService().updateCorreo(categoria);
                    }
                    context.pop();
                  }
                },
                child: Text(widget.correo == null ? 'Crear' : 'Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
