import 'package:Busyman/provider/reminderprovider.dart';
import 'package:Busyman/services/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ReminderWidget extends StatelessWidget {
  String? id;
  int? notifcationId;
  DateTime? date;
  ReminderWidget({this.id, this.date, required this.notifcationId});
  
  Map<String, Color> _filtercolour = {
    "Events" :const Color(0xff81B4FE),
    "Invitation": const Color(0xff5CC581),
    "Personal": const Color(0xffFF866B),
    "Birthday":  Colors.orange,
  };
  @override
  Widget build(BuildContext context) {
    final reminderProvider =
        Provider.of<Reminderprovider>(context, listen: false);
    final reminder = reminderProvider.findReminder(id!);
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
            iconWidget: Icon(
            Icons.edit,
            color: blueColour,
            ),
        
            onTap: () {
              //editing logic
              Navigator.of(context)
                  .pushNamed('/EditReminder', arguments: reminder.id);
            }),
        IconSlideAction(
          iconWidget: Icon(
          Icons.delete,
          color: blueColour,
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(cornerRadiusTaskWidget)),
                    
                    title: const Text(
                      'Are you sure you want to delete this?',
                      style: TextStyle(
                          color: Color(0xff2E2E2E),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    actions: [
                      MaterialButton(
                          height: 45.0,
                          minWidth: 100.0,
                          elevation: 0.0,
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('NO', style: TextStyle(color: blueColour),)),
                        MaterialButton(
                          height: 45.0,
                          minWidth: 100.0, 
                          elevation: 0.0,
                          
                          color: blueColour,
                          onPressed: () async {
                            await reminderProvider.deleteReminder(id!, notifcationId! );
                            reminderProvider.fetchDateVise(date!);

                            Navigator.of(context).pop();
                          
                            },
                          child: Text('YES', style: TextStyle(color: Colors.white) )),
                        
                    
                    ],
                  );
                });
          },
        ),
      ],
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadiusTaskWidget),
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(cornerRadiusTaskWidget)),
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
                size: 13,
                color: Color(0xff959595)
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                reminder.time,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400,
                color: Color(0xff959595)),
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
                   TextStyle(color: _filtercolour[reminder.category], fontSize: 11),
            )),
            decoration: BoxDecoration(
                border: Border.all(color:  _filtercolour[reminder.category]!),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
