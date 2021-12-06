import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return _firebaseAuth.authStateChanges().map((user) =>user==null?FBUser(uid: ""): FBUser(uid: user.uid));
  }

    Future<void> signOut() async {
    try {
      SharedPreferences _ref = await SharedPreferences.getInstance();
      _ref.clear();
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

class FBUser{
 final String uid;
 FBUser({
   required this.uid
 });

}