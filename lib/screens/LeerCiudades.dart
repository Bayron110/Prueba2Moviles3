import 'dart:convert';
import 'package:flutter/material.dart';

class Ciudades extends StatelessWidget {
  const Ciudades({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ciudades")),
      body: Listar(context),
    );
  }
}

Future<List<dynamic>> leerCiudades(context) async {
  final jsonString =
      await DefaultAssetBundle.of(context).loadString("assets/data/ciudades.json");
  final Map<String, dynamic> data = json.decode(jsonString);
  return data["ciudades"];
}

Widget Listar(context) {
  return FutureBuilder(
    future: leerCiudades(context),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        List data = snapshot.data!;
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return ListTile(
              title: Text("${item['nombre']}"),
              subtitle: Text("Provincia: ${item['provincia']}"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(item['nombre']),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Provincia: ${item['provincia']}"),
                            Text("Población: ${item['poblacion']}"),
                            Text("Latitud: ${item['latitud']}"),
                            Text("Longitud: ${item['longitud']}"),
                            const SizedBox(height: 8),
                            Text("Atracciones turísticas:"),
                            ...List<String>.from(item['atracciones_turisticas'])
                                .map((a) => Text("- $a")),
                            const SizedBox(height: 8),
                            Text("Lugares de interés:"),
                            ...List<String>.from(item['lugares_interes'])
                                .map((l) => Text("- $l")),
                            const SizedBox(height: 8),
                            Text("Actividades:"),
                            ...List<String>.from(item['actividades'])
                                .map((act) => Text("- $act")),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cerrar"),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        );
      } else {
        return const Center(child: Text("No hay datos"));
      }
    },
  );
}