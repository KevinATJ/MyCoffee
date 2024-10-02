class Product {
  String name;
  String type;
  String description;
  String use;
  String image;
  int id;

  Product(this.name, this.type, this.description, this.image, this.id, this.use);

  static List<Product> productList = [
    Product(
      'Máquina de espresso',
      'Electrodoméstico',
      'Permite controlar la presión y temperatura para un sabor auténtico.',
      'assets/icons/maquinaDeEspresso.png',
      1,
      'Llena el portafiltro con café molido, nivela y compacta. Inserta el portafiltro y extrae el espresso en 25-30 segundos para obtener un sabor óptimo.\n',
    ),
    Product(
      'Vaporizador de leche',
      'Electrodoméstico',
      'Facilita la creación de bebidas con leche en casa.',
      'assets/icons/VaporizadorDeLeche.png',
      2,
      'Introduce la varilla a 1 cm debajo de la superficie de la leche. Gira el vaporizador y mueve lentamente el recipiente hacia abajo para espumar.\n',
      
    ),
    Product(
      'Grano de café espresso',
      'Ingrediente',
      'Perfecto para disfrutar en café solo o como base para otras bebidas.',
      'assets/icons/cafeGranoEspresso.png',
      3,
      'Úsalo como base para bebidas como el cappuccino, latte o simplemente disfrútalo solo en una taza pequeña.',
    ),
    Product(
      'Leche espumosa',
      'Ingrediente',
      'Especializada en añadir una textura cremosa y un sabor suave a las bebidas de café.',
      'assets/icons/lecheEspumosa.png',
      4,
      'Úsala como topping en cappuccinos, lattes o macchiatos. Añade la leche espumada al café despacio para crear una textura cremosa.',
    ),

  ];

  static Product getProductById(int id) {
    return productList.firstWhere((product) => product.id == id);
  }
}

