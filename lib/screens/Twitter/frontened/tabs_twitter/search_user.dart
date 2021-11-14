import 'package:busyman/screens/Twitter/backend/providers/dashboard_provider.dart';
import 'package:busyman/screens/Twitter/backend/utils/appconstant.dart';
import 'package:busyman/screens/Twitter/backend/utils/models.dart';
import 'package:busyman/screens/Twitter/backend/view_models/dashboard_vm.dart';
import 'package:busyman/services/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({ Key? key }) : super(key: key);

  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  late App _app;
  TextEditingController? _searchController;
  
  void showselectPeopleDialog(TwitterUsersModel model){
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
                DashboardVM.instance.selectFromSearchUsers(model);
                Navigator.of(ctx).pop();
                Navigator.of(context).pop();
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
            Text("Are You sure, You want to add this user?",
            style: TextStyle(fontSize: 18.0, color: Colors.black),),
          ],),
        ),
      ),
    );
  }

  @override
    void initState() {
      _searchController = TextEditingController();
      DashboardVM.instance.showCircularIndicator = false; 
      super.initState();
     
    }

  @override
    void dispose() {
      _searchController!.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    _app = App(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: _app.appHeight(6),),
              Hero(          
                tag: "SearchBar",
                child: Container(
                  child: Material(
                    child: TextField(
                                controller: _searchController,
                                textAlign: TextAlign.center,
                                showCursor: true,
                                autofocus: true,
                                onChanged: (val) {},
                                onEditingComplete: (){
                                  DashboardVM.instance.searchQuery(_searchController!.text.trim());
                                },
                                decoration:  InputDecoration(
                                    hintText: "Search",
                                    suffixIcon: Icon(
                                      Icons.search,
                                      color: Color(0xff297687),
                                    ),
                                    prefixIcon: InkWell(
                                      onTap: (){
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(
                                        Icons.arrow_back_outlined,
                                        color: Color(0xff297687)),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(35)),
                                        borderSide: BorderSide(
                                            width: 1, color: Color(0xff297687)))),
                              ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Container(
                height: MediaQuery.of(context).size.height*0.8,
                child: Consumer<SearchUserProvider>(
                  builder: (context, model, child)=> 
                    model.boolerrorOccured?AppConstant.noDataFound("Error Occured. Please Try Again later."):
                    DashboardVM.instance.showCircularIndicator!?AppConstant.circulerProgressIndicator(): DashboardVM.instance.searchList!.isEmpty?
                    AppConstant.noDataFound("No Search Found"):
                    ListView.builder(
                    itemCount: DashboardVM.instance.searchList!.length,
                    itemBuilder: (context, index){
                      TwitterUsersModel _twitterUserModel = DashboardVM.instance.searchList![index];
                      return Column(
                                children: [
                                  ListTile(
                                    onTap: (){
                                      showselectPeopleDialog(_twitterUserModel);
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
                                    // trailing: Checkbox(
                                    //   value: _twitterUserModel.isChecked ,
                                    //   onChanged: (val){
                                    //     _twitterUserModel.isChecked = val!;
                                    //     if(val){
                                    //        if(!DashboardVM.instance.listOfRetweetId!.contains( _twitterUserModel.user.idStr!))
                                    //       DashboardVM.instance.listOfRetweetId = DashboardVM.instance.listOfRetweetId! + "," + "${_twitterUserModel.user.idStr}";
                                    //     }
                                    //     else{
                                    //       DashboardVM.instance.listOfRetweetId = DashboardVM.instance.listOfRetweetId!.replaceAll(",${_twitterUserModel.user.idStr}","");
                                    //     }
                                    //     setState(() {});
                                    //   },
                                    // ),
                                  ),
                                  
                                  SizedBox(height: 15.0,),
                                ],
                              ); 
                    },
                  ),
                ),
                )
            ],
          ),
        ),
      ),
    );
  }
}