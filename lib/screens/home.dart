import 'package:flutter/material.dart';
import 'citas.dart';
import 'medicamentos.dart';
import 'historial.dart';
import 'perfil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text('SmartHealth Connect'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              const SizedBox(height: 20),

              Image.asset('assets/images/logo2.png', width: 120),

              const SizedBox(height: 20),

              const Text(
                'Hola Hugo 👋',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text(
                '¿Cómo te sientes hoy?',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),

              const SizedBox(height: 35),

              Card(
                elevation: 5,

                child: ListTile(
                  leading: const Icon(Icons.medical_services, size: 35),

                  title: const Text('Citas médicas'),

                  subtitle: const Text('Gestiona tus consultas'),

                  onTap: () {
                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (context) => const CitasScreen(),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 15),

              Card(
                elevation: 5,

                child: ListTile(
                  leading: const Icon(Icons.medication, size: 35),

                  title: const Text('Medicamentos'),

                  subtitle: const Text('Controla tus medicamentos'),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MedicamentosScreen(),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 15),

              Card(
                elevation: 5,

                child: ListTile(
                  leading: const Icon(Icons.description, size: 35),

                  title: const Text('Historial médico'),

                  subtitle: const Text('Revisa tus registros'),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HistorialScreen(),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 15),

              Card(
                elevation: 5,

                child: ListTile(
                  leading: const Icon(Icons.person, size: 35),

                  title: const Text('Perfil'),

                  subtitle: const Text('Información personal'),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PerfilScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
