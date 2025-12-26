import 'package:app_autonomo/screens/GastronomiaScreen.dart';
import 'package:app_autonomo/screens/LeerCiudades.dart';
import 'package:app_autonomo/screens/LoginScreen.dart';
import 'package:app_autonomo/screens/RegistroScreen.dart';
import 'package:app_autonomo/screens/Welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MiAplicacion());
}

class MiAplicacion extends StatelessWidget {
  const MiAplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => LoginScreen(),
        '/registro': (context) => RegistroScreen(),
        '/gastronomia': (context) => GastronomiaScreen(),
        '/leer': (context) => const LeerBottomTab(),
        '/welcome': (context) => Welcome(),
        'leerCiudades': (context) => Ciudades(),
      },
      home: const Cuerpo(),
    );
  }
}

class Cuerpo extends StatelessWidget {
  const Cuerpo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          FilledButton(
            onPressed: () => Navigator.pushNamed(context, '/welcome'),
            child: const Text("Welcome"),
          ),
        ],
      ),
    );
  }
}

class LeerBottomTab extends StatefulWidget {
  const LeerBottomTab({super.key});

  @override
  State<LeerBottomTab> createState() => _LeerBottomTabState();
}

class _LeerBottomTabState extends State<LeerBottomTab> {
  int _index = 0;

  final List<Widget> _screens = [
    GastronomiaScreen(),
    Ciudades(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Ingresar un plato',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: 'Ciudades',
          ),
        ],
      ),
    );
  }
}
