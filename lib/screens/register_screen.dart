import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import 'package:go_router/go_router.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});


  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}


class _RegisterScreenState extends State<RegisterScreen> {
  final authService = AuthService();
  final userService = UserService();
  final _formKey = GlobalKey<FormState>();


  String email = '', password = '', displayName = '', location = '';
  int birthYear = 2000;
  String errorMessage = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                onChanged: (value) => displayName = value,
                validator: (val) => val == null || val.isEmpty ? 'Introduce un nombre' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) => email = value,
                validator: (val) => val == null || val.isEmpty ? 'Introduce un email' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                onChanged: (value) => password = value,
                validator: (val) => val == null || val.length < 6 ? 'Mínimo 6 caracteres' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Año de nacimiento'),
                keyboardType: TextInputType.number,
                onChanged: (value) => birthYear = int.tryParse(value) ?? 2000,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Ubicación'),
                onChanged: (value) => location = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final (user, error) = await authService.register(email.trim(), password.trim());
                    if (error != null) {
                      setState(() => errorMessage = error);
                    } else if (user != null) {
                      await userService.createUserProfile(
                        uid: user.uid,
                        email: email,
                        displayName: displayName,
                        birthYear: birthYear,
                        location: location,
                      );
                      context.go('/');
                    }
                  }
                },
                child: const Text("Registrarse"),
              ),
              if (errorMessage.isNotEmpty)
                Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(errorMessage, style: const TextStyle(color: Colors.red)),
                ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => context.go('/login'),
                child: const Text("¿Ya tienes cuenta? Inicia sesión aquí"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
