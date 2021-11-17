import 'package:busyman/screens/Twitter/backend/providers/dashboard_provider.dart';
import 'package:busyman/screens/Twitter/backend/view_models/dashboard_vm.dart';
import 'package:busyman/screens/Twitter/frontened/TopBars/topbar_dashbaord.dart';
import 'package:busyman/screens/Twitter/frontened/tabs_twitter/all_people.dart';
import 'package:busyman/screens/Twitter/frontened/tabs_twitter/follower_list_tab.dart';
import 'package:busyman/screens/Twitter/frontened/tabs_twitter/following_list_tab.dart';
import 'package:busyman/screens/Twitter/frontened/TopBars/topbar.dart';
import 'package:busyman/services/sizeconfig.dart';
import 'package:flutter/material.dart';

class Dashboard_Tabbar extends StatefulWidget {
  const Dashboard_Tabbar({ Key? key }) : super(key: key);

  @override
  _Dashboard_TabbarState createState() => _Dashboard_TabbarState();
}

class _Dashboard_TabbarState extends State<Dashboard_Tabbar> {
  late App _app;
  @override
    void initState() {
      DashboardVM.instance.init(context);    
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
     _app = App(context);
    
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
       body: Column(children: [
         TwitterDashboardTopView(headerName: "Twitter Dashboard"),
         
         Container(
           width: MediaQuery.of(context).size.width,
           height: 50.0,
           child: TabBar(tabs: [
             Tab(child: Text(
                        'Followers',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                        ),
                      ),
             ),
             Tab(child: Text(
                        'Following',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                        ),
                      ),),
            Tab(child: Text(
                        'All People',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                        ),
                      ),),          
           ]),
         ),
         Expanded(flex: 3,
         child: TabBarView(
           children: [
             FollowersListTab(),
             FollowingListTab(),
             AllSelectedPeopleTab()
           ]),),
        SizedBox(height: 15.0,),      
        InkWell(
                 onTap: (){
                   DashboardVM.instance.saveRetweetId();
                 },
                 child: Center(
                   child: Hero(
                     tag: "Twitter",
                     child: Container(
                       alignment: Alignment.center,
                       height: 40.0,
                       width: 150.0,
                       decoration: BoxDecoration(
                         color: Color(0xff205072),
                         borderRadius: BorderRadius.circular(12.0)
                       ),
                       child: Text("Save",
                       style: TextStyle(color: Colors.white),)),
                   ),
                 )),   
        SizedBox(height: 10.0,),          
       ],),
      ),);
  }
}