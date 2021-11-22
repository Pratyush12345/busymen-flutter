
import 'package:Busyman/models/models.dart';
import 'package:Busyman/screens/Twitter/backend/providers/dashboard_provider.dart';
import 'package:Busyman/screens/Twitter/backend/utils/global_variable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ProfileTabVM{
  static ProfileTabVM instance = ProfileTabVM._();
  ProfileTabVM._();
  bool showIndicator = false;
  UserDetailModel? userDetailModel;
  
  fetchUserDetail(BuildContext context) async{
   try{
   showIndicator = true;  
   DataSnapshot snapshot = await FirebaseDatabase.instance.reference().child("Users/UserDetails/").once();
   print(snapshot.value);
   if(snapshot.value==null ||snapshot.value.toString().isEmpty ){
     GlobalVariable.isProfileEdit = false;
     userDetailModel = UserDetailModel(name: "", positionName: "", phoneNumber: "", officeAddress: "", localAddress: "");
   }
   else{
     GlobalVariable.isProfileEdit = true;
     userDetailModel = UserDetailModel.fromSnapshot(snapshot);
   }
   Provider.of<UserProfileProvider>(context, listen: false).changeUserProfileProvider(errorOccured: false, modelLocal: userDetailModel!);
   showIndicator = false;
   }
   catch(e){
     showIndicator = false;
     Provider.of<UserProfileProvider>(context, listen: false).changeUserProfileProvider(errorOccured: true, modelLocal: userDetailModel!);
     print(e);
   } 
  }

  addUpdateProfile(BuildContext context, UserDetailModel model ) async{
   try{  
   await FirebaseDatabase.instance.reference().child("Users/UserDetails/").update(model.toJson());
   }
   catch(e){
     print(e);
   }
  }
}