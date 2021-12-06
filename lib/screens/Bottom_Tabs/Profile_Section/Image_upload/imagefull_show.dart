

import 'package:Busyman/screens/Twitter/backend/providers/dashboard_provider.dart';
import 'package:Busyman/screens/Bottom_Tabs/Profile_Section/Image_upload/AllTaskVM.dart';
import 'package:Busyman/services/appColor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageFullshow extends StatefulWidget {
  var imageurl;
  int pos;
  bool isEdit;
  String? taskid = "";
  ImageFullshow({this.imageurl, required this.isEdit, required this.pos, this.taskid });

  @override
  _BeforeImageLoadingState createState() => _BeforeImageLoadingState();
}

class _BeforeImageLoadingState extends State<ImageFullshow> {
  bool isLink =  false;
  @override
  Widget build(BuildContext context) {
    try{

      if(widget.isEdit && widget.imageurl.contains("https")){
          isLink = true;
       print("ifffffffff");
      }
    }
    catch(e){
      print(e);
      print("error");
      isLink = false;
    }
    print("Link");
    print(isLink);
    return Scaffold(
      appBar: AppBar(
        title: Text("Image"),
        backgroundColor: blueColour,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 10,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              padding: EdgeInsets.only(top: 20.0, bottom: 16.0),
              child: Center(
                child: widget.isEdit && isLink ? 
                Image.network(
                  widget.imageurl,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.contain,
                ):Image.file(
                  widget.imageurl,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          
          
        ],
      ),
    );
  }
}
