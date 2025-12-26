import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GastronomiaScreen extends StatelessWidget {
  const GastronomiaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Guardar gasto")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: formulario(context),
      ),
    );
  }
}

Widget formulario(BuildContext context) {
  final TextEditingController titulo = TextEditingController();
  final TextEditingController descripcion = TextEditingController();
  final TextEditingController precio = TextEditingController();

  return Column(
    children: [
      TextField(
        controller: titulo,
        decoration: const InputDecoration(labelText: "Nombre"),
      ),
      TextField(
        controller: descripcion,
        decoration: const InputDecoration(labelText: "Descripción"),
      ),
      TextField(
        controller: precio,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: "Precio del plato"),
      ),
      const SizedBox(height: 20),
      FilledButton(
        onPressed: () {
          guardarGasto(
            context,
            titulo.text,
            descripcion.text,
            precio.text,
          );
        },
        child: const Text("Guardar"),
      ),
    ],
  );
}

Future<void> guardarGasto(
  BuildContext context,
  String titulo,
  String descripcion,
  String precio,
) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  DatabaseReference ref = FirebaseDatabase.instance
      .ref("Platos/${user.uid}")
      .push();

  await ref.set({
    "titulo": titulo,
    "descripcion": descripcion,
    "precio": precio,
  });

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Éxito"),
      content: const Text("El gasto se guardó correctamente."),
    ),
  );
}
