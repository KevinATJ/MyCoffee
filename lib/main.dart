import 'package:flutter/material.dart';
import 'package:my_coffee/pages/myhome.dart';


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
      initialRoute: '/myhome', 
      routes: {
        '/myhome': (context) => const Myhome(),
        //'/myrecipes': (context) => const MyRecipes(), 
      },
    );
  }
}
