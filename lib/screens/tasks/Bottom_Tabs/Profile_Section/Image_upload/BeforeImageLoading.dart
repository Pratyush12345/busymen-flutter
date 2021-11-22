

import 'package:Busyman/screens/Twitter/backend/providers/dashboard_provider.dart';
import 'package:Busyman/screens/tasks/Bottom_Tabs/Profile_Section/Image_upload/AllTaskVM.dart';
import 'package:Busyman/services/appColor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BeforeImageLoading extends StatefulWidget {
  var imageurl;
  int pos;
  bool isEdit;
  String? taskid = "";
  BeforeImageLoading({this.imageurl, required this.isEdit, required this.pos, this.taskid });

  @override
  _BeforeImageLoadingState createState() => _BeforeImageLoadingState();
}

class _BeforeImageLoadingState extends State<BeforeImageLoading> {
  bool isLink =  false;
  @override
  Widget build(BuildContext context) {
    try{
      if(widget.isEdit && widget.imageurl.contains("https")){
          isLink = true;
      }
    }
    catch(e){
      isLink = false;
    }
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
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                        icon: Icon(Icons.cancel),
                        iconSize: 35.0,
                        alignment: Alignment.topRight,
                        color: Colors.red,
                        onPressed: () {
                          if(widget.isEdit){
                           AllTaskVM.instance.deleteImageinFirebaseStorage(widget.taskid!, "image${widget.pos}", widget.pos);

                           AllTaskVM.instance.imageUrlList.removeWhere((element) => element.position == widget.pos);
                           
                           Provider.of<ChangeAddTaskImageProvider>(context, listen: false).changeAddTaskImageProvider();
                          
                          }
                          else{
                          AllTaskVM.instance.listOfImageFiles.removeWhere((element) => element.file.path == widget.imageurl.path );
                          Provider.of<ChangeAddTaskImageProvider>(context, listen: false).changeAddTaskImageProvider();
                          
                          }
                          Navigator.of(context).pop();
                          },
                      ),
              IconButton(
                        icon: Icon(Icons.check),
                        iconSize: 35.0,
                        alignment: Alignment.topRight,
                        color: Colors.green,
                        onPressed: () {
                          if(widget.isEdit){
                            int? pos = -1;
                            for(int i =0;i<3;i++){
                              int index = AllTaskVM.instance.imageUrlList.indexWhere((element) => element.position == i);
                              if(index == -1){
                                pos = i;
                                break;
                              }
                            } 
                            print("position edittttttttt$pos");
                            if(pos!=-1){
                            AllTaskVM.instance.listOfImageFiles.add(ImageTaskModel(
                                file: widget.imageurl,
                                position: pos!,
                                fileurl: ""
                              ));
                              Provider.of<ChangeAddTaskImageProvider>(context, listen: false).changeAddTaskImageProvider();
                            }
                          }else{
                            
                            if(AllTaskVM.instance.listOfImageFiles.indexWhere((element) => element.file.path == widget.imageurl.path )==-1);
                            {
                            AllTaskVM.instance.listOfImageFiles.add(ImageTaskModel(
                              file: widget.imageurl,
                              position: widget.pos,
                              fileurl: ""
                            ));
                            Provider.of<ChangeAddTaskImageProvider>(context, listen: false).changeAddTaskImageProvider();
                            }
                          }
                          Navigator.of(context).pop();
                          },
                      ),
            ],
          ),
        ],
      ),
    );
  }
}
