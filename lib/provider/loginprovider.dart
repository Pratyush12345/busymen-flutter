import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static Auth instance = Auth._();
  Auth._();
  late User? currentuser;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  signInWithCred(cred) async {
    currentuser = (await _firebaseAuth.signInWithCredential(cred)).user;
    return "done";
  }

  signInWithOTP(String verid, String smscode) async {
    AuthCredential authCredential =
        PhoneAuthProvider.credential(verificationId: verid, smsCode: smscode);
    signInWithCred(authCredential);
  }

  Stream<FBUser> get appuser {
    return _firebaseAuth.authStateChanges().map((user) =>FBUser(uid: user!.uid));
  }

  logout(){
    _firebaseAuth.signOut();
  }
}

class FBUser{
 final String uid;
 FBUser({
   required this.uid
 });

}