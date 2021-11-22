import 'package:Busyman/screens/Twitter/frontened/TopBars/topbar.dart';
import 'package:Busyman/services/appColor.dart';
import 'package:Busyman/services/sizeconfig.dart';
import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget{
  late App _app;
  @override
  Widget build(BuildContext context) {
    _app = App(context);
    return Scaffold(
        
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TwitterTopView(headerName: "Busyman"),
              SizedBox(
                height: _app.appVerticalPadding(35.5),
              ),
              Text("Connectivity Lost",
              style: TextStyle(
                fontSize: 20.0,
                color: blueColour
              ),),
              SizedBox(height: 20.0,),
              Text("Please check your internet connection",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black
              ),),
              ],
          ),
        );
 
  }

}