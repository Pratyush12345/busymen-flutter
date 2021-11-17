import 'dart:convert';

import 'package:busyman/screens/Twitter/backend/providers/dashboard_provider.dart';
import 'package:busyman/screens/Twitter/backend/utils/global_variable.dart';
import 'package:busyman/screens/Twitter/backend/utils/models.dart';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'as fbAuth;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardVM{
  static DashboardVM instance = DashboardVM._();
  DashboardVM._();
  List<TwitterUsersModel>? followerslist;
  List<TwitterUsersModel>? followinglist;
  List<TwitterUsersModel>? allselectedlist;
  List<TwitterUsersModel>? searchList;
  String? listOfRetweetId;
  String? listOfAccountAddedId;
  bool? showCircularIndicator = true;
  int? followerNextCursorId;
  int? followingNextCursorId;
  FToast? fToast;
  BuildContext? context;

  initTwitterApi(){
    GlobalVariable.twitterApi = TwitterApi(
    client: TwitterClient(
      consumerKey: "n58AlgPKH47GIWrmR3eH4vE8z",
      consumerSecret: "vomHhRkABsllgCPRuuqYw6DB5l3pjkBmTRIlAhpE09Mp7ktOSt",
      token: GlobalVariable.accessToken,
      secret: GlobalVariable.accessTokenSecret,
    ),
  );
  }
 
  init(BuildContext _context){
      followerslist = [];
      followinglist = [];
      allselectedlist = [];
      searchList = [];
      fToast = FToast();
      this.context = _context;
      fToast?.init(_context);
      showCircularIndicator = true;
      followerNextCursorId = null;
      followingNextCursorId = null; 
      fetchUserDetail();
  }

  fetchUserDetail() async{
   try{
        DataSnapshot snapshot = await FirebaseDatabase.instance.reference().child("TwitterUsers/${fbAuth.FirebaseAuth.instance.currentUser!.uid}").once();
        print(snapshot.value);
        GlobalVariable.accessToken = snapshot.value["AcessToken"].toString();
        GlobalVariable.accessTokenSecret = snapshot.value["AcessTokenSecret"].toString();
        GlobalVariable.twittedUid = snapshot.value["TwitterId"].toString();
        listOfRetweetId = snapshot.value["RetweetId"]??"";
          print(GlobalVariable.accessToken);
          print(GlobalVariable.accessTokenSecret);
          print(GlobalVariable.twittedUid);
          initTwitterApi();
          //_getUserId();
          //fecthFriendsData();
        }catch(e){
            print(e);
          }
      }

  Future<void> fetchFollowerData({required bool isAgain}) async {
  try {
    print("Fetching follower data");
    PaginatedUsers paginatedUsers;
    if(GlobalVariable.accessToken == ""){
      await Future.delayed(Duration(seconds: 3));
    }
    if(isAgain){
     paginatedUsers = await GlobalVariable.twitterApi!.userService.followersList(count: 10,
     cursor: followerNextCursorId!);
     followerNextCursorId = int.parse(paginatedUsers.nextCursorStr!);
    }else{
     paginatedUsers = await GlobalVariable.twitterApi!.userService.followersList(count: 10);
     followerNextCursorId = int.parse(paginatedUsers.nextCursorStr!);
    }
    
    paginatedUsers.users!.map((e) {
      if(listOfRetweetId!.contains(e.idStr!))
      return followerslist!.add(TwitterUsersModel(user: e, isChecked: true));
      else
      return followerslist!.add(TwitterUsersModel(user: e, isChecked: false));   
      }
      ).toList();
    showCircularIndicator = false;
    Provider.of<FollowerDashboardProvider>(context!, listen: false).renderAgainFollower(errorOccured: false);
    
    } catch (error) {
    print('error while requesting home timeline: ${error}');
    Provider.of<FollowerDashboardProvider>(context!, listen: false).renderAgainFollower(errorOccured: true);
    
  }
}

Future<void> fetchFollowingData({required bool isAgain}) async {
  print("Fetching following data");
  try {
    PaginatedUsers paginatedUsers;
    if(isAgain){
     paginatedUsers = await GlobalVariable.twitterApi!.userService.friendsList(count: 10,
     cursor: followingNextCursorId!);
     followingNextCursorId = int.parse(paginatedUsers.nextCursorStr!);
    }else{
     paginatedUsers = await GlobalVariable.twitterApi!.userService.friendsList(count: 10);
     followingNextCursorId = int.parse(paginatedUsers.nextCursorStr!);
    }

    paginatedUsers.users!.map((e) {
      if(listOfRetweetId!.contains(e.idStr!))
      return followinglist!.add(TwitterUsersModel(user: e, isChecked: true));
      else
      return followinglist!.add(TwitterUsersModel(user: e, isChecked: false));   
      }
      ).toList();
    showCircularIndicator = false;
    Provider.of<FollowingDashboardProvider>(context!, listen: false).renderAgainFollowing(errorOccured: false);
    
    } catch (error) {
    print('error while requesting home timeline: $error');
    Provider.of<FollowingDashboardProvider>(context!, listen: false).renderAgainFollowing(errorOccured: true);
  }
}

Future<void> fetchAllPeopleData({required bool isAgain}) async {
  print("Fetching AllPeople data");
  try {

    DataSnapshot snapshot = await FirebaseDatabase.instance.reference().child("TwitterUsers/${fbAuth.FirebaseAuth.instance.currentUser!.uid}/AddedAccountIds").once();
    
    listOfAccountAddedId = snapshot.value??"";
    List<dynamic> _userDetail = await getUserListDetailId(listOfAccountAddedId! +listOfRetweetId!);
    
    print(allselectedlist);
    _userDetail.forEach((element) { 
    Map _map = element;
    if(listOfRetweetId!.contains(_map["id_str"])){
     allselectedlist!.add(TwitterUsersModel(isChecked: true, user:  User()
        ..idStr = _map["id_str"]
        ..name = _map["name"]
        ..description = _map["description"]
        ..profileImageUrlHttps = _map["profile_image_url_https"]
     ));
    }else{
      allselectedlist!.add(TwitterUsersModel(isChecked: false, user:  User()
        ..idStr = _map["id_str"]
        ..name = _map["name"]
        ..description = _map["description"]
        ..profileImageUrlHttps = _map["profile_image_url_https"]
     
     ));
    }
  });
    showCircularIndicator = false;
    Provider.of<AllSelectedDashboardProvider>(context!, listen: false).renderAgainAllSelected(errorOccured: false);
    
    } catch (error) {
    print('error while requesting home timeline: $error');
    Provider.of<AllSelectedDashboardProvider>(context!, listen: false).renderAgainAllSelected(errorOccured: true);
  }
}

saveRetweetId() async{
  try{
  await FirebaseDatabase.instance.reference().child("TwitterUsers/${fbAuth.FirebaseAuth.instance.currentUser!.uid}").update({
  "RetweetId" : listOfRetweetId,
 });
 fToast?.showToast(
        child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
        ),
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
            Icon(Icons.check),
            SizedBox(
            width: 12.0,
            ),
            Text("Saved Successfully"),
        ],
        )),
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            bottom: 16.0,
            left: 110.0,
          );
        });
  }catch(e){
    print(e);
  }
}



deleteUser(String id_str, bool ischecked) async{
  print("delete user");
  try{ 
  listOfAccountAddedId = listOfAccountAddedId!.replaceAll(",$id_str","");
  if(ischecked){
  listOfRetweetId = listOfRetweetId!.replaceAll(",$id_str","");  
  } 
  FirebaseDatabase.instance.reference().child("TwitterUsers/${fbAuth.FirebaseAuth.instance.currentUser!.uid}").update({
  "AddedAccountIds" : listOfAccountAddedId,});
  if(ischecked)
  allselectedlist!.forEach((element) { 
    if(element.user.idStr!.trim() == id_str.trim()){
      
      FirebaseDatabase.instance.reference().child("TwitterUsers/${fbAuth.FirebaseAuth.instance.currentUser!.uid}").update({
      "RetweetId" : listOfRetweetId,});
    }
  });
  int index = allselectedlist!.indexWhere((element) => element.user.idStr!.trim() == id_str.trim());
  if(index!=-1)
  allselectedlist!.removeAt(index);
  
  Provider.of<AllSelectedDashboardProvider>(context!, listen: false).renderAgainAllSelected(errorOccured: false);

  }
  catch(e){
    print(e);
    Provider.of<AllSelectedDashboardProvider>(context!, listen: false).renderAgainAllSelected(errorOccured: true);
  }    
}    

getUserId(String username) async{
  String url;
  url = "https://api.twitter.com/2/users/by/username/Nikhilvyas14";
  //url = "https://api.twitter.com/2/users/by/username/$username";
  try{
    
  final response = await GlobalVariable.twitterApi!.client.get(Uri.parse("$url")); 
  String id = jsonDecode(response.body)["data"]["id"];
  listOfAccountAddedId = listOfAccountAddedId! + ",${id.trim()}"; 
  List<dynamic> _userDetail = await getUserListDetailId(id);
  Map _map = _userDetail[0];
  allselectedlist!.add(TwitterUsersModel(isChecked: false, user:  User()
      ..idStr = id
      ..name = _map["name"]
      ..description = _map["description"]
      ..profileImageUrlHttps = _map["profile_image_url_https"]
      ));
  FirebaseDatabase.instance.reference().child("TwitterUsers/${fbAuth.FirebaseAuth.instance.currentUser!.uid}").update({
  "RetweetId" : listOfAccountAddedId,});
  
  Provider.of<AllSelectedDashboardProvider>(context!, listen: false).renderAgainAllSelected(errorOccured: false);

  }
  catch(e){
    print(e);
    Provider.of<AllSelectedDashboardProvider>(context!, listen: false).renderAgainAllSelected(errorOccured: true);
  }    
}    

Future<List<dynamic>> getUserListDetailId(String query) async{
  print("get user list detailId");
  String url;
  url = "https://api.twitter.com/1.1/users/lookup.json?user_id=$query";
  print(url);
  try{
    
  final response = await GlobalVariable.twitterApi!.client.get(Uri.parse("$url")); 
  List<dynamic> _userDetail = jsonDecode(response.body); 
  return _userDetail;
  
  }
  catch(e){
    print(e);
    return [];
  }    
}

searchQuery(String query) async{
  print("search query");
  String url;
  url = "https://api.twitter.com/1.1/users/search.json?q=$query&count=20";
  searchList = [];
  showCircularIndicator = true;
  Provider.of<SearchUserProvider>(context!, listen: false).renderSearchUser(errorOccured: false);
  try{  
  final response = await GlobalVariable.twitterApi!.client.get(Uri.parse("$url")); 
  List<dynamic> _userDetail = jsonDecode(response.body);

  _userDetail.forEach((element) { 
    Map _map = element;
      searchList!.add(TwitterUsersModel(isChecked: false, user:  User()
        ..idStr = _map["id_str"]
        ..name = _map["name"]
        ..description = _map["description"]
        ..profileImageUrlHttps = _map["profile_image_url_https"]
     
     ));
    
  });
  showCircularIndicator = false;
  Provider.of<SearchUserProvider>(context!, listen: false).renderSearchUser(errorOccured: false);
  print("length===========${_userDetail.length}");
  print("------------------------");
  }
  catch(e){
    print(e);
    Provider.of<SearchUserProvider>(context!, listen: false).renderSearchUser(errorOccured: true);
  }    
}

selectFromSearchUsers(TwitterUsersModel model){
  print("select from search user");
 allselectedlist!.add(TwitterUsersModel(isChecked: false, user:  User()
        ..idStr = model.user.idStr
        ..name = model.user.name
        ..description = model.user.description
        ..profileImageUrlHttps = model.user.profileImageUrlHttps
     
     ));
 try{    
  if(!listOfAccountAddedId!.contains( model.user.idStr!))
   {
     listOfAccountAddedId = listOfAccountAddedId! + "," + "${model.user.idStr}";
  
     FirebaseDatabase.instance.reference().child("TwitterUsers/${fbAuth.FirebaseAuth.instance.currentUser!.uid}").update({
     "AddedAccountIds" : listOfAccountAddedId,});
   }                             
  Provider.of<AllSelectedDashboardProvider>(context!, listen: false).renderAgainAllSelected(errorOccured: false);
 }
 catch(e){
   print(e);
 } 
}

}