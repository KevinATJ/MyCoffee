import 'package:flutter/material.dart';
import 'package:my_coffee/class/recipe.dart';
import 'package:share_plus/share_plus.dart';
import 'package:my_coffee/pages/recipeform.dart';

class MyRecipeDetails extends StatelessWidget {
  final Recipe recipe;

  const MyRecipeDetails({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeForm(
                    recipe: recipe, 
                  ),
                ),
              ).then((updatedRecipe) {
                if (updatedRecipe != null) {
                  final index = Recipe.MyRecipeList.indexWhere((r) => r.id == updatedRecipe.id);
                  if (index != -1) {
                    Recipe.MyRecipeList[index] = updatedRecipe;
                  }
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              String message = '''
              Receta: ${recipe.name}
              Tiempo de preparación: ${recipe.preparationTime} minutos
              Fecha de creación: ${recipe.date}
              
              Requisitos:
              ${recipe.requirements.join('\n')}
              
              Instrucciones:
              ${recipe.preparation}
              ''';
              Share.share(message);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(recipe.image),
            const SizedBox(height: 16.0),
            Text(recipe.name, style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.green),
                const SizedBox(width: 8.0),
                Text(
                  'Fecha: ${recipe.date}',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
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
            const Text('Requisitos:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            ...recipe.requirements.map((ingredient) => Text('- $ingredient')),
            const SizedBox(height: 16.0),
            const Text('Instrucciones:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text(recipe.preparation),
          ],
        ),
      ),
    );
  }
}





