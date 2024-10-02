import 'package:flutter/material.dart';
import 'package:my_coffee/class/recipe.dart';

class RecipeDetails extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetails({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      backgroundColor: Colors.brown.shade100,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(recipe.image),
            const SizedBox(height: 16.0),
            Text(
              recipe.name,
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow),
                const SizedBox(width: 8.0),
                Text(
                  recipe.calification.toString(),
                  style: const TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.timer, color: Colors.blue),
                const SizedBox(width: 8.0),
                Text(
                  '${recipe.preparationTime} minutos',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Requisitos:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            ...recipe.requirements.map((ingredient) => Text('- $ingredient')),
            const SizedBox(height: 16.0),
            const Text(
              'Instrucciones:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(recipe.preparation),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Comentario añadido')),
                );
              },
              child: const Text('Añadir Comentario'),
            ),
          ],
        ),
      ),
    );
  }
}


