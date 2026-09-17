import 'package:firebase_auth/firebase_auth.dart';
class AuthError {
 static String getAuthErrorMessage(FirebaseAuthException e){
    switch (e.code) {
    // =========================
    // LOGIN ERRORS
    // =========================

      case 'user-not-found':
        return 'No account found with this email.';

      case 'wrong-password':
      case 'invalid-credential':
        return 'Email or password is incorrect.';

    // =========================
    // COMMON
    // =========================

      case 'invalid-email':
        return 'Invalid email address.';

      case 'user-disabled':
        return 'This account has been disabled.';

      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';

      case 'network-request-failed':
        return 'Please check your internet connection.';

    // =========================
    // REGISTER ERRORS
    // =========================

      case 'email-already-in-use':
        return 'This email is already registered.';

      case 'weak-password':
        return 'Password is too weak.';

    // =========================
    // DEFAULT
    // =========================

      default:
        return e.message ?? 'Authentication failed.';
    }

  }
}