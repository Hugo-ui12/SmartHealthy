import 'package:flutter/material.dart';

class HistorialScreen extends StatelessWidget {
  const HistorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historial médico'), centerTitle: true),

      body: const Center(
        child: Text(
          'Aquí aparecerá tu historial 📄',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
