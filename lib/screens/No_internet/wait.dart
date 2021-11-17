import 'package:busyman/screens/Twitter/backend/utils/appconstant.dart';
import 'package:flutter/material.dart';
class Wait extends StatefulWidget {
  @override
  _WaitState createState() => _WaitState();
}

class _WaitState extends State<Wait> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      body: 
          Container(
            color: Color(0xff405172),
            child: Stack(
         alignment: Alignment.center,
              children: [
          
        Container(
            height: 100.0,
            width: 100.0,
            child: Center(
              child: AppConstant.circulerProgressIndicator(),
            ),
        )
                // Container(
                //   color: Color(0xff405172),
                //   child: Center(
                //     child: Container(
                //       width: 100.0,
                //       height: 100.0,
                //       child: AppConstants.circulerProgressIndicator()
                //       ),
                //   ),
                // ),
              ],
            ),
          ),
        
    );
  }
}