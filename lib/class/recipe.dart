class Recipe {
  String name;
  String description;
  List<String> requirements;
  String preparation;
  int preparationTime;
  String extractionTechnique;
  String grainType;
  String image;
  int id;
  String date; 

  Recipe(
    this.name,
    this.description,
    this.requirements,
    this.preparation,
    this.preparationTime,
    this.extractionTechnique,
    this.grainType,
    this.image,
    this.id,
    this.date, 
  );

  static List<Recipe> recentRecipes = [];

  static void addRecentRecipe(Recipe recipe) {

    if (recentRecipes.contains(recipe)) {
      recentRecipes.remove(recipe); 
    }
    recentRecipes.insert(0, recipe);
    if (recentRecipes.length > 10) {
      recentRecipes.removeLast();
    }
  }

  static List<Recipe> baristaRecipeList = [
    Recipe(
      'Espresso Clásico',
      'Descripción de la receta 1',
      ['18-20g de café molido fino', 'Máquina de espresso'],
      '1) Precalienta la máquina de espresso(5 minutos).\n\n2) Coloca el café molido en el portafiltro y compacta ligeramente(2 minutos).\n\n3) Extrae el espresso en una taza de 25-30 ml.(1 minuto).\n\n4) Sirve y disfruta!!.\n\n',
      8,
      '',
      '',
      'assets/icons/CafeEspresso.png',
      1,
      '2024-11-13', 
    ),
    Recipe(
      'Cappuccino',
      'Descripción de la receta 2',
      ['18g de café espresso', '120ml de leche', 'Máquina de espresso', 'Vaporizador de leche'],
      '1) Prepara un shot de espresso(2 minutos).\n\n2) Calienta y vaporiza la leche hasta que forme espuma(3 minutos).\n\n3) Vierte la leche sobre el espresso, creando una capa de espuma en la parte superior(1 minuto).\n\n4) Espolvorea cacao en polvo(1 minuto).\n\n5) Sirve y disfruta!!.\n\n',
      7,
      '',
      '',
      'assets/icons/CafeCappucino.png',
      2,
      '2024-11-13',
    ),
    Recipe(
      'Flat White',
      'Descripción de la receta 3',
      ['18g de café espresso ', '150ml de leche', 'Máquina de espresso', 'Vaporizador de leche'],
      '1) Prepara un shot de espresso(2 minutos).\n\n2) Vaporiza la leche, sin dejar que forme demasiada espuma(3 minutos).\n\n3) Vierte la leche sobre el espresso, dejando una capa muy fina de espuma(1 minuto).\n\n4) Sirve y disfruta!!.\n\n',
      6,
      '',
      '',
      'assets/icons/CafeFlatWhite.png',
      3,
      '2024-11-13',
    ),
    Recipe(
      'Mocha',
      'Descripción de la receta 4',
      ['18g de café espresso ', '2 cucharadas de chocolate en polvo o jarabe de chocolate','120ml de leche' ,'Máquina de espresso', 'Vaporizador de leche'],
      '1) Prepara un shot de espresso(2 minutos).\n\n2) Mezcla el chocolate con el espresso(1 minuto).\n\n3) Vaporiza la leche y viértela sobre la mezcla de chocolate y café(3 minutos).\n\n4) Añade una pequeña capa de espuma en la parte superior(1 minuto).\n\n4) Decora con crema batida o más chocolate(1 minuto).\n\n5) Sirve y disfruta!!.\n\n',
      8,
      '',
      '',
      'assets/icons/CafeMocha.png',
      4,
      '2024-11-13',
    ),

  ];

  static List<Recipe> MyRecipeList = [ ];


  static Recipe getRecipeById(int id) {
    return baristaRecipeList.firstWhere((recipe) => recipe.id == id);
  }

  static Recipe getMyRecipeById(int id) {
    return MyRecipeList.firstWhere((recipe) => recipe.id == id);
  }

  static void removeRecipe(int index) {
    MyRecipeList.removeAt(index);
  }
}


