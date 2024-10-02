import 'recipe.dart';

class User {
  String name = 'Kevin Troncoso';
  String email = 'Kevintjara@gmail.com';
  String image = 'assets/icons/usuario.png';
  List<Recipe> favorites;
  int id;

  User(this.name,this.email ,this.image,this.favorites, this.id);


  void createRecipe(Recipe recipe) {
  }

  void editRecipe(Recipe recipe) {
  }

  void deleteRecipe(Recipe recipe) {
  }

  void addToFavorite(Recipe recipe) {
    favorites.add(recipe);
  }

  void deleteFromFavorite(Recipe recipe) {
    favorites.remove(recipe);
  }

  void shareRecipe(Recipe recipe) {
  }

  void qualifyRecipe(Recipe recipe, int qualify) {
  }

  void commentRecipe(Recipe recipe, String commentary) {
  }
}
