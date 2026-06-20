import 'package:firebase_auth/firebase_auth.dart';

/// Firebase implementation of authentication.
///
/// This is intentionally kept separate from the API repository
/// (`ProfileRepository`) so the base project can switch between an API backend
/// and Firebase without touching the API layer. The controllers decide which
/// one to call.
class FirebaseAuthService {
  // Accessed lazily so the controller can be constructed even before
  // Firebase.initializeApp() has run (e.g. while config is not yet set up).
  FirebaseAuth get _auth => FirebaseAuth.instance;

  /// The currently signed-in Firebase user, or null.
  User? get currentUser => _auth.currentUser;

  /// Sign in with email & password.
  Future<UserCredential> login({
    required String email,
    required String password,
  }) {
    return _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Create a new account with email & password.
  /// Optionally sets a display name from the provided first/last name.
  Future<UserCredential> register({
    required String email,
    required String password,
    String? displayName,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (displayName != null && displayName.trim().isNotEmpty) {
      await credential.user?.updateDisplayName(displayName.trim());
    }
    return credential;
  }

  /// Sign out the current user.
  Future<void> logout() => _auth.signOut();

  /// Maps a [FirebaseAuthException] to a user-friendly message.
  static String messageFromException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'email-already-in-use':
        return 'This email is already registered. Please log in instead.';
      case 'weak-password':
        return 'The password is too weak. Use at least 6 characters.';
      case 'operation-not-allowed':
        return 'Email/password sign-in is not enabled in Firebase.';
      case 'network-request-failed':
        return 'No internet connection. Please try again.';
      default:
        return e.message ?? 'Authentication failed. Please try again.';
    }
  }
}
