import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({ Key? key }) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
    
  List listMessage = [];
  bool fetchedonce = false;
  bool noMore = false;
  ScrollController listScrollController = ScrollController();
  Map<dynamic, dynamic>? lastVisible;

     void _scrollListener() async {
      print("scroll listener"); 
    if ( listScrollController.offset >= listScrollController.position.maxScrollExtent &&
      !listScrollController.position.outOfRange) {
      _fetchMore();
    }
  }
  _fetchMore() {

    print("fetch more called");
    FirebaseDatabase.instance
        .reference()
        .child("Users/f2hp0nwcPzeDiqMKENPgFQ4pavW2/Tasks")
        .orderByChild('currentDateTime')
        .startAt(lastVisible!['currentDateTime'])
        .limitToFirst(3)
        .once()
        .then((snapshot) {

      List snapList = Map.from(snapshot.value).values.toList()
        ..sort((a, b) => a['currentDateTime'].compareTo(b['currentDateTime']));


      if (snapList.isNotEmpty) {
        print(snapList.length.toString());

        if (!noMore) {

          listMessage.removeLast();

          //Problem is here.....??
          setState(() {
            listMessage..addAll(snapList);
          });

          lastVisible = snapList.last;

          print(lastVisible!['taskName']);
        }

        // if (snapList.length < 5) {
        //   noMore = true;
        // }
      }
    });
  }
  
  

   Widget buildListMessage() {
    return StreamBuilder(
      stream: FirebaseDatabase.instance
          .reference()
          .child("Users/f2hp0nwcPzeDiqMKENPgFQ4pavW2/Tasks")
          .orderByChild('currentDateTime')
          .limitToFirst(3)
          .onValue,
      builder: (context, AsyncSnapshot<Event> snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)));
        } else {
          if(!fetchedonce){
          if (snapshot.data!.snapshot.value != null) {

              listMessage = Map.from(snapshot.data!.snapshot.value)
                  .values
                  .toList()
                  ..sort((a, b) => a['currentDateTime'].compareTo(b['currentDateTime']));

            if (lastVisible == null) {
              lastVisible = listMessage.last;
              listMessage.removeLast();
            }
          }
          fetchedonce = true;
          }

          return ListView.builder(
            controller: listScrollController,
            itemCount:listMessage.length ,
            itemBuilder: (context, index){
              return Column(
                children: [
                  SizedBox(height: 20.0,),
                  Container(
                    color: Colors.pink,
                    height:MediaQuery.of(context).size.height*0.4 ,
                    child: ListTile(
                      title: Text("${listMessage[index]["taskName"]}"),
                      subtitle: Text("${listMessage[index]["currentDateTime"]}"),
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
  
  @override
    void initState() {
      listMessage = [];
      listScrollController.addListener(_scrollListener);
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pagination test"),),
      body: Column(
        children: [
          Container(
            color: Colors.orange,
            height: MediaQuery.of(context).size.height*0.8,
            width: MediaQuery.of(context).size.width,
            child: buildListMessage()
          ),
        ],
      ),
    );
  }
}