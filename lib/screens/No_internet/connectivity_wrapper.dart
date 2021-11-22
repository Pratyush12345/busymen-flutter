
import 'package:Busyman/screens/No_internet/no_internet_screen.dart';
import 'package:Busyman/screens/No_internet/wait.dart';
import 'package:Busyman/screens/wrapper.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class ConnectivityWrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

      return StreamBuilder(
        stream: Connectivity().onConnectivityChanged ,
        builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.active){
               print("ccccccccccccccccccc");
               print(snapshot.data.toString());
               print("ccccccccccccccccccc");
              if(snapshot.data.toString()  != ConnectivityResult.none.toString())
              {
                return Wrapper();
              }
              
              else{
              if(Navigator.canPop(context)){
          
                Navigator.of(context).pop();
              }  
              return  NoInternetScreen();       
              }
              }
        
        return Wait();
     
        }, 
      ); 
}
}