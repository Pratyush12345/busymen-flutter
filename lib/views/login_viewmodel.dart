// import 'package:Decon/Controller/ViewModels/Services/Auth.dart';
// import 'package:Decon/View_Android/Authentication/login_screen.dart';
import 'package:busyman/provider/loginprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginVM {
  static LoginVM instance = LoginVM._();
  LoginVM._();
  bool _isphoneVerif = true;
  late String verificationID;
  bool codeSent = false;

  verifyPhone(context, String phoneNoWithCountryCode) async {
    final PhoneVerificationCompleted verfiySuccess =
        (AuthCredential cred) async {
      print("vvvvvvvvvvvvvvvv");
      print("Verify Success");
      print("vvvvvvvvvvvvvvvv");
    };

    final PhoneVerificationFailed verifyFailure = (Exception error) {
      print("++++++++++");
      print(error);
      print("++++++++++");
    };

    final PhoneCodeSent smsCodeSent = (String verid, int? forceCodeResend) {
      print("sssssssssssssss");
      print("sms code sent");
      print("sssssssssssssss");
      verificationID = verid;
      // setState(() {
      //   this.codeSent = true;
      // });
    };
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verid) {
      print("aaaaaaaaaaaaaaa");
      print("auto Retrieve");
      print("aaaaaaaaaaaaaaa");
      verificationID = verid;
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNoWithCountryCode,
        timeout: Duration(seconds: 120),
        verificationCompleted: verfiySuccess,
        verificationFailed: verifyFailure,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieve);
  }

  manualLogin(String smsCode) async {
    print("ver id=================");
    print(verificationID);

    print("ver id=================");
    await Auth.instance.signInWithOTP(
      verificationID,
      smsCode,
    );
  }
}
