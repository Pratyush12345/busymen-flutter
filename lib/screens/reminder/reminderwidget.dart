import 'package:Busyman/provider/reminderprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ReminderWidget extends StatelessWidget {
  String? id;
  int? notifcationId;
  DateTime? date;
  ReminderWidget({this.id, this.date, required this.notifcationId});

  @override
  Widget build(BuildContext context) {
    final reminderProvider =
        Provider.of<Reminderprovider>(context, listen: false);
    final reminder = reminderProvider.findReminder(id!);
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
            icon: Icons.edit,
            onTap: () {
              //editing logic
              Navigator.of(context)
                  .pushNamed('/EditReminder', arguments: reminder.id);
            }),
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
                          onPressed: () async {
                            await reminderProvider.deleteReminder(id!, notifcationId! );
                            reminderProvider.fetchDateVise(date!);

                            Navigator.of(context).pop();
                          },
                          child: const Text('Yes')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No'))
                    ],
                  );
                });
          },
        ),
      ],
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        tileColor: const Color(0xffF3F3F3),
        dense: true,
        title: Text(
          reminder.reminderName,
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
            Text(
              reminder.time,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: Container(
          height: 30,
          width: 60,
          child: Center(
              child: Text(
            reminder.category,
            style:
                const TextStyle(color: const Color(0xff858585), fontSize: 10),
          )),
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff297687)),
              borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
