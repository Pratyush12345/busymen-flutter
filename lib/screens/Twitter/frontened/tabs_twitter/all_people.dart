import 'package:busyman/screens/Twitter/backend/providers/dashboard_provider.dart';
import 'package:busyman/screens/Twitter/backend/utils/appconstant.dart';
import 'package:busyman/screens/Twitter/backend/utils/models.dart';
import 'package:busyman/screens/Twitter/backend/view_models/dashboard_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllSelectedPeopleTab extends StatefulWidget {
  const AllSelectedPeopleTab({ Key? key }) : super(key: key);

  @override
  _AllSelectedPeopleTabState createState() => _AllSelectedPeopleTabState();
}

class _AllSelectedPeopleTabState extends State<AllSelectedPeopleTab> {
  
  ScrollController controller = ScrollController();
  TextEditingController _namecontroller = TextEditingController();
  
  @override
    void initState() {  
      if(DashboardVM.instance.allselectedlist==null || DashboardVM.instance.allselectedlist!.isEmpty){
      DashboardVM.instance.showCircularIndicator = true;
      DashboardVM.instance.fetchAllPeopleData(isAgain: false);
      }
      else{
        DashboardVM.instance.showCircularIndicator = false;
      }
      controller.addListener(_scrollListener);
      
      super.initState();
    }

  void _scrollListener() {
  if (controller.offset >= controller.position.maxScrollExtent &&
      !controller.position.outOfRange) {
    print("at the end of list");
    //DashboardVM.instance.fetchFollowingData(isAgain: true);
  }
}
void showDeletePeopleDialog(String id_str, bool ischecked){
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        // backgroundColor: const Color(0xff297687),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                DashboardVM.instance.deleteUser(id_str, ischecked);
                Navigator.of(ctx).pop();
                // Navigator.of(context).pop();
              },
              child: const Text('Ok'))
        ],
        content: Container(
          height: 200.0,
          width: 500.0,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(

              // color: Colors.white,
              borderRadius: BorderRadius.circular(15)),
          child: Column(children: [
            Text("Are You sure, You want to delete this user?",
            style: TextStyle(fontSize: 18.0, color: Colors.black),),
          ],),
        ),
      ),
    );
  }

  void showAddPeopleDialog(){
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        // backgroundColor: const Color(0xff297687),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                DashboardVM.instance.getUserId(_namecontroller.text);
                Navigator.of(ctx).pop();
                setState(() {});
                // Navigator.of(context).pop();
              },
              child: const Text('Ok'))
        ],
        content: Container(
          height: 200.0,
          width: 500.0,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(

              // color: Colors.white,
              borderRadius: BorderRadius.circular(15)),
          child: Column(children: [
            TextFormField(
                    controller: _namecontroller,
                    keyboardType: TextInputType.name,
                    validator: (str) {
                      if (str == null || str.isEmpty) {
                        return 'This field can not be empty';
                      }
                    },
                    decoration:
                        const InputDecoration(labelText: 'User name'),
                  ),
          ],),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showAddPeopleDialog();
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: Consumer<AllSelectedDashboardProvider>(
          builder: (context, model , child)=>
          model.boolerrorOccured? AppConstant.noDataFound("Error Occured. Please Try Again later.") : DashboardVM.instance.showCircularIndicator! ? AppConstant.circulerProgressIndicator() :
          DashboardVM.instance.allselectedlist!.isEmpty? AppConstant.noDataFound("No Data Found."):
          Container(
                         width: MediaQuery.of(context).size.width,
                         height: MediaQuery.of(context).size.height * 0.8,
                         child: ListView.builder(
                           padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                           itemCount: DashboardVM.instance.allselectedlist!.length,
                           controller: controller,
                           itemBuilder: (context, index){
                            TwitterUsersModel _twitterUserModel = DashboardVM.instance.allselectedlist![index];
                            return Column(
                              children: [
                                ListTile(
                                  onLongPress: (){
                                    showDeletePeopleDialog(_twitterUserModel.user.idStr!, _twitterUserModel.isChecked);
                                  },
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
        ),
      ),
    );
  }
}