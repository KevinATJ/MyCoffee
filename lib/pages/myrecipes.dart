import 'package:flutter/material.dart';
import 'package:my_coffee/class/recipe.dart';
import 'package:my_coffee/pages/recipedetails.dart';

class MyRecipes extends StatelessWidget {
  const MyRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Recetas'),
      ),
      backgroundColor: Colors.brown.shade100,
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: [
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Receta creada')),
              );
            },
            child: const Text('Añadir nueva receta'),
          ),
          Card(
            elevation: 4.0, 
            child: Padding(
              padding: const EdgeInsets.all(16.0), 
              child: InkWell(
                onTap: () {
                  int selectedRecipeId = 1; 
                  Recipe selectedRecipe = Recipe.getUserRecipeById(selectedRecipeId);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetails(
                        recipe: selectedRecipe, 
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/CafeMacchiato.png',
                      width: 80.0,
                      height: 80.0,
                    ),
                    const SizedBox(width: 16.0),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Macchiato',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'Espresso "manchado" con un toque de leche espumada.',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Receta editada')),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.share),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Receta compartida')),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Receta eliminada')),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



