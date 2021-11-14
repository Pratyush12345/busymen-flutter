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
      child: Text(text, 
      style: TextStyle(color: Colors.black,
      fontSize: 26.0),),
    );

  }
  
}