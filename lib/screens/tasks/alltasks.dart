// import 'package:busyman/models/task.dart';
// import 'package:busyman/provider/taskprovider.dart';
// import 'package:busyman/screens/tasks/alltaskstopwidget.dart';
// import 'package:busyman/screens/tasks/taskfilters.dart';
// import 'package:busyman/screens/tasks/taskwidget.dart';
// import 'package:busyman/services/sizeconfig.dart';
// import 'package:expandable/expandable.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class AllTasks extends StatefulWidget {
//   const AllTasks({Key? key}) : super(key: key);

//   @override
//   _AllTasksState createState() => _AllTasksState();
// }

// class _AllTasksState extends State<AllTasks> {
//   late App _app;
//   List<bool> tasks = [false];
//   bool initial = true;
//   bool isLoading = false;

//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     if (initial) {
//       setState(() {
//         isLoading = true;
//       });
//       Future.delayed(Duration.zero).whenComplete(() async =>
//           await Provider.of<TaskProvider>(context, listen: false)
//               .fetchTasks()
//               .whenComplete(() => setState(() {
//                     isLoading = false;
//                   })));
//     }
//     initial = false;
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final taskProvider = Provider.of<TaskProvider>(context);
//     final ongoingtasks = taskProvider.ongoingtasks;
//     final upcomingtasks = taskProvider.upcomingtasks;
//     final pendingtasks = taskProvider.pendingtasks;
//     final completedtasks = taskProvider.completedtasks;
//     _app = App(context);
//     return Scaffold(
//       body: Column(
//         children: [
//           TopView(),
//           SizedBox(
//             height: _app.appVerticalPadding(5.5),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10.0),
//             child: Filters(
//               callback: (val) {},
//             ),
//           ),
//           SizedBox(
//             height: _app.appVerticalPadding(3.5),
//           ),
//           Expanded(
//               child: isLoading
//                   ? const Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   : SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 20.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: const [
//                                     Text(
//                                       'Ongoing',
//                                       style: TextStyle(
//                                           color: Color(0xff297687),
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w400),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 ongoingtasks.isEmpty
//                                     ? const Center(
//                                         child: const Text('No Data Found'))
//                                     : TaskWidget(
//                                         tasks: ongoingtasks.length > 3
//                                             ? ongoingtasks.sublist(0, 3)
//                                             : ongoingtasks,
//                                       ),
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pushNamed(
//                                         '/SectionTask',
//                                         arguments: [Status.Ongoing, "Ongoing"]);
//                                   },
//                                   child: const Text(
//                                     'show all',
//                                     style: TextStyle(
//                                         color: Color(0xff858585),
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w400),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: _app.appVerticalPadding(2.5),
//                           ),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 20.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: const [
//                                     Text(
//                                       'Pending',
//                                       style: TextStyle(
//                                           color: Color(0xff297687),
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w400),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 pendingtasks.isEmpty
//                                     ? const Center(
//                                         child: const Text('No Data Found'))
//                                     : TaskWidget(
//                                         tasks: pendingtasks.length > 3
//                                             ? pendingtasks.sublist(0, 3)
//                                             : pendingtasks,
//                                       ),
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pushNamed(
//                                         '/SectionTask',
//                                         arguments: [Status.Pending, "Pending"]);
//                                   },
//                                   child: const Text(
//                                     'show all',
//                                     style: TextStyle(
//                                         color: Color(0xff858585),
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w400),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: _app.appVerticalPadding(2.5),
//                           ),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 20.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: const [
//                                     Text(
//                                       'Upcoming',
//                                       style: TextStyle(
//                                           color: Color(0xff297687),
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w400),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 upcomingtasks.isEmpty
//                                     ? const Center(
//                                         child: const Text('No Data Found'))
//                                     : TaskWidget(
//                                         tasks: upcomingtasks.length > 3
//                                             ? upcomingtasks.sublist(0, 3)
//                                             : upcomingtasks,
//                                       ),
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context)
//                                         .pushNamed('/SectionTask', arguments: [
//                                       Status.Upcoming,
//                                       "Upcoming"
//                                     ]);
//                                   },
//                                   child: const Text(
//                                     'show all',
//                                     style: TextStyle(
//                                         color: Color(0xff858585),
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w400),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: _app.appVerticalPadding(2.5),
//                           ),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 20.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: const [
//                                     Text(
//                                       'Completed',
//                                       style: TextStyle(
//                                           color: Color(0xff297687),
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w400),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 completedtasks.isEmpty
//                                     ? const Center(
//                                         child: const Text('No Data Found'))
//                                     : TaskWidget(
//                                         tasks: completedtasks.length > 3
//                                             ? completedtasks.sublist(0, 3)
//                                             : completedtasks,
//                                       ),
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context)
//                                         .pushNamed('/SectionTask', arguments: [
//                                       Status.Completed,
//                                       "Completed"
//                                     ]);
//                                   },
//                                   child: const Text(
//                                     'show all',
//                                     style: TextStyle(
//                                         color: Color(0xff858585),
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w400),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: _app.appVerticalPadding(2.5),
//                           ),
//                         ],
//                       ),
//                     )),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(context).pushNamed('/AddTask');
//         },
//         child: const Icon(Icons.add),
//         backgroundColor: const Color(0xff205072),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: (val) {},
//         currentIndex: 1,
//         showSelectedLabels: false,
//         iconSize: 22,
//         landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
//         type: BottomNavigationBarType.fixed,
//         items: [
//           const BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.checklist_sharp,
//                 color: Color(0xffB7B7B7),
//                 size: 22,
//               ),
//               label: ''),
//           const BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.calendar_today,
//                 color: Color(0xffB7B7B7),
//                 size: 22,
//               ),
//               label: ''),
//           BottomNavigationBarItem(
//               icon: Image.asset('assets/icons/twitter.png'), label: ''),
//           const BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.person,
//                 color: Color(0xffB7B7B7),
//                 size: 22,
//               ),
//               label: ''),
//         ],
//       ),
//     );
//   }
// }
