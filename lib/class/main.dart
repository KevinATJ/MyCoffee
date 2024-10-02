import 'package:flutter/material.dart';
import 'package:my_coffee/pages/login.dart';
import 'package:my_coffee/pages/myhome.dart';
import 'package:my_coffee/pages/profile.dart';
import 'package:my_coffee/pages/favoriterecipes.dart';
import 'package:my_coffee/pages/myrecipes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyCoffee',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown), 
        useMaterial3: true,
      ),
      initialRoute: '/login', 
      routes: {
        '/login': (context) => const Login(), 
        '/myhome': (context) => const Myhome(),
        '/profile': (context) =>  const Profile(user: null),
        '/favorites': (context) => const FavoriteRecipes(), 
        '/myrecipes': (context) => const MyRecipes(), 
      },
    );
  }
}
