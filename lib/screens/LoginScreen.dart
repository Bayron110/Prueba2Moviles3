import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: formulario(context),
    );
  }
}

Widget formulario(BuildContext context) {
  TextEditingController correo = TextEditingController();
  TextEditingController password = TextEditingController();

  return Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: correo,
          decoration: const InputDecoration(
            labelText: "Correo electrónico",
          ),
        ),
        TextField(
          controller: password,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: "Contraseña",
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => login(correo, password, context),
          child: const Text("Login"),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/registro'),
          child: const Text("¿No tienes cuenta? Regístrate"),
        ),
      ],
    ),
  );
}

Future<void> login(
    TextEditingController correo,
    TextEditingController password,
    BuildContext context) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: correo.text,
      password: password.text,
    );

    Navigator.pushReplacementNamed(context, '/leer');
  } on FirebaseAuthException catch (e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Correo o Contraseña Invalidas'),
        );
      },
    );
  }
}