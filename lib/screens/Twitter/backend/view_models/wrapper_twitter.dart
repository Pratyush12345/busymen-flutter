import 'package:Busyman/screens/Twitter/backend/utils/appconstant.dart';
import 'package:Busyman/screens/Twitter/backend/utils/global_variable.dart';
import 'package:Busyman/screens/Twitter/frontened/dashboard_twitter.dart';
import 'package:Busyman/screens/Twitter/frontened/twitter_signin.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WrapperTwitter extends StatelessWidget {
  const WrapperTwitter({ Key? key }) : super(key: key);

  
   _isTwitterLoggedIn() async{
   SharedPreferences _pref = await SharedPreferences.getInstance();
   DataSnapshot snapshot = await FirebaseDatabase.instance.reference().child("TwitterUsers/${GlobalVariable.uid}").once();
   bool _isDataAvailable = false;
   if(snapshot.value == null){
     _isDataAvailable = false;
   }
   else{
     _isDataAvailable = true;
   }
   bool val =_isDataAvailable && _pref.getBool("IsTwitterLoggedIn")!;
   return val;

  }

  @override
  Widget build(BuildContext context) {
  return FutureBuilder(
    future: _isTwitterLoggedIn(),
    builder: (context, snapshot){
    if(snapshot.connectionState == ConnectionState.done){  
    if(snapshot.data == true ){
      return Dashboard_Tabbar();
      }
    else{
      return TwitterSignIn();
    }
    }
    else{
      return AppConstant.circulerProgressIndicator();
    }
  });
  }
}