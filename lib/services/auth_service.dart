import 'package:firebase_auth/firebase_auth.dart';

/// This class define the return result of some method of the AuthService
class AuthResult {
  final bool success;
  final String response;

  AuthResult({required this.success, this.response = ''});

  factory AuthResult.success() => AuthResult(success: true);

  factory AuthResult.failure(String errorMessage) =>
      AuthResult(success: false, response: errorMessage);
}

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static User? get currentUser => _auth.currentUser;

  static bool get emailVerified => _auth.currentUser?.emailVerified ?? false;

  static Future<AuthResult> reloadUser() async {
    try {
      await _auth.currentUser!.reload();
      return AuthResult.success();
    } catch (e) {
      return AuthResult.failure(e.toString());
    }
  }

  static Future<AuthResult> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // print(result.user);
      return AuthResult.success();
      // return _userFromFirebase(result.user);

    } catch (e) {
      // return UserModel(displayName: 'Null', uid: 'null');
      return AuthResult.failure(e.toString());
    }
  }

  static Future<AuthResult> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return AuthResult.success();
    } catch (e) {
      return AuthResult.failure(e.toString());
    }
  }

  static Future<void> verifyEmail() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
    } catch (e) {}
  }

  static Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  static Future<AuthResult> signOut() async {
    try {
      await _auth.signOut();

      await Future.delayed(Duration.zero);

      return AuthResult.success();
    } catch (e) {
      return AuthResult.failure(e.toString());
    }
  }
}
