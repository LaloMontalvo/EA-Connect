import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );

        // ✅ Redirige si inicia sesión correctamente
        Navigator.pushReplacementNamed(context, '/home'); // Crea tu pantalla "home"

      } on FirebaseAuthException catch (e) {
        String message = 'Ocurrió un error';
        if (e.code == 'user-not-found') {
          message = 'Usuario no encontrado';
        } else if (e.code == 'wrong-password') {
          message = 'Contraseña incorrecta';
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Sesión')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Correo electrónico'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          value!.isEmpty ? 'Ingresa tu correo' : null,
                      onChanged: (value) => email = value,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Contraseña'),
                      obscureText: true,
                      validator: (value) =>
                          value!.length < 6 ? 'Mínimo 6 caracteres' : null,
                      onChanged: (value) => password = value,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: login,
                      child: Text('Ingresar'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
