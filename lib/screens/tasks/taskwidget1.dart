import 'package:busyman/models/task.dart';
import 'package:busyman/provider/taskprovider.dart';
import 'package:busyman/screens/tasks/editTaskScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class TaskWidget extends StatefulWidget {
  Task? task;
  TaskWidget({this.task});
  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool? value = false;
  @override
  Widget build(BuildContext context) {
    final taskprovider = Provider.of<TaskProvider>(context, listen: false);
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
          icon: Icons.edit,
          onTap: () => Navigator.of(context)
              .pushNamed('/EditTask', arguments: widget.task!.id),
        ),
        IconSlideAction(
          icon: Icons.delete,
          onTap: () {
            showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    title: const Text(
                      'Are you sure you want to delete this?',
                      style: TextStyle(
                          color: Color(0xff2E2E2E),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            taskprovider.deleteTask(widget.task!.id);
                            Navigator.of(context).pop();
                          },
                          child: Text('Yes')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('No'))
                    ],
                  );
                });
          },
        ),
      ],
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        tileColor: const Color(0xffF3F3F3),
        dense: true,
        title: Text(
          widget.task!.taskName,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: const TextStyle(
              color: const Color(0xff297687),
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
        subtitle: Row(
          children: [
            const Icon(
              Icons.watch_later_outlined,
              size: 12,
            ),
            const SizedBox(
              width: 3,
            ),
            FittedBox(
                child: Text(
              widget.task!.currentDateTime.substring(0, 16),
              softWrap: true,
              style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xff959595),
                  fontWeight: FontWeight.w400),
              overflow: TextOverflow.ellipsis,
            )),
            const SizedBox(
              width: 3,
            ),
            const Icon(
              Icons.person_outline_outlined,
              size: 12,
            ),
            const SizedBox(
              width: 3,
            ),
            SizedBox(
              width: 72,
              child: Text(
                widget.task!.workingFor.isNotEmpty? widget.task!.workingFor[0] : "No Contact Selected",
                overflow: TextOverflow.fade,
                softWrap: false,
                style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff959595),
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        trailing: Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
