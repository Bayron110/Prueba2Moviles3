import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class GastronomiaScreen extends StatelessWidget {
  const GastronomiaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Guardados")),
      body: formularioG(context),
    );
  }
}

Widget formularioG(context) {
  TextEditingController id = TextEditingController();
  TextEditingController ciudad = TextEditingController();
  TextEditingController nombre = TextEditingController();

  return Column(
    children: [
      TextField(
        controller: id,
        decoration: InputDecoration(label: Text("Ingresar id del plato")),
      ),

      TextField(
        controller: nombre,
        decoration: InputDecoration(label: Text("Ingresar Plato Tipico")),
      ),

      TextField(
        controller: ciudad,
        decoration: InputDecoration(label: Text("Ingresar Ciudad")),
      ),
      FilledButton(onPressed: ()=>guardarPelicula(id, nombre, ciudad,context), child: Text("Guardar"))
    ],
  );
}

Future<void> guardarPelicula(id, nombre, ciudad, context) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("gastronimia/${id.text}");

  await ref.set({
    "titulo": nombre.text,
    "ciudad": ciudad.text,
  });

  showAdaptiveDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Éxito"),
        content: const Text("El plato se guardo correctamente."),
      );
    },
  );
}