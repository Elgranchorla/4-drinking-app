// lib/router/router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../providers/auth_provider.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  debugLogDiagnostics: true,

  redirect: (context, state) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final loggedIn = auth.isAuthenticated;
    final loggingIn = state.fullPath == '/login' || state.fullPath == '/register';

    if (!loggedIn && !loggingIn) return '/login';
    if (loggedIn && loggingIn) return '/home';

    return null;
  },

  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
