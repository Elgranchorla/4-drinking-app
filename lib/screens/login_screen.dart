import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../providers/auth_provider.dart';
import 'package:go_router/go_router.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  final authService = AuthService();
  final _formKey = GlobalKey<FormState>();


  String email = '';
  String password = '';
  String errorMessage = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Iniciar sesión")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (val) => email = val,
                validator: (val) => val == null || val.isEmpty ? 'Introduce un email' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                onChanged: (val) => password = val,
                validator: (val) => val == null || val.length < 6 ? 'Mínimo 6 caracteres' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final (user, error) = await authService.login(email.trim(), password.trim());
                    if (error != null) {
                      setState(() => errorMessage = error);
                    } else {
                      context.go('/');
                    }

                  }
                },
                child: const Text("Entrar"),
              ),
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(errorMessage, style: const TextStyle(color: Colors.red)),
                ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => context.go('/register'),
                child: const Text("¿No tienes cuenta? Regístrate aquí"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}