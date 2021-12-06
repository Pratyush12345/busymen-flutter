import 'package:Busyman/screens/Twitter/frontened/retweets_show.dart';
import 'package:Busyman/screens/Twitter/frontened/tabs_twitter/search_user.dart';
import 'package:Busyman/screens/Twitter/frontened/twitter_signin.dart';
import 'package:Busyman/services/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TwitterTopView extends StatelessWidget {
  late App _app;
  final String headerName;
  TwitterTopView({required this.headerName});

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    SizedBox(
                      width: _app.appWidth(40),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if(headerName.contains("Dashboard"))
                            IconButton(
                                onPressed: () async {
                                 SharedPreferences _pref = await SharedPreferences.getInstance();
                                 _pref.remove("IsTwitterLoggedIn");
                                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => TwitterSignIn()));
  
 
                                },
                                icon: Icon(Icons.logout, color: Colors.white,)),
                            if(headerName.contains("Dashboard"))
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
                  ],
                ),
              ),
            ),
          ),
          if(headerName.contains("Profile"))
          Positioned(
            top: _app.appVerticalPadding(12),
            left: 0.0,
            right: 0.0,
            child: CircleAvatar(
              radius: 54.0,
              backgroundColor: Colors.grey,
              child: ClipOval(
                
                child: Image.network(
                  "https://www.ewc.edu/wp-content/uploads/person-icon-silhouette-png-0.png",
                  height: 100,
                  width: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            
            ),
          
        ],
      ),
    );
  }
}
