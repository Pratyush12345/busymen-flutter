import 'package:Busyman/screens/Twitter/backend/providers/change_bottom_tab_provider.dart';
import 'package:Busyman/screens/Twitter/backend/utils/global_variable.dart';
import 'package:Busyman/screens/Twitter/frontened/retweets_show.dart';
import 'package:Busyman/screens/Twitter/frontened/tabs_twitter/search_user.dart';
import 'package:Busyman/services/sizeconfig.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TwitterDashboardTopView extends StatefulWidget {
  final String headerName;
  TwitterDashboardTopView({required this.headerName});

  @override
  _TwitterDashboardTopViewState createState() => _TwitterDashboardTopViewState();
}

class _TwitterDashboardTopViewState extends State<TwitterDashboardTopView> {
  late App _app;

void showTwitterLogoutDialog(){
     showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    title: const Text(
                      'Are You sure, You want to Logout?',
                      style: TextStyle(
                          color: Color(0xff2E2E2E),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () async {
                           GlobalVariable.accessToken = "";
                           GlobalVariable.accessTokenSecret = "";
                           GlobalVariable.twittedUid = ""; 
                           FirebaseDatabase.instance.reference().child("TwitterUsers/${FirebaseAuth.instance.currentUser!.uid}/").update({
                             "RetweetId" : ""
                           });
                           SharedPreferences _pref = await SharedPreferences.getInstance();
                           _pref.remove("IsTwitterLoggedIn");
                           Navigator.of(ctx).pop();
                           Provider.of<ChangeBottomTabProvider>(context, listen: false).changeBottomTabProvider(selectedIndexLocal: 2);
                             },
                          child: Text('Yes')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('No'))
                    ],
                  );
                });
  }

  @override
  Widget build(BuildContext context) {
    _app = App(context);
    return SizedBox(
      height: _app.appHeight(18),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: const [Color(0xff205072), Color(0xff329D9C)])),
            width: MediaQuery.of(context).size.width,
            height: _app.appHeight(18),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // IconButton(icon: Icon(Icons.arrow_back_ios,
                    // color: Colors.white,), onPressed: (){
                    //  Navigator.of(context).pop();
                    // }),
                    Text.rich(
                      TextSpan(
                        text: '${widget.headerName}',
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: _app.appVerticalPadding(widget.headerName.contains("Dashboard")?12:16),
            left: 0.0,
            right: 0.0,
            child: Container(
              alignment: Alignment.center,
              height: _app.appHeight(6),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                      width: _app.appWidth(80),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () async {
                                showTwitterLogoutDialog();
                                },
                                icon: Icon(Icons.logout, color: Colors.white,)),
                            IconButton(
                                onPressed: () async {
                                 Navigator.of(context).push(MaterialPageRoute(builder:(context) => SearchUser()));
  
 
                                },
                                icon: Hero(
                                  tag: "SearchBar",
                                  child: Icon(Icons.search, color: Colors.white,))),
                            
                            IconButton(
                                onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RetweetShow()));
                    
                                },
                                icon: const Image(
                                  image:
                                      AssetImage('assets/icons/reminder.png'),
                                  color: Colors.white,
                                ))
                          ]),
                    )
            ),
          )
        ],
      ),
    );
  }
}
