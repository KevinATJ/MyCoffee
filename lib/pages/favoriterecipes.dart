import 'package:flutter/material.dart';
import 'package:my_coffee/class/recipe.dart';
import 'package:my_coffee/pages/recipedetails.dart';

class FavoriteRecipes extends StatelessWidget {
  const FavoriteRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recetas Favoritas'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            child: ListTile(
              leading: Image.asset('assets/icons/CafeMocha.png'),
              title: const Text('Mocha'),
              subtitle: const Text('Deliciosa combinación de espresso, chocolate y leche espumada.'),
              onTap: () {
              int selectedRecipeId = 1; 
              Recipe selectedRecipe = Recipe.getFavoriteRecipeById(selectedRecipeId);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetails(
                    recipe: selectedRecipe, 
                  ),
                ),
              );
            },
            ),
          ),
        ],
      ),
    );
  }
}
