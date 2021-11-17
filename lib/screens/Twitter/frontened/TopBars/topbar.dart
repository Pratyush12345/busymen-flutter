import 'package:busyman/screens/Twitter/frontened/retweets_show.dart';
import 'package:busyman/screens/Twitter/frontened/tabs_twitter/search_user.dart';
import 'package:busyman/screens/Twitter/frontened/twitter_signin.dart';
import 'package:busyman/services/sizeconfig.dart';
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
          // Positioned(
          //   top: _app.appVerticalPadding(headerName.contains("Dashboard")?12:16),
          //   left: 0.0,
          //   right: 0.0,
          //   child: Container(
          //     height: _app.appHeight(6),
          //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //     child: DecoratedBox(
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(25.0),
          //           border: Border.all(width: 1.0),
          //           color: Colors.white,
          //           shape: BoxShape.rectangle,
          //           boxShadow: const [
          //             BoxShadow(
          //                 offset: Offset(1.0, 4.0),
          //                 blurRadius: 4.0,
          //                 spreadRadius: -1.0,
          //                 color: Colors.grey,
          //                 //blurStyle: BlurStyle.normal
          //                 ),
          //           ]),
          //       child: Row(
          //         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Expanded(
          //             child: TextField(
          //               textAlign: TextAlign.center,
          //               showCursor: false,
          //               onChanged: (val) {},
          //               onTap: (){
          //                if(headerName.contains("Dashboard"))
          //                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchUser()));
          //               },
          //               decoration: const InputDecoration(
          //                   hintText: "Search",
          //                   suffixIcon: Icon(
          //                     Icons.search,
          //                     color: Color(0xff297687),
          //                   ),
          //                   border: OutlineInputBorder(
          //                       borderRadius:
          //                           BorderRadius.all(Radius.circular(25)),
          //                       borderSide: BorderSide(
          //                           width: 1, color: Color(0xff297687)))),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
