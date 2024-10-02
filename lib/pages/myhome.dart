import 'package:flutter/material.dart';
import 'package:my_coffee/class/recipe.dart';
import 'package:my_coffee/pages/recipedetails.dart';
import 'package:my_coffee/class/product.dart';
import 'package:my_coffee/pages/productdetails.dart';


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
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void showSearchMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Búsqueda realizada')),
    );
  }

  void showFilterMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Filtro aplicado')),
    );
  }

  bool isFavorite = false;
  List<bool> favoriteStates = [false, false, false, false];

  void changeFavorite() {
    setState(() {
      isFavorite = !isFavorite; 
    });
    if (isFavorite) {
      showFavoriteMessage();
    } else {
      showUnfavoriteMessage();
    }
  }

  void showFavoriteMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Añadido a favoritos')),
    );
  }

  void showUnfavoriteMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Eliminado de favoritos')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyCoffee Home'),
      ),
      backgroundColor: Colors.brown.shade100,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Kevin Troncoso'),
              accountEmail: Text('Kevintjara@gmail.com'),
              currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/icons/usuario.png'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Recetas favoritas'),
              onTap: () {
                Navigator.pushNamed(context, '/favorites');
              },
            ),
            ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text('Mis recetas'),
              onTap: () {
                Navigator.pushNamed(context, '/myrecipes');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: showFilterMessage,
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscador...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: showSearchMessage,
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Center(
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      createRecipeCard(context, 'Espresso Clásico', 'Café fuerte y concentrado con sabor intenso.', 1, 'assets/icons/CafeEspresso.png',0),
                      createRecipeCard(context, 'Cappucino', 'Combinación perfecta de espresso, leche vaporizada y espuma.', 2, 'assets/icons/CafeCappucino.png',1),
                      createRecipeCard(context, 'Flat White', 'Bebida suave con menos espuma y más leche que el cappuccino.', 3, 'assets/icons/CafeFlatWhite.png',2),
                      createRecipeCard(context, 'Mocha', 'Deliciosa combinación de espresso, chocolate y leche espumada.', 4, 'assets/icons/CafeMocha.png',3),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      const Text(
                        'Productos: Electrodomésticos e Ingredientes',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),
                      createProductCard(context, 'Máquina de espresso', 'Ideal para preparar espresso de alta calidad en casa.', 1),
                      createProductCard(context, 'Vaporizador de leche', 'Perfecto para espumar leche y crear texturas ideales para capuchinos y lattes.', 2),
                      createProductCard(context, 'Grano de café espresso', 'Granos seleccionados para hacer espresso, con un sabor fuerte y concentrado.', 3),
                      createProductCard(context, 'Leche espumosa', 'Ideal para preparar cafés con leche, capuchinos o lattes.', 4),
                    ],
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'About MyCoffee',
                          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'MyCoffee es una aplicación dedicada a los amantes del café. Aquí puedes descubrir nuevas recetas, compartir tus propias creaciones y aprender más sobre la preparación perfecta del café.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(text: 'Recetas', icon: Icon(Icons.book)),
          Tab(text: 'Productos', icon: Icon(Icons.kitchen)),
          Tab(text: 'About Us', icon: Icon(Icons.info)),
        ],
      ),
    );
  }

  Widget createRecipeCard(BuildContext context, String title, String description, int recipeId, String imagePath, int index) {
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
            favoriteStates[index] ? Icons.star : Icons.star_border_sharp,
          ),
          onPressed: () {
            setState(() {
              favoriteStates[index] = !favoriteStates[index];
            });
            if (favoriteStates[index]) {
              showFavoriteMessage();
            } else {
              showUnfavoriteMessage();
            }
          },
        ),
        onTap: () {
          Recipe selectedRecipe = Recipe.getRecipeById(recipeId);
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
  );
}

  Widget createProductCard(BuildContext context, String productName, String description, int productId) {
    return ListTile(
      leading: const Icon(Icons.kitchen_sharp),
      title: Text(productName),
      subtitle: Text(description),
      onTap: () {
        Product selectedProduct = Product.getProductById(productId);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(
              product: selectedProduct,
            ),
          ),
        );
      },
    );
  }
}

