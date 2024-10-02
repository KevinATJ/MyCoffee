import 'commentary.dart';

class Recipe {
  String name;
  String description;
  List<String> requirements;
  String preparation;
  int preparationTime;
  String extractionTechnique;
  String grainType;
  double calification;
  String image;
  int id;
  List<Commentary> comments;

  Recipe(
      this.name,
      this.description,
      this.requirements,
      this.preparation,
      this.preparationTime,
      this.extractionTechnique,
      this.grainType,
      this.calification,
      this.image,
      this.id,
      this.comments);

  static List<Recipe> recipeList = [
    Recipe(
      'Espresso Clásico',
      'Descripción de la receta 1',
      ['18-20g de café molido fino', 'Máquina de espresso'],
      '1) Precalienta la máquina de espresso(5 minutos).\n\n2) Coloca el café molido en el portafiltro y compacta ligeramente(2 minutos).\n\n3) Extrae el espresso en una taza de 25-30 ml.(1 minuto).\n\n4) Sirve y disfruta!!.\n\n',
      8,
      '',
      '',
      4.5,
      'assets/icons/CafeEspresso.png',
      1,
      [],
    ),
    Recipe(
      'Cappuccino',
      'Descripción de la receta 2',
      ['18g de café espresso', '120ml de leche', 'Máquina de espresso', 'Vaporizador de leche'],
      '1) Prepara un shot de espresso(2 minutos).\n\n2) Calienta y vaporiza la leche hasta que forme espuma(3 minutos).\n\n3) Vierte la leche sobre el espresso, creando una capa de espuma en la parte superior(1 minuto).\n\n4) Espolvorea cacao en polvo(1 minuto).\n\n5) Sirve y disfruta!!.\n\n',
      7,
      '',
      '',
      4.0,
      'assets/icons/CafeCappucino.png',
      2,
      [],
    ),
    Recipe(
      'Flat White',
      'Descripción de la receta 3',
      ['18g de café espresso ', '150ml de leche', 'Máquina de espresso', 'Vaporizador de leche'],
      '1) Prepara un shot de espresso(2 minutos).\n\n2) Vaporiza la leche, sin dejar que forme demasiada espuma(3 minutos).\n\n3) Vierte la leche sobre el espresso, dejando una capa muy fina de espuma(1 minuto).\n\n4) Sirve y disfruta!!.\n\n',
      6,
      '',
      '',
      3.5,
      'assets/icons/CafeFlatWhite.png',
      3,
      [],
    ),
    Recipe(
      'Mocha',
      'Descripción de la receta 4',
      ['18g de café espresso ', '2 cucharadas de chocolate en polvo o jarabe de chocolate','120ml de leche' ,'Máquina de espresso', 'Vaporizador de leche'],
      '1) Prepara un shot de espresso(2 minutos).\n\n2) Mezcla el chocolate con el espresso(1 minuto).\n\n3) Vaporiza la leche y viértela sobre la mezcla de chocolate y café(3 minutos).\n\n4) Añade una pequeña capa de espuma en la parte superior(1 minuto).\n\n4) Decora con crema batida o más chocolate(1 minuto).\n\n5) Sirve y disfruta!!.\n\n',
      8,
      '',
      '',
      5.0,
      'assets/icons/CafeMocha.png',
      4,
      [],
    ),
  ];

  static List<Recipe> favoriteRecipeList = [
    Recipe(
      'Mocha',
      'Descripción de la receta favorita',
      ['18g de café espresso ', '2 cucharadas de chocolate en polvo o jarabe de chocolate','120ml de leche' ,'Máquina de espresso', 'Vaporizador de leche'],
      '1) Prepara un shot de espresso(2 minutos).\n\n2) Mezcla el chocolate con el espresso(1 minuto).\n\n3) Vaporiza la leche y viértela sobre la mezcla de chocolate y café(3 minutos).\n\n4) Añade una pequeña capa de espuma en la parte superior(1 minuto).\n\n4) Decora con crema batida o más chocolate(1 minuto).\n\n5) Sirve y disfruta!!.\n\n',
      8,
      '',
      '',
      5.0,
      'assets/icons/CafeMocha.png',
      4,
      [],
    ),

  ];

  static List<Recipe> userRecipeList = [
    Recipe(
      'Macchiato',
      'Descripción de la receta creada',
      ['18g de café espresso ', 'Una pequeña cantidad de leche','Máquina de espresso', 'Vaporizador de leche'],
      '1) Prepara un shot de espresso(2 minutos).\n\n2) Vaporiza un poco de leche, creando una pequeña cantidad de espuma(2 minutos).\n\n3) Añade una cucharada de espuma de leche sobre el espresso(1 minutos).\n\n4) Sirve y disfruta!!.\n\n',
      5,
      '',
      '',
      3.0,
      'assets/icons/CafeMacchiato.png',
      4,
      [],
    ),

  ];

  static Recipe getRecipeById(int id) {
    return recipeList.firstWhere((recipe) => recipe.id == id);
  }

  static Recipe getFavoriteRecipeById(int id) {
    return favoriteRecipeList.firstWhere((recipe) => 1 == id);
  }

  static Recipe getUserRecipeById(int id) {
    return userRecipeList.firstWhere((recipe) => 1 == id);
  }




}

