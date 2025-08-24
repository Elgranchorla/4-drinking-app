import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'login_screen.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bienvenido"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await auth.signOut();
              context.go('/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          "¡Hola, ${user?.email ?? 'Usuario'}!",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
