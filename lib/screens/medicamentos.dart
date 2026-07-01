import 'package:flutter/material.dart';

class MedicamentosScreen extends StatelessWidget {
  const MedicamentosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medicamentos'), centerTitle: true),

      body: const Center(
        child: Text(
          'Aquí aparecerán tus medicamentos 💊',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
