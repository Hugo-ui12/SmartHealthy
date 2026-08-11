import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class SmartBluetoothService {
  SmartBluetoothService();

  Future<bool> get bluetoothDisponible async {
    return await FlutterBluePlus.isSupported;
  }

  Stream<BluetoothAdapterState> get estadoBluetooth {
    return FlutterBluePlus.adapterState;
  }

  Future<void> buscarDispositivos() async {
    final disponible = await bluetoothDisponible;

    if (!disponible) {
      throw Exception('Este dispositivo no soporta Bluetooth BLE.');
    }

    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));
  }

  Future<void> detenerBusqueda() async {
    await FlutterBluePlus.stopScan();
  }

  Stream<List<ScanResult>> get dispositivosEncontrados {
    return FlutterBluePlus.scanResults;
  }
}
