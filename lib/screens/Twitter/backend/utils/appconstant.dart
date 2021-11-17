import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppConstant {
  static Widget circulerProgressIndicator(){
    return Center(
      child: CircularProgressIndicator(),
    );

  }

  static Widget noDataFound(String text){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text, 
        style: TextStyle(color: Colors.black,
        fontSize: 22.0),),
      ),
    );

  }
  
}