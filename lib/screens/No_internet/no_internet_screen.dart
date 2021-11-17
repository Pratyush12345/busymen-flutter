import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
          body: Container(
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Connectivity Lost",
                    style: TextStyle(
                      color: Colors.white
                    ),),
                    Text("Please check your internet connection",
                    style: TextStyle(
                      color: Colors.white
                    ),),
                  ],
                ),
              ),
          ),
        );
 
  }

}