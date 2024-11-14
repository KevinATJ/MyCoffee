import 'package:flutter/material.dart';
import 'package:my_coffee/class/recipe.dart';
import 'package:my_coffee/pages/baristarecipes.dart';
import 'package:my_coffee/pages/myrecipesdetails.dart';
import 'package:my_coffee/pages/recipeform.dart';
import 'package:my_coffee/pages/surveyform.dart'; 

class Myhome extends StatefulWidget {
  const Myhome({super.key});

  @override
  State<Myhome> createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);


    _tabController.addListener(() {
      setState(() {}); 
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyCoffee Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.feedback),
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SurveyForm()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.brown.shade100,
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Center(
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      createBaristaRecipeCard(context, 'Espresso Clásico', 'Café fuerte y concentrado con sabor intenso.', 1, 'assets/icons/CafeEspresso.png', 0),
                      createBaristaRecipeCard(context, 'Cappucino', 'Combinación perfecta de espresso, leche vaporizada y espuma.', 2, 'assets/icons/CafeCappucino.png', 1),
                      createBaristaRecipeCard(context, 'Flat White', 'Bebida suave con menos espuma y más leche que el cappuccino.', 3, 'assets/icons/CafeFlatWhite.png', 2),
                      createBaristaRecipeCard(context, 'Mocha', 'Deliciosa combinación de espresso, chocolate y leche espumada.', 4, 'assets/icons/CafeMocha.png', 3),
                    ],
                  ),
                ),
                createMyRecipeCard(context),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Recipe.recentRecipes.isEmpty
                        ? const Text(
                            'No tienes recetas recientes.',
                            style: TextStyle(fontSize: 18.0, color: Colors.grey),
                          )
                        : ListView.builder(
                            itemCount: Recipe.recentRecipes.length,
                            itemBuilder: (context, index) {
                              final recipe = Recipe.recentRecipes[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  leading: Image.asset(recipe.image, width: 50.0, height: 50.0),
                                  title: Text(recipe.name),
                                  subtitle: Text("Tiempo: ${recipe.preparationTime} min"),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyRecipeDetails(recipe: recipe),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(text: 'Barista', icon: Icon(Icons.book)),
          Tab(text: 'Mis recetas', icon: Icon(Icons.folder)),
          Tab(text: 'Recetas recientes', icon: Icon(Icons.history)),
        ],
      ),
      floatingActionButton: _tabController.index == 1
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecipeForm(), 
                  ),
                );
              },
              child: const Icon(Icons.add),
            )
          : null, 
    );
  }

Widget createBaristaRecipeCard(BuildContext context, String title, String description, int recipeId, String imagePath, int index) {
  bool isAddedToMyRecipes = false; 

  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    elevation: 4.0,
    child: SizedBox(
      width: 300,
      height: 150,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: SizedBox(
          width: 90,
          height: 90,
          child: Image.asset(imagePath),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18.0),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(fontSize: 16.0),
        ),
        trailing: IconButton(
          icon: Icon(
            isAddedToMyRecipes ? Icons.check : Icons.add,
            color: Colors.brown,
          ),
          onPressed: () {
            setState(() {
              isAddedToMyRecipes = !isAddedToMyRecipes;

              if (isAddedToMyRecipes) {
                Recipe selectedRecipe = Recipe.getRecipeById(recipeId);
                Recipe newRecipe = Recipe(
                  selectedRecipe.name,
                  selectedRecipe.description,
                  List<String>.from(selectedRecipe.requirements),
                  selectedRecipe.preparation,
                  selectedRecipe.preparationTime,
                  selectedRecipe.extractionTechnique,
                  selectedRecipe.grainType,
                  selectedRecipe.image,
                  _generateUniqueId(), 
                  selectedRecipe.date,
                );

                Recipe.MyRecipeList.add(newRecipe);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Añadido a Mis recetas')),
                );
              }
            });
          },
        ),
        onTap: () {
          Recipe selectedRecipe = Recipe.getRecipeById(recipeId);
          Recipe.addRecentRecipe(selectedRecipe); 
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BaristaRecipes(
                recipe: selectedRecipe,
              ),
            ),
          );
        },
      ),
    ),
  );
}
int _generateUniqueId() {
  int maxId = Recipe.MyRecipeList.isEmpty
      ? 0
      : Recipe.MyRecipeList.map((e) => e.id).reduce((a, b) => a > b ? a : b);

  return maxId + 1;
}

  Widget createMyRecipeCard(BuildContext context) {
    if (Recipe.MyRecipeList.isEmpty) {
      return const Center(
        child: Text(
          "No tienes recetas agregadas en Mis Recetas",
          style: TextStyle(fontSize: 18.0, color: Colors.grey),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: Recipe.MyRecipeList.length,
        itemBuilder: (context, index) {
          final recipe = Recipe.MyRecipeList[index];
          return Card(
            child: ListTile(
              leading: Image.asset(recipe.image, width: 50.0, height: 50.0),
              title: Text(recipe.name),
              subtitle: Text("Tiempo: ${recipe.preparationTime} min"),
              onTap: () {
                Recipe.addRecentRecipe(recipe);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyRecipeDetails(recipe: recipe),
                  ),
                );
              },
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirmar eliminación'),
                      content: const Text('¿Estás seguro de que quieres eliminar esta receta?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); 
                          },
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              Recipe.removeRecipe(index);
                            });
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Receta eliminada')),
                            );
                          },
                          child: const Text('Eliminar'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    }
  }
}







