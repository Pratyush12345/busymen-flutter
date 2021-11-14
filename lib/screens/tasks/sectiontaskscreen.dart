// import 'package:busyman/models/task.dart';
// import 'package:busyman/provider/taskprovider.dart';
// import 'package:busyman/screens/tasks/alltaskstopwidget.dart';
// import 'package:busyman/screens/tasks/taskfilters.dart';
// import 'package:busyman/screens/tasks/taskwidget.dart';
// import 'package:busyman/services/sizeconfig.dart';
// import 'package:expandable/expandable.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class SectionTaskScreen extends StatefulWidget {
//   final List? list;
//   SectionTaskScreen({this.list});

//   @override
//   _SectionTaskScreenState createState() => _SectionTaskScreenState();
// }

// class _SectionTaskScreenState extends State<SectionTaskScreen> {
//   late App _app;
//   List<bool> tasks = [false];
//   @override
//   Widget build(BuildContext context) {
//     _app = App(context);
//     final list =
//         Provider.of<TaskProvider>(context).findListByStatus(widget.list![0]);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text(
//           widget.list![1],
//           style: const TextStyle(color: Color(0xff297687)),
//         ),
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Color(0xff297687),
//           ),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: _app.appVerticalPadding(3.5),
//           ),
//           Container(
//             height: _app.appHeight(6),
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: DecoratedBox(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(25.0),
//                   border: Border.all(width: 1.0),
//                   color: Colors.white,
//                   shape: BoxShape.rectangle,
//                   boxShadow: const [
//                     BoxShadow(
//                         offset: Offset(1.0, 4.0),
//                         blurRadius: 4.0,
//                         spreadRadius: -1.0,
//                         color: Colors.grey,
//                         blurStyle: BlurStyle.normal),
//                   ]),
//               child: Row(
//                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       textAlign: TextAlign.center,
//                       showCursor: false,
//                       onChanged: (val) {},
//                       decoration: const InputDecoration(
//                           hintText: "Search",
//                           suffixIcon: Icon(
//                             Icons.search,
//                             color: Color(0xff297687),
//                           ),
//                           border: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(25)),
//                               borderSide: BorderSide(
//                                   width: 1, color: Color(0xff297687)))),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             height: _app.appVerticalPadding(2.5),
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
//               child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             '${list.length} Task',
//                             style: const TextStyle(
//                                 color: Color(0xff297687),
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       TaskWidget(
//                         tasks: list,
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: _app.appVerticalPadding(2.5),
//                 ),
//               ],
//             ),
//           )),
//         ],
//       ),
//     );
//   }
// }
