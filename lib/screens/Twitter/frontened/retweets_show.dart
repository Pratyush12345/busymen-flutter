import 'package:Busyman/screens/Twitter/backend/utils/appconstant.dart';
import 'package:Busyman/screens/Twitter/backend/utils/global_variable.dart';
import 'package:dart_twitter_api/api/tweets/data/tweet.dart';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RetweetShow extends StatefulWidget {
  const RetweetShow({ Key? key }) : super(key: key);

  @override
  _RetweetShowState createState() => _RetweetShowState();
}


class _RetweetShowState extends State<RetweetShow> {
  
bool _showCircularIndicator = true;  
TwitterApi? twitterApi;  
List<Tweet>? _listOfRecentTweets;
Map<int, String> _intToStr= {
   1: "JAN",
   2: "FEB",
   3: "MAR",
   4: "APR",
   5: "MAY",
   6: "JUN",
   7: "JUL",
   8: "AUG",
   9: "SEP",
   10: "OCT",
   11: "NOV",
   12: "DEC"
  };
  
  String datetostr(String datetime){
    
    DateTime date = DateTime.parse(datetime);
    String day = date.day <=9 ? "0${date.day.toString()}": "${date.day.toString()}";
    String expdate =  day + " "+ _intToStr[date.month]! + " "+ date.year.toString();
    return expdate;            
  }
getRetweetsTimeline() async{
    _listOfRecentTweets = [];
    try{
    twitterApi = TwitterApi(

    client: TwitterClient(
      consumerKey: "n58AlgPKH47GIWrmR3eH4vE8z",
      consumerSecret: "vomHhRkABsllgCPRuuqYw6DB5l3pjkBmTRIlAhpE09Mp7ktOSt",
      token: GlobalVariable.accessToken,
      secret: GlobalVariable.accessTokenSecret,
    ),
    );  
    _listOfRecentTweets = await twitterApi!.timelineService.userTimeline(
      userId: GlobalVariable.twittedUid
    );
    print("-------------------");
    print(_listOfRecentTweets!.length); 
    _listOfRecentTweets?.forEach((element) { 
    print(element.fullText);
    });
    print("-------------------");
    _showCircularIndicator = false;
    setState(() {});
    }
    catch(e){
      print(e);
    }
}
 String datetoTime(String datetime){
    DateTime date = DateTime.parse(datetime);
    return DateFormat('jms').format(date);            
  }

  @override
    void initState() {
      _listOfRecentTweets = [];
      getRetweetsTimeline();
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'My Tweets/Retweets',
          style: TextStyle(color: Color(0xff297687)),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff297687),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
      ),
      body: Container(
        child: _showCircularIndicator? AppConstant.circulerProgressIndicator() : ListView.builder(
          padding: EdgeInsets.all(12.0),
          itemCount: _listOfRecentTweets!.length,
          itemBuilder: (context, index){
          return Column(
            children: [
              SizedBox(height: 15.0,),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xffF3F3F3),
                  borderRadius: BorderRadius.circular(15.0)
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("${_listOfRecentTweets![index].fullText!.replaceAll("RT","Retweet")}",
                      style: TextStyle(fontSize: 15.0),),
                    ),
                    SizedBox(height: 12.0),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text("${datetostr(_listOfRecentTweets![index].createdAt.toString())} ${datetoTime(_listOfRecentTweets![index].createdAt.toString())}",
                      style: TextStyle(fontSize: 13.0),),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}