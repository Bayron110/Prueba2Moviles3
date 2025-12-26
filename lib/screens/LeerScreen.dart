import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LeerScreen extends StatelessWidget {
  const LeerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final DatabaseReference ref = FirebaseDatabase.instance.ref(
      user == null ? "Platos/public" : "Platos/${user.uid}",
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gastronomía"),
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: ref.onValue,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return Column(
              children: [
                const Center(
                  child: Text("No hay platos ingresados"),
                ),
                FilledButton(
                  onPressed: () => Navigator.pushNamed(context, '/gastronomia'),
                  child: const Text("Ingresar un Plato"),
                ),
              ],
            );
          }

          final value = snapshot.data!.snapshot.value;

          if (value is Map) {
            final Map<dynamic, dynamic> data = value;
            final items = data.entries.toList();

            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final value = item.value as Map?;

                return ListTile(
                  title: Text(value?["titulo"] ?? ""),
                  subtitle: Text("Precio: ${value?["precio"] ?? ""}"),
                  trailing: user == null
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => eliminar(item.key),
                        ),
                  onTap: user == null
                      ? null
                      : () => editarDialog(
                            context,
                            item.key,
                            value?["titulo"] ?? "",
                            value?["descripcion"] ?? "",
                            value?["precio"] ?? "",
                          ),
                );
              },
            );
          }

          if (value is List) {
            final List<dynamic> data = value;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index] as Map?;
                if (item == null) return const SizedBox();
                return ListTile(
                  title: Text(item["titulo"] ?? ""),
                  subtitle: Text("Precio: ${item["precio"] ?? ""}"),
                );
              },
            );
          }

          return const Center(child: Text("Formato de datos no soportado"));
        },
      ),
    );
  }
}

