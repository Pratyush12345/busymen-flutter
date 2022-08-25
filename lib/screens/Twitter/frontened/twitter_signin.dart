
import 'package:Busyman/screens/Twitter/backend/providers/change_bottom_tab_provider.dart';
import 'package:Busyman/screens/Twitter/backend/utils/global_variable.dart';
import 'package:Busyman/screens/tasks/alltaskstopwidget.dart';
import 'package:Busyman/services/appColor.dart';
import 'package:Busyman/services/sizeconfig.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:dart_twitter_api/twitter_api.dart';

class TwitterSignIn extends StatefulWidget {
  const TwitterSignIn({ Key? key }) : super(key: key);

  @override
  _TwitterSignInState createState() => _TwitterSignInState();
}

class _TwitterSignInState extends State<TwitterSignIn> {
  TwitterLogin? twitterLogin;
  TwitterApi? twitterApi;
  late App _app;
  
  storeUserDetail() async{
  print(GlobalVariable.accessToken);
  print(GlobalVariable.accessTokenSecret);
  print(GlobalVariable.twittedUid);
  try{
  await FirebaseDatabase.instance.reference().child("TwitterUsers/${FirebaseAuth.instance.currentUser!.uid}").update({
  "AcessToken" : GlobalVariable.accessToken,
  "AcessTokenSecret" : GlobalVariable.accessTokenSecret,
  "TwitterId" : GlobalVariable.twittedUid,
  "RetweetId" : ""
  });
  
  SharedPreferences _pref = await SharedPreferences.getInstance();
  _pref.setBool("IsTwitterLoggedIn", true);
  //Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => Dashboard_Tabbar()));
  Provider.of<ChangeBottomTabProvider>(context, listen: false).changeBottomTabProvider(selectedIndexLocal: 2); 
  }catch(e){
    print(e);
  }
}
Future<void> fecthdata() async {
  
  try {
    // twitterApi = TwitterApi(
    //                     client: TwitterClient(
    //                       consumerKey: "n58AlgPKH47GIWrmR3eH4vE8z",
    //                       consumerSecret: "vomHhRkABsllgCPRuuqYw6DB5l3pjkBmTRIlAhpE09Mp7ktOSt",
    //                       // token: result.authToken,
    //                       // secret: result.authTokenSecret
    //                       token: "620757286-BPZuCXML1SXbmyECresO1cqs7dDgmOBnB6PngoQO",
    //                       secret: "kDaeOIFzfYDfBfetHad9TJgP2h2A0LZIjCkRMxuXTuf1P",
    //                     ),
    //                   );
    // Get the last 200 tweets from your home timeline
    // PaginatedUsers paginatedUsers =   await twitterApi.userService.followersList();
    // paginatedUsers.users.forEach((element) { 
    //   print("usersssssssssssssssss");
    //   print(element.screenName);
    //   print(element.name);
    //   print("usersssssssssssssssss");
    // });
    // final homeTimeline = await twitterApi.timelineService.homeTimeline(
    //   count: 1,
    // );

    // Print the text of each Tweet

    // homeTimeline.forEach((tweet) async{ 
    //   print(tweet.fullText);
    //   print(tweet.idStr);
    //   await twitterApi.tweetService.retweet(id: tweet.idStr).catchError((error){
    //     print( "Error ${error}");
    //   });  
    //   });

    
    //Update your status (tweet)
    //  twitterApi.tweetService.update(
    //   status: 'gurucool crossed its limit',
    // );
  } catch (error) {
    // Requests made by the client can throw the following errors:
    //
    // * `TimeoutException` when a request hasn't returned a response for some
    //   time (defaults to 10s, can be changed in the TwitterClient).
    //
    // * `Response` when the received response does not have a 2xx status code.
    //   Most responses include additional error information that can be parsed
    //   manually from the response's body.
    //
    // * Other unexpected errors in unlikely events (for example when parsing
    //   the response).
    print('error while requesting home timeline: ${ error }');
  }
}
  @override
    void initState() {
      
      twitterLogin = TwitterLogin(
         apiKey: "n58AlgPKH47GIWrmR3eH4vE8z",
         apiSecretKey: "vomHhRkABsllgCPRuuqYw6DB5l3pjkBmTRIlAhpE09Mp7ktOSt",
         redirectURI: "twittersdk://"
        // consumerKey: "kkOvaF1Mowy4JTvCxKTV5O1WF",
        // consumerSecret: "ZECGsI6UUDBEUVGkJe4S5vd0FGqGxC3wMJCgsXgPRfjSwRFnyH"
      );
      super.initState();
    }
  
  @override
  Widget build(BuildContext context) {
    
    _app = App(context);
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopView(headername: "Retweets",),
            
            SizedBox(
              height: _app.appVerticalPadding(15),
            ),
            Container(
              height: 110,
                    width: 110,
              child: Hero(
                tag: "Twitter",
                child: Image.asset(
                      'assets/images/twitter_logo.png',
                      fit: BoxFit.contain,
                      color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 30.0,),
            Text("Connect With Twitter",
            style: TextStyle(
             color: Colors.blue,
             fontSize: 22.0
            ),),
            SizedBox(height: _app.appHeight(28),),
            TextButton(
                      onPressed: () {
                          twitterLogin!.login().then((result) {
                      
                      print("-------------------------");
                      print("status ..................${result.user!.id}");
                      print("auth token ..............${result.authToken}");
                      print("authtoken secret.........${result.authTokenSecret}");
                      GlobalVariable.accessToken = result.authToken!;
                      GlobalVariable.accessTokenSecret = result.authTokenSecret!;
                      GlobalVariable.twittedUid = result.user!.id.toString();
                      print("-------------------------");
                      switch(result.status){
                        case TwitterLoginStatus.loggedIn:
                        final AuthCredential twitterAuthCredential =
                          TwitterAuthProvider.credential(
                              accessToken: result.authToken!,
                              secret: result.authTokenSecret!);
                          storeUserDetail();
                          // twitterApi = TwitterApi(
                          //     client: TwitterClient(
                          //       consumerKey: "n58AlgPKH47GIWrmR3eH4vE8z",
                          //       consumerSecret: "vomHhRkABsllgCPRuuqYw6DB5l3pjkBmTRIlAhpE09Mp7ktOSt",
                          //       token: result.authToken,
                          //       secret: result.authTokenSecret
                          //       //token: "620757286-3oB4BkNbGWuj0ycYYaMo1cudUAbfZ54aMEEgelct",
                          //       //secret: "rsuj1WVUr1m3BOiNlLBlff2vAhLvVioqbKKY1sQl3JHGY",
                          //     ),
                          //   );  

                          //FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
                          
                          // then((user) {
                          //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> TwitterDashboard()));
                          // } );
                       break;
                       case TwitterLoginStatus.cancelledByUser:
                       print("Twitter Cancelled by user");
                       break;
                       
                       case TwitterLoginStatus.error:
                       print("Twitter Error Ocurred");
                       break;
                       
                       default: 
                       print("Default Ocurred");
                       
                      }
                    }).catchError((e){
                      print(e);
                    });
                  
                    },
                        child: Container(
                          width: _app.appWidth(85),
                          height: 45,
                          child: const Center(
                            child: const Text("Twitter Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: const [
                                Color(0xff205072),
                                Color(0xff2E8C92)
                              ]),
                              borderRadius: BorderRadius.circular(buttonRadius)),
                        )),
                  
                  ],
        ),
      ),
    );
  }
}