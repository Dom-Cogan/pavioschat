import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseApp> _initializeCustomFirebase(String apiKey, String appId,
      String messagingSenderId, String projectId) async {
    final FirebaseOptions customFirebaseOptions = FirebaseOptions(
      apiKey: apiKey,
      appId: appId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
    );
    return await Firebase.initializeApp(
        name: 'CustomApp', options: customFirebaseOptions);
  }

  // Get the current user
  User? get currentUser => _firebaseAuth.currentUser;

  // Sign up with email and password
  Future<UserCredential> signUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  // Sign in with email and password
  Future<UserCredential> signIn(String email, String password,
      {bool useCustomDatabase = false,
      CustomFirebaseCredentials? credentials}) async {
    FirebaseAuth authInstance = _firebaseAuth;

    if (useCustomDatabase && credentials != null) {
      FirebaseApp customApp = await _initializeCustomFirebase(
          credentials.apiKey,
          credentials.appId,
          credentials.messagingSenderId,
          credentials.projectId);
      authInstance = FirebaseAuth.instanceFor(app: customApp);
    }

    return await authInstance.signInWithEmailAndPassword(
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

class CustomFirebaseCredentials {
  final String apiKey;
  final String appId;
  final String messagingSenderId;
  final String projectId;

  CustomFirebaseCredentials(
      {required this.apiKey,
      required this.appId,
      required this.messagingSenderId,
      required this.projectId});
}
