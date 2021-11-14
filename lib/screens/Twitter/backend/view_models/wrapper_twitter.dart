import 'package:busyman/screens/Twitter/backend/utils/appconstant.dart';
import 'package:busyman/screens/Twitter/frontened/dashboard.dart';
import 'package:busyman/screens/Twitter/frontened/dashboard_twitter.dart';
import 'package:busyman/screens/Twitter/frontened/twitter_signin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WrapperTwitter extends StatelessWidget {
  const WrapperTwitter({ Key? key }) : super(key: key);
   
   _isTwitterLoggedIn() async{
   SharedPreferences _pref = await SharedPreferences.getInstance();
   return _pref.getBool("IsTwitterLoggedIn")!;
  }

  @override
  Widget build(BuildContext context) {
  return FutureBuilder(
    future: _isTwitterLoggedIn(),
    builder: (context, snapshot){
    if(snapshot.connectionState == ConnectionState.done){  
    if(snapshot.hasData){
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