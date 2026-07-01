import 'package:flutter/material.dart';

class CitasScreen extends StatefulWidget {
  const CitasScreen({super.key});

  @override
  State<CitasScreen> createState() => _CitasScreenState();
}

class _CitasScreenState extends State<CitasScreen> {
  String fechaSeleccionada = '';

  String horaSeleccionada = '';

  String especialidadSeleccionada = 'Cardiología';

  List<String> especialidades = [
    'Cardiología',

    'Nutrición',

    'Pediatría',

    'Dermatología',

    'Psicología',

    'Medicina General',
  ];

  List<Map<String, String>> citas = [
    {
      'doctor': 'Dr. Juan Pérez',
      'especialidad': 'Cardiología',
      'fecha': '20 junio 2026',
      'hora': '10:30 AM',
    },

    {
      'doctor': 'Dra. Ana López',
      'especialidad': 'Nutrición',
      'fecha': '25 junio 2026',
      'hora': '12:00 PM',
    },
  ];

  void agregarCita() {
    setState(() {
      citas.add({
        'doctor': 'Nuevo doctor',

        'especialidad': 'Especialidad',

        'fecha': 'Pendiente',

        'hora': 'Pendiente',
      });
    });
  }

  Future<void> seleccionarFecha() async {
    DateTime? fecha = await showDatePicker(
      context: context,

      initialDate: DateTime.now(),

      firstDate: DateTime(2025),

      lastDate: DateTime(2035),
    );

    if (fecha != null) {
      setState(() {
        fechaSeleccionada = '${fecha.day}/${fecha.month}/${fecha.year}';
      });
    }
  }

  Future<void> seleccionarHora() async {
    TimeOfDay? hora = await showTimePicker(
      context: context,

      initialTime: TimeOfDay.now(),
    );

    if (hora != null) {
      setState(() {
        horaSeleccionada = hora.format(context);
      });
    }
  }

  void mostrarFormulario({int? indice}) {
    final doctorController = TextEditingController();

    if (indice == null) {
      fechaSeleccionada = '';

      horaSeleccionada = '';

      especialidadSeleccionada = 'Cardiología';
    } else {
      doctorController.text = citas[indice]['doctor']!;

      especialidadSeleccionada = citas[indice]['especialidad']!;

      fechaSeleccionada = citas[indice]['fecha']!;

      horaSeleccionada = citas[indice]['hora']!;
    }

    showDialog(
      context: context,

      builder: (context) {
        return StatefulBuilder(
          builder: (context, actualizarVentana) {
            return AlertDialog(
              title: Text(indice == null ? 'Agregar cita' : 'Editar cita'),

              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    TextField(
                      controller: doctorController,

                      decoration: const InputDecoration(labelText: 'Doctor'),
                    ),

                    const SizedBox(height: 15),

                    DropdownButtonFormField(
                      value: especialidadSeleccionada,

                      decoration: const InputDecoration(
                        labelText: 'Especialidad',
                      ),

                      items: especialidades.map((especialidad) {
                        return DropdownMenuItem(
                          value: especialidad,

                          child: Text(especialidad),
                        );
                      }).toList(),

                      onChanged: (valor) {
                        actualizarVentana(() {
                          especialidadSeleccionada = valor!;
                        });
                      },
                    ),

                    const SizedBox(height: 15),

                    ListTile(
                      leading: const Icon(Icons.calendar_month),

                      title: Text(
                        fechaSeleccionada.isEmpty
                            ? 'Seleccionar fecha'
                            : fechaSeleccionada,
                      ),

                      onTap: () async {
                        await seleccionarFecha();

                        actualizarVentana(() {});
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.access_time),

                      title: Text(
                        horaSeleccionada.isEmpty
                            ? 'Seleccionar hora'
                            : horaSeleccionada,
                      ),

                      onTap: () async {
                        await seleccionarHora();

                        actualizarVentana(() {});
                      },
                    ),
                  ],
                ),
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  child: const Text('Cancelar'),
                ),

                ElevatedButton(
                  onPressed: () {
                    if (doctorController.text.isEmpty ||
                        fechaSeleccionada.isEmpty ||
                        horaSeleccionada.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Completa todos los campos.'),
                          backgroundColor: Colors.red,
                        ),
                      );

                      return;
                    }

                    setState(() {
                      if (indice == null) {
                        citas.add({
                          'doctor': doctorController.text,

                          'especialidad': especialidadSeleccionada,

                          'fecha': fechaSeleccionada,

                          'hora': horaSeleccionada,
                        });
                      } else {
                        citas[indice] = {
                          'doctor': doctorController.text,

                          'especialidad': especialidadSeleccionada,

                          'fecha': fechaSeleccionada,

                          'hora': horaSeleccionada,
                        };
                      }
                    });

                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          indice == null
                              ? '✅ Cita agregada correctamente'
                              : '✏️ Cita actualizada correctamente',
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },

                  child: const Text('Guardar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(title: const Text('Citas médicas'), centerTitle: true),

      body: ListView.builder(
        padding: const EdgeInsets.all(20),

        itemCount: citas.length,

        itemBuilder: (context, index) {
          return Card(
            elevation: 5,

            margin: const EdgeInsets.only(bottom: 15),

            child: ListTile(
              leading: const CircleAvatar(
                radius: 28,

                backgroundColor: Color(0xFFE3F2FD),

                child: Icon(
                  Icons.medical_services,
                  color: Colors.blue,
                  size: 30,
                ),
              ),

              title: Text(citas[index]['doctor']!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(
                        Icons.local_hospital,
                        color: Colors.red,
                        size: 18,
                      ),

                      const SizedBox(width: 6),

                      Text(citas[index]['especialidad']!),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        color: Colors.green,
                        size: 18,
                      ),

                      const SizedBox(width: 6),

                      Text(citas[index]['fecha']!),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Colors.orange,
                        size: 18,
                      ),

                      const SizedBox(width: 6),

                      Text(citas[index]['hora']!),
                    ],
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,

                children: [
                  IconButton(
                    onPressed: () {
                      mostrarFormulario(indice: index);
                    },

                    icon: const Icon(Icons.edit, color: Colors.blue),
                  ),

                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,

                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Eliminar cita'),

                            content: Text(
                              '¿Deseas eliminar la cita de ${citas[index]['doctor']}?',
                            ),

                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },

                                child: const Text('Cancelar'),
                              ),

                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    citas.removeAt(index);
                                  });

                                  Navigator.pop(context);
                                },

                                child: const Text('Eliminar'),
                              ),
                            ],
                          );
                        },
                      );
                    },

                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: mostrarFormulario,

        child: const Icon(Icons.add),
      ),
    );
  }
}
