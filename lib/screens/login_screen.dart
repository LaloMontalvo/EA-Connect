import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'form_cliente_screen.dart';
import 'form_arquitecto_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  bool _cargando = false;

  Future<void> _iniciarSesion() async {
    setState(() => _cargando = true);

    String usuario = _usuarioController.text.trim();
    String contrasena = _contrasenaController.text.trim();

    try {
      // Buscar en arquitectos
      final arquitectos = await FirebaseFirestore.instance
          .collection('arquitectos')
          .where('usuario', isEqualTo: usuario)
          .where('contrasena', isEqualTo: contrasena)
          .get();

      if (arquitectos.docs.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => FormArquitectoScreen(usuarioData: arquitectos.docs.first),
          ),
        );
        return;
      }

      // Buscar en clientes
      final clientes = await FirebaseFirestore.instance
          .collection('clientes')
          .where('usuario', isEqualTo: usuario)
          .where('contrasena', isEqualTo: contrasena)
          .get();

      if (clientes.docs.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => FormClienteScreen(usuarioData: clientes.docs.first),
          ),
        );
        return;
      }

      // Si no se encontró
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario o contraseña incorrectos')),
      );
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en el login')),
      );
    }

    setState(() => _cargando = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Image.asset('assets/Logo.png', height: 120),
              SizedBox(height: 20),
              TextField(
                controller: _usuarioController,
                decoration: InputDecoration(
                  labelText: 'Usuario',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _contrasenaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _cargando ? null : _iniciarSesion,
                child: _cargando
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Ingresar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
