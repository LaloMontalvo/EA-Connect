import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormArquitectoScreen extends StatelessWidget {
  final QueryDocumentSnapshot usuarioData;

  const FormArquitectoScreen({super.key, required this.usuarioData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Formulario Arquitecto")),
      body: Center(
        child: Text('Bienvenido Arquitecto: ${usuarioData['usuario']}'),
      ),
    );
  }
}
