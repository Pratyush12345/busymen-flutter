import 'package:Busyman/provider/reminderprovider.dart';
import 'package:Busyman/screens/reminder/reminderwidget.dart';
import 'package:Busyman/services/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AllReminders extends StatefulWidget {
  const AllReminders({Key? key}) : super(key: key);

  @override
  _AllRemindersState createState() => _AllRemindersState();
}

class _AllRemindersState extends State<AllReminders>
    with TickerProviderStateMixin {
  late App _app;
  List<bool> tasks = [false];
  bool initial = true;
  bool isLoading = false;
  late TabController _controller;
  DateTime? currentDay = DateTime.now();
  DateFormat formatter = DateFormat('dd MMM, yyyy');
  Map<int, String?> weekdays = const {
    1: "Mon",
    2: "Tue",
    3: "Wed",
    4: "Thu",
    5: "Fri",
    6: "Sat",
    7: "Sun"
  };

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (initial) {
      setState(() {
        isLoading = true;
      });
      Future.delayed(Duration.zero).whenComplete(() async {
        await Provider.of<Reminderprovider>(context, listen: false)
            .fetchReminders()
            .whenComplete(() => setState(() {
                  Provider.of<Reminderprovider>(context, listen: false)
                      .fetchDateVise(currentDay!);
                  isLoading = false;
                }));
      });
      _controller = TabController(length: 6, vsync: this, initialIndex: 2);
    }
    initial = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final reminders = Provider.of<Reminderprovider>(context);
    print("remider updateddddd");
    print("2 ${reminders.dateViseReminders[2]!.length}");
    _app = App(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            clipBehavior: Clip.none,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: const [Color(0xff205072), Color(0xff329D9C)])),
            width: MediaQuery.of(context).size.width,
            height: _app.appHeight(18),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: _app.appVerticalPadding(3.6),
                ),
                Center(
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
                                TextButton(
                                  onPressed: () async {
                                    DateTime? selectedDate =
                                        await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2050));
                                    if (selectedDate != null) {
                                      setState(() {
                                        currentDay = selectedDate;
                                        Provider.of<Reminderprovider>(context,
                                                listen: false)
                                            .fetchDateVise(currentDay!);
                                      });
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Text(formatter.format(currentDay!),
                                          style: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700)),
                                      Image.asset(
                                        'assets/icons/downarrow.png',
                                        height: 15,
                                        width: 15,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Image(
                                      image: AssetImage(
                                          'assets/icons/reminder.png'),
                                      color: Colors.white,
                                    ))
                              ]),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBar(
                      controller: _controller,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: const Color(0xff205072),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                      tabs: [
                        Tab(
                          child: Column(
                            children: [
                              Text(
                                  currentDay!.weekday - 2 > 0
                                      ? weekdays[currentDay!.weekday - 2]!
                                      : weekdays[currentDay!.weekday - 2 + 7]!,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  )),
                              Text(
                                  currentDay!
                                      .subtract(const Duration(days: 2))
                                      .day
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ))
                            ],
                          ),
                        ),
                        Tab(
                          child: Column(
                            children: [
                              Text(
                                  currentDay!.weekday - 1 > 0
                                      ? weekdays[currentDay!.weekday - 1]!
                                      : weekdays[currentDay!.weekday - 1 + 7]!,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  )),
                              Text(
                                  currentDay!
                                      .subtract(const Duration(days: 1))
                                      .day
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ))
                            ],
                          ),
                        ),
                        Tab(
                          
                          //height: 100,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            width: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(weekdays[currentDay!.weekday]!,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff205072),
                                    )),
                                Text(currentDay!.day.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff205072),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Column(
                            children: [
                              Text(
                                  currentDay!.weekday + 1 <= 7
                                      ? weekdays[currentDay!.weekday + 1]!
                                      : weekdays[currentDay!.weekday + 1 - 7]!,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  )),
                              Text(
                                  currentDay!
                                      .add(const Duration(days: 1))
                                      .day
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ))
                            ],
                          ),
                        ),
                        Tab(
                          child: Column(
                            children: [
                              Text(
                                  currentDay!.weekday + 2 <= 7
                                      ? weekdays[currentDay!.weekday + 2]!
                                      : weekdays[currentDay!.weekday + 2 - 7]!,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  )),
                              Text(
                                  currentDay!
                                      .add(const Duration(days: 2))
                                      .day
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ))
                            ],
                          ),
                        ),
                        Tab(
                          child: Column(
                            children: [
                              Text(
                                  currentDay!.weekday + 3 <= 7
                                      ? weekdays[currentDay!.weekday + 3]!
                                      : weekdays[currentDay!.weekday + 3 - 7]!,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  )),
                              Text(
                                  currentDay!
                                      .add(const Duration(days: 3))
                                      .day
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ))
                            ],
                          ),
                        ),
                      ]),
                )
              ],
            ),
          ),
          SizedBox(
            height: _app.appVerticalPadding(3.5),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TabBarView(controller: _controller, children: [
                ListView.builder(
                    itemCount: reminders.dateViseReminders[0]!.length,
                    itemBuilder: (ctx, i) {
                      return reminders.dateViseReminders[0]!
                          .map((e) => Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ReminderWidget(
                                    id: e.id,
                                    notifcationId: e.notificationId,
                                    date: currentDay,
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ))
                          .toList()[i];
                    }),
                ListView.builder(
                    itemCount: reminders.dateViseReminders[1]!.length,
                    itemBuilder: (ctx, i) {
                      return reminders.dateViseReminders[1]!
                          .map((e) => Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ReminderWidget(id: e.id,notifcationId: e.notificationId, date: currentDay),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ))
                          .toList()[i];
                    }),
                ListView.builder(
                    itemCount: reminders.dateViseReminders[2]!.length,
                    itemBuilder: (ctx, i) {
                      return reminders.dateViseReminders[2]!
                          .map((e) => Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ReminderWidget(id: e.id,notifcationId: e.notificationId, date: currentDay),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ))
                          .toList()[i];
                    }),
                ListView.builder(
                    itemCount: reminders.dateViseReminders[3]!.length,
                    itemBuilder: (ctx, i) {
                      return reminders.dateViseReminders[3]!
                          .map((e) => Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ReminderWidget(id: e.id, notifcationId: e.notificationId, date: currentDay),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ))
                          .toList()[i];
                    }),
                ListView.builder(
                    itemCount: reminders.dateViseReminders[4]!.length,
                    itemBuilder: (ctx, i) {
                      return reminders.dateViseReminders[4]!
                          .map((e) => Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ReminderWidget(id: e.id, notifcationId: e.notificationId, date: currentDay),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ))
                          .toList()[i];
                    }),
                ListView.builder(
                    itemCount: reminders.dateViseReminders[5]!.length,
                    itemBuilder: (ctx, i) {
                      return reminders.dateViseReminders[5]!
                          .map((e) => Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ReminderWidget(id: e.id, notifcationId: e.notificationId, date: currentDay),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ))
                          .toList()[i];
                    }),
              ]),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context).pushNamed('/AddReminder');
      //   },
      //   child: const Icon(Icons.add),
      //   backgroundColor: const Color(0xff205072),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: (val) {},
      //   currentIndex: 1,
      //   showSelectedLabels: false,
      //   iconSize: 22,
      //   //landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      //   type: BottomNavigationBarType.fixed,
      //   items: [
      //     const BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.fact_check_sharp,
      //           color: Color(0xffB7B7B7),
      //           size: 22,
      //         ),
      //         label: ''),
      //     const BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.calendar_today,
      //           color: Color(0xffB7B7B7),
      //           size: 22,
      //         ),
      //         label: ''),
      //     BottomNavigationBarItem(
      //         icon: Image.asset('assets/icons/twitter.png'), label: ''),
      //     const BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.person,
      //           color: Color(0xffB7B7B7),
      //           size: 22,
      //         ),
      //         label: ''),
      //   ],
      // ),
    );
  }
}
