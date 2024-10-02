import 'package:flutter/material.dart';
import 'package:my_coffee/class/user.dart';

class Profile extends StatelessWidget {
  final User? user; 
  const Profile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Usuario'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit), 
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Perfil editado')),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(user?.image ?? 'assets/icons/usuario.png'), 
            ),
            const SizedBox(height: 20),
            Text('Nombre: ${user?.name ?? "Kevin Troncoso"}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text('Correo: ${user?.email ?? "Kevintjara@gmail.com"}', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}




