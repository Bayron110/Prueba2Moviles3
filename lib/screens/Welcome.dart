import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Cuerpo(context));
  }
}

Widget Cuerpo(context) {
  return Column(
    children: [
      FilledButton(
        onPressed: () => Navigator.pushNamed(context, '/login'),
        child: Text("Login"),
      ),
      FilledButton(
        onPressed: () => Navigator.pushNamed(context, '/registro'),
        child: Text("Registrase"),
      ),
      Text("Nombre del Desarrollador: Bayron Alomoto"),
      Text("Usuario del Git Hub: Bayron110")

    ],
  );
}
