import 'package:flutter/material.dart';
import 'tabla.dart'; // Importa la pantalla de tabla
import 'flotas.dart'; // Importa la pantalla de flotas

class MenuPantallas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú de Pantallas'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DataTablePage()), // Navega a tabla.dart
                );
              },
              child: const Text('Mostrar Tabla'),
            ),
            const SizedBox(width: 16), // Espaciado entre los botones
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FlotasPage()), // Navega a flotas.dart
                );
              },
              child: const Text('Mostrar Flotas'),
            ),
          ],
        ),
      ),
    );
  }
}