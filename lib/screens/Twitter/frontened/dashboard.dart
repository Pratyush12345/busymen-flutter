import 'package:busyman/screens/Twitter/backend/providers/dashboard_provider.dart';
import 'package:busyman/screens/Twitter/backend/utils/appconstant.dart';
import 'package:busyman/screens/Twitter/backend/utils/global_variable.dart';
import 'package:busyman/screens/Twitter/backend/utils/models.dart';
import 'package:busyman/screens/Twitter/backend/view_models/dashboard_vm.dart';
import 'package:busyman/screens/Twitter/frontened/TopBars/topbar.dart';
import 'package:busyman/screens/Twitter/frontened/TopBars/topbar_dashbaord.dart';
import 'package:busyman/services/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TwitterDashboard extends StatefulWidget {
  const TwitterDashboard({ Key? key}) : super(key: key);

  @override
  _TwitterDashboardState createState() => _TwitterDashboardState();
}

class _TwitterDashboardState extends State<TwitterDashboard> {
late App _app;
ScrollController controller = ScrollController();



void _scrollListener() {
  if (controller.offset >= controller.position.maxScrollExtent &&
      !controller.position.outOfRange) {
    print("at the end of list");
    DashboardVM.instance.showCircularIndicator = true;
    DashboardVM.instance.fetchFollowerData(isAgain: true);
  }
}

  @override
    void initState() {
      DashboardVM.instance.init(context);
      controller.addListener(_scrollListener);
      super.initState();
  }
  
  @override
    void dispose() {
      super.dispose();
    }
  @override
  Widget build(BuildContext context) {
     _app = App(context);
    return Scaffold(
    //  appBar: AppBar(title: Text("Twitter Dashboard"),),
     body: Column(
       children: [
         TwitterDashboardTopView(headerName: "Twitter Dashboard"),
          SizedBox(
            height: _app.appVerticalPadding(4.5),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                    'Followers List',
                    style: TextStyle(
                    color: Color(0xff297687),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
         Consumer<FollowingDashboardProvider>(
           builder: (context, _, child)=> Expanded(
             child: DashboardVM.instance.showCircularIndicator!? AppConstant.circulerProgressIndicator(): ListView(
               children: [
                 Container(
                   width: MediaQuery.of(context).size.width,
                   height: MediaQuery.of(context).size.height * 0.8,
                   child: ListView.builder(
                     padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                     itemCount: DashboardVM.instance.followerslist!.length,
                     controller: controller,
                     itemBuilder: (context, index){
                      TwitterUsersModel _twitterUserModel = DashboardVM.instance.followerslist![index];
                      return Column(
                        children: [
                          ListTile(
                            tileColor: Color(0xffF3F3F3),
                            title: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text("${_twitterUserModel.user.name}",
                              style: TextStyle(color: Colors.black,
                              fontSize: 15.0),),
                            ),
                            subtitle: Text("${_twitterUserModel.user.description}",
                            style: TextStyle(color: Colors.black,
                            fontSize: 13.0),),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              child: Image.network("${_twitterUserModel.user.profileImageUrlHttps}",
                              )
                              ),
                            trailing: Checkbox(
                              value: _twitterUserModel.isChecked ,
                              onChanged: (val){
                                _twitterUserModel.isChecked = val!;
                                if(val){
                                   if(!DashboardVM.instance.listOfRetweetId!.contains( _twitterUserModel.user.idStr!))
                                  DashboardVM.instance.listOfRetweetId = DashboardVM.instance.listOfRetweetId! + "," + "${_twitterUserModel.user.idStr}";
                                }
                                else{
                                  DashboardVM.instance.listOfRetweetId = DashboardVM.instance.listOfRetweetId!.replaceAll(",${_twitterUserModel.user.idStr}","");
                                }
                                setState(() {});
                              },
                            ),
                          ),
                          
                          SizedBox(height: 15.0,),
                        ],
                      );
                   }),
                 ),
                               ],
                 
             ),
             
           ),
         ),
         SizedBox(height: 20.0,),
               InkWell(
                 onTap: (){
                   DashboardVM.instance.saveRetweetId();
                 },
                 child: Center(
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
                 )),    
             
               SizedBox(height: 15.0,),
              //  InkWell(
              //    onTap: (){
              //      Auth.instance.logout();
              //    },
              //    child: Center(
              //      child: Container(
              //        alignment: Alignment.center,
              //        height: 30.0,
              //        width: 100.0,
              //        decoration: BoxDecoration(
              //          color: Colors.blue,
              //          borderRadius: BorderRadius.circular(12.0)
              //        ),
              //        child: Text("Log Out",
              //        style: TextStyle(color: Colors.white))),
              //    )),
              //  SizedBox(height: 25.0,),  
              //  InkWell(
              //    onTap: (){
              //      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RetweetShow()));
              //      },
              //    child: Center(
              //      child: Container(
              //        alignment: Alignment.center,
              //        height: 30.0,
              //        width: 100.0,
              //        decoration: BoxDecoration(
              //          color: Colors.blue,
              //          borderRadius: BorderRadius.circular(12.0)
              //        ),
              //        child: Text("Retweet",
              //        style: TextStyle(color: Colors.white))),
              //    )),
 
       ],
     ),
    );
  }
}