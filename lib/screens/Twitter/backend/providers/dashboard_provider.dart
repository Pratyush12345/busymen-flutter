import 'package:busyman/models/models.dart';
import 'package:flutter/cupertino.dart';

class FollowerDashboardProvider extends ChangeNotifier {
 bool boolerrorOccured = false; 
 void renderAgainFollower({required bool errorOccured }){
    boolerrorOccured = errorOccured;
    notifyListeners();
  }
}

class FollowingDashboardProvider extends ChangeNotifier {
 bool boolerrorOccured = false; 
 void renderAgainFollowing({required bool errorOccured }){
    boolerrorOccured = errorOccured;
    notifyListeners();
  }
}

class AllSelectedDashboardProvider extends ChangeNotifier {
 bool boolerrorOccured = false; 
 void renderAgainAllSelected({required bool errorOccured }){
    boolerrorOccured = errorOccured;
    notifyListeners();
  }
}

class SearchUserProvider extends ChangeNotifier {
 bool boolerrorOccured = false; 
 void renderSearchUser({required bool errorOccured }){
    boolerrorOccured = errorOccured;
    notifyListeners();
  }
}

class UserProfileProvider extends ChangeNotifier {
 bool boolerrorOccured = false; 
 UserDetailModel? usermodel;
 void changeUserProfileProvider({required bool errorOccured,required UserDetailModel modelLocal, }){
    boolerrorOccured = errorOccured;
    usermodel = modelLocal;
    notifyListeners();
  }
}

class ChangeAddTaskImageProvider extends ChangeNotifier {
 
 void changeAddTaskImageProvider(){
    notifyListeners();
  }
}