// import 'package:busyman/models/task.dart';
// import 'package:busyman/provider/taskprovider.dart';
// import 'package:busyman/screens/tasks/editTaskScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:provider/provider.dart';

// class TaskWidget extends StatefulWidget {
//   List<Task>? tasks;
//   TaskWidget({this.tasks});
//   @override
//   State<TaskWidget> createState() => _TaskWidgetState();
// }

// class _TaskWidgetState extends State<TaskWidget> {
//   bool? value = false;
//   @override
//   Widget build(BuildContext context) {
//     final taskprovider = Provider.of<TaskProvider>(context, listen: false);
//     return Column(
//         children: widget.tasks!.map((e) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           e.status == Status.Upcoming || e.status == Status.Completed
//               ? Slidable(
//                   actionPane: const SlidableDrawerActionPane(),
//                   secondaryActions: [
//                     IconSlideAction(
//                       icon: Icons.edit,
//                       onTap: () => Navigator.of(context)
//                           .pushNamed('/EditTask', arguments: e.id),
//                     ),
//                     IconSlideAction(
//                       icon: Icons.delete,
//                       onTap: () {
//                         showDialog(
//                             context: context,
//                             builder: (ctx) {
//                               return AlertDialog(
//                                 title: const Text(
//                                   'Are you sure you want to delete this?',
//                                   style: TextStyle(
//                                       color: Color(0xff2E2E2E),
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w400),
//                                 ),
//                                 actions: [
//                                   ElevatedButton(
//                                       onPressed: () {
//                                         taskprovider.deleteTask(e.id);
//                                         Navigator.of(context).pop();
//                                       },
//                                       child: Text('Yes')),
//                                   ElevatedButton(
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                       child: Text('No'))
//                                 ],
//                               );
//                             });
//                       },
//                     ),
//                   ],
//                   child: ListTile(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15)),
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 15),
//                     tileColor: const Color(0xffF3F3F3),
//                     dense: true,
//                     title: Text(
//                       e.taskName,
//                       overflow: TextOverflow.ellipsis,
//                       softWrap: false,
//                       style: const TextStyle(
//                           color: const Color(0xff297687),
//                           fontWeight: FontWeight.w500,
//                           fontSize: 16),
//                     ),
//                     subtitle: Row(
//                       children: [
//                         const Icon(
//                           Icons.watch_later_outlined,
//                           size: 12,
//                         ),
//                         const SizedBox(
//                           width: 3,
//                         ),
//                         FittedBox(
//                             child: Text(
//                           e.endDate + " " + e.endTime,
//                           softWrap: true,
//                           style: const TextStyle(
//                               fontSize: 10,
//                               color: Color(0xff959595),
//                               fontWeight: FontWeight.w400),
//                           overflow: TextOverflow.ellipsis,
//                         )),
//                         const Icon(
//                           Icons.person_outline_outlined,
//                           size: 12,
//                         ),
//                         const SizedBox(
//                           width: 3,
//                         ),
//                         SizedBox(
//                           width: 72,
//                           child: Text(
//                             e.workingFor[0],
//                             overflow: TextOverflow.fade,
//                             softWrap: false,
//                             style: const TextStyle(
//                                 fontSize: 12,
//                                 color: Color(0xff959595),
//                                 fontWeight: FontWeight.w400),
//                           ),
//                         ),
//                       ],
//                     ),
//                     trailing: Container(
//                       width: 4,
//                       height: 40,
//                       decoration: BoxDecoration(
//                           color: Colors.blue,
//                           borderRadius: BorderRadius.circular(10)),
//                     ),
//                   ),
//                 )
//               : Slidable(
//                   actionPane: const SlidableDrawerActionPane(),
//                   secondaryActions: [
//                     IconSlideAction(
//                       icon: Icons.edit,
//                       onTap: () => Navigator.of(context).push(
//                           MaterialPageRoute(builder: (_) => EditTask(e.id))),
//                     ),
//                     IconSlideAction(
//                       icon: Icons.delete,
//                       onTap: () {
//                         showDialog(
//                             context: context,
//                             builder: (ctx) {
//                               return AlertDialog(
//                                 title: const Text(
//                                   'Are you sure you want to delete this?',
//                                   style: TextStyle(
//                                       color: Color(0xff2E2E2E),
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w400),
//                                 ),
//                                 actions: [
//                                   ElevatedButton(
//                                       onPressed: () async {
//                                         await taskprovider.deleteTask(e.id);
//                                         Navigator.of(context).pop();
//                                       },
//                                       child: Text('Yes')),
//                                   ElevatedButton(
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                       child: Text('No'))
//                                 ],
//                               );
//                             });
//                       },
//                     ),
//                   ],
//                   child: CheckboxListTile(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15)),
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 5),
//                     controlAffinity: ListTileControlAffinity.leading,
//                     value: e.completed,
//                     onChanged: (val) async {
//                       e.completed = val!;
//                       await taskprovider.updateTask(e);
//                       setState(() {});
//                     },
//                     tileColor: const Color(0xffF3F3F3),
//                     dense: true,
//                     title: Text(
//                       e.taskName,
//                       overflow: TextOverflow.ellipsis,
//                       softWrap: false,
//                       style: const TextStyle(
//                           color: const Color(0xff297687),
//                           fontWeight: FontWeight.w500,
//                           fontSize: 16),
//                     ),
//                     subtitle: Row(
//                       children: [
//                         const Icon(
//                           Icons.watch_later_outlined,
//                           size: 12,
//                         ),
//                         const SizedBox(
//                           width: 3,
//                         ),
//                         FittedBox(
//                             child: Text(
//                           e.endDate + " " + e.endTime,
//                           softWrap: true,
//                           style: const TextStyle(
//                               fontSize: 10,
//                               color: Color(0xff959595),
//                               fontWeight: FontWeight.w400),
//                           overflow: TextOverflow.ellipsis,
//                         )),
//                         const Icon(
//                           Icons.person_outline_outlined,
//                           size: 12,
//                         ),
//                         const SizedBox(
//                           width: 3,
//                         ),
//                         SizedBox(
//                           width: 72,
//                           child: Text(
//                             e.workingFor[0],
//                             overflow: TextOverflow.fade,
//                             softWrap: false,
//                             style: const TextStyle(
//                                 fontSize: 12,
//                                 color: Color(0xff959595),
//                                 fontWeight: FontWeight.w400),
//                           ),
//                         ),
//                       ],
//                     ),
//                     secondary: Container(
//                       width: 4,
//                       height: 40,
//                       decoration: BoxDecoration(
//                           color: Colors.blue,
//                           borderRadius: BorderRadius.circular(10)),
//                     ),
//                   ),
//                 ),
//           const SizedBox(
//             height: 12,
//           ),
//         ],
//       );
//     }).toList());
//   }
// }
