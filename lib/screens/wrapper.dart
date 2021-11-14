import 'package:busyman/provider/loginprovider.dart';
import 'package:busyman/screens/login/loginscreen.dart';
import 'package:busyman/screens/tasks/alltasks.dart';
import 'package:busyman/screens/tasks/alltasks1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({ Key? key }) : super(key: key);

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
    return AllTasks() ;
    }
  }
}