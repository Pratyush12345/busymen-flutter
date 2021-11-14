import 'package:busyman/screens/Twitter/backend/providers/change_bottom_tab_provider.dart';
import 'package:busyman/screens/Twitter/frontened/retweets_show.dart';
import 'package:busyman/screens/Twitter/frontened/tabs_twitter/search_user.dart';
import 'package:busyman/screens/Twitter/frontened/twitter_signin.dart';
import 'package:busyman/services/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TwitterDashboardTopView extends StatelessWidget {
  late App _app;
  final String headerName;
  TwitterDashboardTopView({required this.headerName});

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
                        text: '$headerName',
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
            top: _app.appVerticalPadding(headerName.contains("Dashboard")?12:16),
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
                                 SharedPreferences _pref = await SharedPreferences.getInstance();
                                 _pref.remove("IsTwitterLoggedIn");
                                 //Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => TwitterSignIn()));
                                 Provider.of<ChangeBottomTabProvider>(context, listen: false).changeBottomTabProvider(selectedIndexLocal: 2);
 
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
