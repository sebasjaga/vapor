import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:crud/models/categoria.dart';
import 'package:crud/services/api_services.dart';

class CategoriaFormPage extends StatefulWidget {
  final Categoria? categoria;

  const CategoriaFormPage({super.key, this.categoria});

  @override
  State<CategoriaFormPage> createState() => _CategoriaFormPageState();
}

class _CategoriaFormPageState extends State<CategoriaFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;

  @override
  void initState() {
    super.initState();
    
    _nombreController =
        TextEditingController(text: widget.categoria?.nombre_categoria?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.categoria == null
              ? 'Crear Categoría'
              : 'Editar Categoría')),
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
                    final categoria = Categoria(
                      id_categoria: widget.categoria?.id_categoria ?? 15,
                      nombre_categoria: _nombreController.text,
                    );
                    if (widget.categoria == null) {
                      ApiService().createCategoria(categoria);
                    } else {
                      ApiService().updateCategoria(categoria);
                    }
                    context.pop();
                  }
                },
                child: Text(widget.categoria == null ? 'Crear' : 'Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
