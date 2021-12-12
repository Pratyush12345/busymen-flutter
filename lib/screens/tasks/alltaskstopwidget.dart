import 'package:Busyman/provider/taskprovider.dart';
import 'package:Busyman/services/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TopView extends StatelessWidget {
  late App _app;
  final String headername;
  TopView({required this.headername});
  final _searchController = TextEditingController();

  DateTime? currentDay = DateTime.now();
  DateFormat formatter = DateFormat('dd MMM, yyyy');
  
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
                    Text.rich(
                      TextSpan(
                        text: '${headername}',
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: _app.appWidth(50),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(formatter.format(currentDay!),
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700)),
                            SizedBox(width: 30.0,)
                            ]),
                    )
                  ],
                ),
              ),
            ),
          ),
          if(!headername.contains("Retweets")) 
          Positioned(
            top: _app.appVerticalPadding(16),
            left: 0.0,
            right: 0.0,
            child: Container(
              height: _app.appHeight(5.0),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(width: 1.0, color: Color(0xff329D9C)),
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    // boxShadow: const [
                    //   BoxShadow(
                    //       offset: Offset(1.0, 4.0),
                    //       blurRadius: 0,
                    //       spreadRadius: 0.0,
                    //       color: Colors.grey,
                    //       //blurStyle: BlurStyle.normal
                    //       ),
                    // ]
                    ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        
                        textAlign: TextAlign.center,
                        showCursor: true,
                        onTap: (){
                        },
                        onChanged: (val) {
                          print(val);
                           Provider.of<TaskProvider>(context, listen: false).onSearch(val);
                        }, 
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(4.0),
                            hintText: "Search",
                            suffixIcon: Icon(
                              Icons.search,
                              color: Color(0xff297687),
                            ),

                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xff329D9C)))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
