import 'package:busyman/screens/Twitter/backend/providers/change_bottom_tab_provider.dart';
import 'package:busyman/screens/Twitter/backend/view_models/wrapper_twitter.dart';
import 'package:busyman/screens/reminder/allreminders.dart';
import 'package:busyman/screens/tasks/Bottom_Tabs/Task_tab.dart';
import 'package:busyman/screens/tasks/Bottom_Tabs/profile_tab.dart';
import 'package:busyman/services/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllTasks extends StatefulWidget {
  const AllTasks({Key? key}) : super(key: key);

  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  int _currentIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ChangeBottomTabProvider>(
        builder: (context,model, child)=>
        model.selectedIndex == 0? TaskTab() :
        model.selectedIndex == 1? AllReminders():
        model.selectedIndex == 2? WrapperTwitter():  ProfileTab()
        ),

      floatingActionButton:
      Provider.of<ChangeBottomTabProvider>(context).selectedIndex<2? FloatingActionButton(
        onPressed: () {
          if(Provider.of<ChangeBottomTabProvider>(context, listen: false).selectedIndex==0){
            Navigator.of(context).pushNamed('/AddTask');
          }
          else{
            Navigator.of(context).pushNamed('/AddReminder');
          }
          
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xff205072),
      ):null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Consumer<ChangeBottomTabProvider>(
        builder: (context, model, child)=> BottomNavigationBar(
          onTap: (val) {
             Provider.of<ChangeBottomTabProvider>(context, listen: false).changeBottomTabProvider(selectedIndexLocal: val);
           
          },

          currentIndex: _currentIndex,
          showSelectedLabels: false,
          iconSize: 22,
           
          //landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          type: BottomNavigationBarType.fixed,
          items: [
             BottomNavigationBarItem(
                icon: Icon(
                  Icons.fact_check_sharp,
                  color: model.selectedIndex == 0 ? Color(0xff205072): Color(0xffB7B7B7),
                  size: 22,
                ),

                label: ''),
             BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_today,
                  color: model.selectedIndex == 1 ? Color(0xff205072): Color(0xffB7B7B7),
                  size: 22,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Hero(
                  tag: "Twitter",
                  child: Image.asset('assets/icons/twitter.png', color: model.selectedIndex == 2 ? Color(0xff205072): Color(0xffB7B7B7),)),
                   label: ''),
             BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: model.selectedIndex == 3 ? Color(0xff205072): Color(0xffB7B7B7),
                  size: 22,
                ),
                label: ''),
          ],
        ),
      ),
    );
  }
}
