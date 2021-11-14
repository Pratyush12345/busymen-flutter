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