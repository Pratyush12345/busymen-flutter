import 'package:busyman/screens/Twitter/backend/providers/dashboard_provider.dart';
import 'package:busyman/screens/Twitter/backend/utils/appconstant.dart';
import 'package:busyman/screens/Twitter/backend/utils/models.dart';
import 'package:busyman/screens/Twitter/backend/view_models/dashboard_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FollowersListTab extends StatefulWidget {
  const FollowersListTab({ Key? key }) : super(key: key);

  @override
  _FollowersListTabState createState() => _FollowersListTabState();
}

class _FollowersListTabState extends State<FollowersListTab> {

ScrollController controller = ScrollController();

@override
    void initState() { 
      if(DashboardVM.instance.followerslist==null || DashboardVM.instance.followerslist!.isEmpty){
      DashboardVM.instance.showCircularIndicator = true;
      DashboardVM.instance.fetchFollowerData(isAgain: false);
      }else{
        DashboardVM.instance.showCircularIndicator = false;
      }
      controller.addListener(_scrollListener);    
      super.initState();
  }

void _scrollListener() {
  if (controller.offset >= controller.position.maxScrollExtent &&
      !controller.position.outOfRange) {
    print("at the end of list");
    DashboardVM.instance.fetchFollowerData(isAgain: true);
  }
}

  @override
  Widget build(BuildContext context) {
  
    return Consumer<FollowerDashboardProvider>(
      builder: (context, model,child)=>
      model.boolerrorOccured? AppConstant.noDataFound("Error Occured. Please Try Again later.") : DashboardVM.instance.showCircularIndicator! ? AppConstant.circulerProgressIndicator() :
      DashboardVM.instance.followerslist!.isEmpty? AppConstant.noDataFound("No Data Found."):
      
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
    );
  }
}