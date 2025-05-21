import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormClienteScreen extends StatelessWidget {
  final QueryDocumentSnapshot usuarioData;

  const FormClienteScreen({super.key, required this.usuarioData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Formulario Cliente")),
      body: Center(
        child: Text('Bienvenido Cliente: ${usuarioData['usuario']}'),
      ),
    );
  }
}
