import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../services/bluetooth_service.dart';

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({super.key});

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  final SmartBluetoothService bluetoothService = SmartBluetoothService();

  bool buscando = false;

  Future<void> buscarDispositivos() async {
    setState(() {
      buscando = true;
    });

    try {
      await bluetoothService.buscarDispositivos();

      await Future.delayed(const Duration(seconds: 10));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al buscar dispositivos: $e')),
        );
      }
    }

    if (mounted) {
      setState(() {
        buscando = false;
      });
    }
  }

  @override
  void dispose() {
    bluetoothService.detenerBusqueda();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bluetooth'), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const Icon(Icons.bluetooth, size: 80, color: Colors.blue),

            const SizedBox(height: 20),

            const Text(
              'Estado del Bluetooth',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            StreamBuilder<BluetoothAdapterState>(
              stream: bluetoothService.estadoBluetooth,

              builder: (context, snapshot) {
                final estado = snapshot.data;

                if (estado == BluetoothAdapterState.on) {
                  return const Text(
                    'Bluetooth activado',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }

                if (estado == BluetoothAdapterState.off) {
                  return const Text(
                    'Bluetooth desactivado',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }

                return const Text(
                  'Comprobando Bluetooth...',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                );
              },
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: buscando ? null : buscarDispositivos,

              icon: const Icon(Icons.search),

              label: Text(buscando ? 'Buscando...' : 'Buscar dispositivos'),
            ),

            const SizedBox(height: 25),

            const Align(
              alignment: Alignment.centerLeft,

              child: Text(
                'Dispositivos encontrados',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: StreamBuilder<List<ScanResult>>(
                stream: bluetoothService.dispositivosEncontrados,

                builder: (context, snapshot) {
                  final dispositivos = snapshot.data ?? [];

                  if (dispositivos.isEmpty) {
                    return const Center(
                      child: Text(
                        'No se encontraron dispositivos BLE',
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: dispositivos.length,

                    itemBuilder: (context, index) {
                      final dispositivo = dispositivos[index].device;

                      return Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.bluetooth,
                            color: Colors.blue,
                          ),

                          title: Text(
                            dispositivo.platformName.isNotEmpty
                                ? dispositivo.platformName
                                : 'Dispositivo BLE',
                          ),

                          subtitle: Text(dispositivo.remoteId.str),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
