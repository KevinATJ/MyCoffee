import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:my_coffee/class/recipe.dart';
import 'package:my_coffee/utils/takepicturescreen.dart';

class RecipeForm extends StatefulWidget {
  final Recipe? recipe; 

  const RecipeForm({super.key, this.recipe});

  @override
  State<RecipeForm> createState() => _EditCreateRecipePageState();
}

class _EditCreateRecipePageState extends State<RecipeForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _preparationTimeController;
  late TextEditingController _dateController;
  late TextEditingController _requirementsController;
  late TextEditingController _preparationController;

  File? _image; 

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.recipe?.name ?? '');
    _preparationTimeController = TextEditingController(text: widget.recipe?.preparationTime.toString() ?? '');
    _dateController = TextEditingController(text: widget.recipe?.date ?? '');
    _requirementsController = TextEditingController(text: widget.recipe?.requirements.join(', ') ?? '');
    _preparationController = TextEditingController(text: widget.recipe?.preparation ?? '');
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _takePicture() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    // ignore: use_build_context_synchronously
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TakePictureScreen(camera: firstCamera),
      ),
    );

    if (result != null && result is File) {
      setState(() {
        _image = result;
      });
    }
  }

  void _saveRecipe() {
    if (_formKey.currentState!.validate()) {
      final recipe = Recipe(
        _nameController.text,
        '', 
        _requirementsController.text.split(','),
        _preparationController.text,
        int.tryParse(_preparationTimeController.text) ?? 0,
        '', 
        '', 
        _image?.path ?? widget.recipe?.image ?? 'assets/icons/my_coffeeicon.png', 
        widget.recipe?.id ?? DateTime.now().millisecondsSinceEpoch, 
        _dateController.text,
      );
      if (widget.recipe == null) {
        Recipe.MyRecipeList.add(recipe); 
      } else {
        final index = Recipe.MyRecipeList.indexWhere((r) => r.id == recipe.id);
        if (index != -1) Recipe.MyRecipeList[index] = recipe;
      }

      Navigator.pop(context, recipe);
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.recipe == null ? 'Crear Receta' : 'Editar Receta')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  final source = await showDialog<ImageSource>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Selecciona una imagen'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, ImageSource.gallery),
                          child: const Text('Galería'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, ImageSource.camera),
                          child: const Text('Cámara'),
                        ),
                      ],
                    ),
                  );
                  if (source == ImageSource.camera) {
                    await _takePicture();
                  } else if (source != null) {
                    await _pickImage(source);
                  }
                },
                child: _image != null
                    ? Image.file(_image!, height: 200)
                    : widget.recipe?.image != null
                        ? Image.asset(widget.recipe!.image, height: 200)
                        : Container(
                            height: 200,
                            color: Colors.grey[200],
                            child: const Center(child: Text('Selecciona una imagen')),
                          ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre de la receta'),
                validator: (value) => value!.isEmpty ? 'Este campo es requerido' : null,
              ),
              TextFormField(
                controller: _preparationTimeController,
                decoration: const InputDecoration(labelText: 'Tiempo de preparación (minutos)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Fecha de creación'),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    _dateController.text = date.toIso8601String().substring(0, 10);
                  }
                },
              ),
              TextFormField(
                controller: _requirementsController,
                decoration: const InputDecoration(labelText: 'Requisitos'),
              ),
              TextFormField(
                controller: _preparationController,
                decoration: const InputDecoration(labelText: 'Instrucciones de preparación'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveRecipe,
                child: Text(widget.recipe == null ? 'Crear Receta' : 'Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


