import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Get the current user
  User? get currentUser => _firebaseAuth.currentUser;

  // Sign up with email and password
  Future<UserCredential> signUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  // Sign in with email and password
  Future<UserCredential> signIn(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  // Sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Reset password
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // Change password for the current user
  Future<void> changePassword(String newPassword) async {
    if (_firebaseAuth.currentUser != null) {
      await _firebaseAuth.currentUser!.updatePassword(newPassword);
    } else {
      throw FirebaseAuthException(
        code: 'user-not-signed-in',
        message: 'No user signed in to change password for.',
      );
    }
  }

// Additional methods as needed...
}
