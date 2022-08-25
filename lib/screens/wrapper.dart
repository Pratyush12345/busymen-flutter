import 'package:Busyman/provider/loginprovider.dart';
import 'package:Busyman/screens/Twitter/backend/utils/global_variable.dart';
import 'package:Busyman/screens/login/loginscreen.dart';
import 'package:Busyman/screens/tasks/alltasks1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  //String changedUID;

  Wrapper({ Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final user= Provider.of<FBUser>(context);
    if(user.uid== ""){
    return LogInScreen();
    } 
    else{
    if(Navigator.of(context).canPop()){
      Navigator.of(context).pop();
    }
    if(user.uid == "123"){
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    GlobalVariable.uid = FirebaseAuth.instance.currentUser!.uid;
    return AllTasks() ;
    }
  }
}