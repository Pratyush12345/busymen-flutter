import 'package:flutter/cupertino.dart';

class ChangeBottomTabProvider extends ChangeNotifier {
 int selectedIndex = 0; 
 void changeBottomTabProvider({required int selectedIndexLocal }){
    selectedIndex = selectedIndexLocal;
    notifyListeners();
  }
}
