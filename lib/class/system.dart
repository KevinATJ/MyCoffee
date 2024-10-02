import 'user.dart';
import 'recipe.dart';
import 'product.dart';

class System {
  List<User> userList;
  List<Recipe> recipeList;
  List<Product> productList;
  int id;

  System(this.userList, this.recipeList, this.productList, this.id);

  Recipe findRecipe(String name) {
    return recipeList.firstWhere((recipe) => recipe.name == name);
  }

  List<Recipe> filterRecipe({
    String? extractionTechnique,
    int? preparationTime,
    String? grainType,
    List<Product>? products,
  }) {
    return recipeList.where((recipe) {
      bool matches = true;
      if (extractionTechnique != null) {
        matches &= recipe.extractionTechnique == extractionTechnique;
      }
      if (preparationTime != null) {
        matches &= recipe.preparationTime <= preparationTime;
      }
      if (grainType != null) {
        matches &= recipe.grainType == grainType;
      }
      if (products != null && products.isNotEmpty) {
        // ignore: collection_methods_unrelated_type
        matches &= recipe.requirements.any((r) => products.contains(r));
      }
      return matches;
    }).toList();
  }
}
