import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static Auth instance = Auth._();
  Auth._();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get appuser {
    return _firebaseAuth.authStateChanges().map((user) => user!);
  }

  logout(){
    _firebaseAuth.signOut();
  }
}