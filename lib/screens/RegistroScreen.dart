import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: formularioRegistro(context),
    );
  }
}

Widget formularioRegistro(context) {
  TextEditingController correo = TextEditingController();
  TextEditingController password = TextEditingController();

  return Container(
    height: 200,
    child: Column(
      children: [
        TextField(
          controller: correo,
          decoration: const InputDecoration(hintText: "Ingresar Correo"),
        ),
        TextField(
          controller: password,
          obscureText: true,
          decoration: const InputDecoration(hintText: "Contraseña"),
        ),
        ElevatedButton(
          onPressed: () => registrar(correo, password, context),
          child: const Text("Registrar"),
        ),
      ],
    ),
  );
}

Future<void> registrar(TextEditingController correo, TextEditingController password, BuildContext context) async {
  try {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: correo.text,
      password: password.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Usuario registrado correctamente')),
    );

    Navigator.pushReplacementNamed(context, '/login');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La contraseña es muy débil')),
      );
    } else if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ya existe un usuario con ese correo')),
      );
    }
  }
}