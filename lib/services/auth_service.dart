import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get userChanges => _auth.userChanges();

  Future<(User?, String?)> register(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return (userCredential.user, null);
    } on FirebaseAuthException catch (e) {
      return (null, _handleFirebaseAuthError(e));
    } catch (e) {
      return (null, 'Error inesperado: ${e.toString()}');
    }
  }

  Future<(User?, String?)> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return (userCredential.user, null);
    } on FirebaseAuthException catch (e) {
      return (null, _handleFirebaseAuthError(e));
    } catch (e) {
      return (null, 'Error inesperado: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;

  String _handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No se encontró un usuario con ese email.';
      case 'wrong-password':
        return 'Contraseña incorrecta.';
      case 'invalid-email':
        return 'El email no es válido.';
      case 'user-disabled':
        return 'Esta cuenta ha sido deshabilitada.';
      case 'email-already-in-use':
        return 'El email ya está en uso por otra cuenta.';
      case 'operation-not-allowed':
        return 'Esta operación no está permitida.';
      case 'weak-password':
        return 'La contraseña es demasiado débil.';
      case 'too-many-requests':
        return 'Demasiados intentos fallidos. Inténtalo más tarde.';
      case 'network-request-failed':
        return 'Error de red. Verifica tu conexión a internet.';
      case 'quota-exceeded':
        return 'Se ha superado el límite de uso de autenticación.';
      default:
        return 'Error de autenticación: ${e.message ?? e.code}';
    }
  }
}
