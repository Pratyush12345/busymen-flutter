import 'package:busyman/services/sizeconfig.dart';
import 'package:flutter/material.dart';

class TopView extends StatelessWidget {
  late App _app;
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
                    const Text.rich(
                      TextSpan(
                        text: 'Work Log',
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
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                icon: Image.asset(
                                  'assets/icons/downarrow.png',
                                  height: 15,
                                  width: 15,
                                  color: Colors.white,
                                ),
                                items: const [
                                  DropdownMenuItem(
                                      child: Text('22 Oct 2021',
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700)))
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/Reminders');
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
          Positioned(
            top: _app.appVerticalPadding(16),
            left: 0.0,
            right: 0.0,
            child: Container(
              height: _app.appHeight(6),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(width: 1.0),
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(1.0, 4.0),
                          blurRadius: 4.0,
                          spreadRadius: -1.0,
                          color: Colors.grey,
                          //blurStyle: BlurStyle.normal
                          ),
                    ]),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        textAlign: TextAlign.center,
                        showCursor: false,
                        onChanged: (val) {}, 
                        decoration: const InputDecoration(
                            hintText: "Search",
                            suffixIcon: Icon(
                              Icons.search,
                              color: Color(0xff297687),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xff297687)))),
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
