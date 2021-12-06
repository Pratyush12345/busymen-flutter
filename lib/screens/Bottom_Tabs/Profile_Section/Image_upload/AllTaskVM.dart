
import 'package:Busyman/screens/Bottom_Tabs/Profile_Section/Image_upload/BeforeImageLoading.dart';
import 'package:Busyman/screens/Twitter/backend/utils/global_variable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class AllTaskVM{
  static AllTaskVM instance = AllTaskVM._();
  AllTaskVM._();
  Reference? _storageReference;
  List<ImageTaskModel> listOfImageFiles = [];
  
  List<ImageTaskModel> imageUrlList = [];
  
  init(){
    listOfImageFiles = [];
    imageUrlList = [];
  }
  
   pickImage(BuildContext context, bool isedit) async {
    XFile? selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    

    final filePath = selectedImage!.path;
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    var compressedFile = await FlutterImageCompress.compressAndGetFile(
      selectedImage.path,
      outPath,
      quality: 50,
      minWidth: 720,
      minHeight: 1280,
    );

    File? imageFile = compressedFile;
    if (selectedImage != null) {
      
      print("positoin ${listOfImageFiles.length}");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (contex) => BeforeImageLoading(
                    imageurl: imageFile,
                    pos: listOfImageFiles.length,
                    isEdit: isedit,
                  )));
    }
  }

  updateToken(){
    FirebaseMessaging.instance.getToken().then((token) {
        FirebaseDatabase.instance
            .reference()
            .child("Users/${FirebaseAuth.instance.currentUser!.uid}")
            .update({"andrtokenid": token});
      
  });
  }

initHomeScreen(BuildContext context){
  
  GlobalVariable.progressDialog = ProgressDialog(context: context);
  updateToken();

}  

 Future<String> storeImageinFirebaseStorage(File imageFile, String taskid, String path) async{
  String url = "";
            _storageReference = FirebaseStorage.instance.ref().child('Users/${FirebaseAuth.instance.currentUser!.uid}/Tasks/$taskid/$path');
            UploadTask storageUploadTask = _storageReference!.putFile(imageFile);
                await storageUploadTask.then((val) async {
                url = await val.ref.getDownloadURL();
                });
  return url;              
 }

 Future<String> deleteImageinFirebaseStorage( String taskid, String path, int pos) async{
  String url = "";
  FirebaseStorage.instance.ref().child('Users/${FirebaseAuth.instance.currentUser!.uid}/Tasks/$taskid/$path').delete();           
  FirebaseDatabase.instance.reference().child('Users/${FirebaseAuth.instance.currentUser!.uid}/Tasks/$taskid/imageUrls/$pos').remove();
  return url;              
 }

 Future<String> deleteAllImageFirebaseStorage( String taskid,) async{
  String url = "";
  FirebaseStorage.instance.ref().child('Users/${FirebaseAuth.instance.currentUser!.uid}/Tasks/$taskid').delete();           
  return url;              
 }

 Future<List<dynamic>> getUrlListOfImage(String taskid) async{
  List<dynamic> _list = [];
  if(listOfImageFiles.isNotEmpty){
  for(int i =0; i< listOfImageFiles.length;i++){
   String url = await storeImageinFirebaseStorage(  listOfImageFiles[i].file , taskid, "image${listOfImageFiles[i].position}");
   _list.add(url);
  }
  return _list;
  }
  else{
    return [];
  }
 }

Future<List<dynamic>> getUpdatedUrlListOfImage(String taskid) async{
  List<dynamic> _list = List.filled(3, "");
  imageUrlList.forEach((element) { 
    print(element.position);
    _list[element.position] = element.fileurl;
  });
  if(listOfImageFiles.isNotEmpty){  

  for(int i =0; i< listOfImageFiles.length;i++){
   String url = await storeImageinFirebaseStorage(  listOfImageFiles[i].file , taskid, "image${listOfImageFiles[i].position}");
   print(url);
   print("***********");
   print(listOfImageFiles[i].position);
   _list[listOfImageFiles[i].position] = url;
   print(_list);
  }

  


  print("Last List");
  print(_list);
  return _list;
  }
  else{
    return _list;
  }
 }


}

class ImageTaskModel{
  int position;
  File file;
  String fileurl;
  ImageTaskModel({required this.position, required this.file, required this.fileurl});
}

