import 'package:flutter/material.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil'), centerTitle: true),

      body: const Center(
        child: Text(
          'Aquí aparecerá tu perfil 👤',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
