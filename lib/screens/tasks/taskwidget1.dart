import 'package:Busyman/models/task.dart';
import 'package:Busyman/provider/taskprovider.dart';
import 'package:Busyman/services/appColor.dart';
import 'package:Busyman/services/date_to_str.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
  Map<String, Color> _filtercolour = {
    "Political" :const Color(0xff81B4FE),
    "Ward": const Color(0xffd1b3ff),
    "Work": const Color(0xffFEB765),
    "Business":const Color(0xff5CC581),
    "Extra" : const Color(0xffFF866B)
  };

  void showIsDoneDialog(String msg, bool _isDone){
     showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(cornerRadiusTaskWidget)),
                    
                    title: Text(
                      '${msg}',
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
                          onPressed: () async{
                           widget.task?.isDone = _isDone;
                           setState(() {});
                           FirebaseDatabase.instance.reference().child("Users/${FirebaseAuth.instance.currentUser!.uid}/Tasks/${widget.task?.id}").update({"isDone": _isDone});
                           Navigator.of(context).pop();   
                          },
                          child: Text('YES', style: TextStyle(color: Colors.white) )),
                        
                  
                    ],
                  );
                });
  }

  @override
  Widget build(BuildContext context) {
    final taskprovider = Provider.of<TaskProvider>(context, listen: false);
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
          iconWidget: Icon(
          Icons.edit,
          color: blueColour,
          ),
        
          onTap: () => Navigator.of(context)
              .pushNamed('/EditTask', arguments: widget.task!.id),
        ),
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
                          onPressed: () {
                            taskprovider.deleteTask(widget.task!.id, context);
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
          
          onTap: (){
            Navigator.of(context).pushNamed('/TaskDetail', arguments: widget.task!.id);
          },
          
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadiusTaskWidget)),
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
          subtitle: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.watch_later_outlined,
                  size: 13,
                  color: Color(0xff959595)
                ),
                const SizedBox(
                  width: 3,
                ),
                FittedBox(
                    child: Text(
                  DateToStr.instance.datetostr(widget.task!.currentDateTime),
                  softWrap: true,
                  style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xff959595),
                      fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                )),
                const SizedBox(
                  width: 11,
                ),
                const Icon(
                  Icons.person_outline_outlined,
                  size: 13,
                  color: Color(0xff959595),
                  
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
                        fontSize: 13,
                        color: Color(0xff959595),
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          trailing: Container(
            width: 60,
            height: 40,
                  
            child: Row(
              children: [
                AnimatedSwitcher(duration: Duration(milliseconds: 500),
                switchInCurve: Curves.fastLinearToSlowEaseIn,
                switchOutCurve: Curves.easeInCubic,
                child:  !widget.task!.isDone ? InkWell(
                  key: UniqueKey(),
                  onTap: (){
                    showIsDoneDialog("Mark this task as done.", true );
                    
                  },
                  child: Icon(Icons.check_box_outline_blank_rounded)) 
                  : InkWell(
                    key: UniqueKey(),
                    onTap: (){
                     showIsDoneDialog("Mark this task as undone.", false );
                    },
                    child: Icon(Icons.check_circle_outline_outlined, color: Colors.green, )),
                ),
                
                SizedBox(width: 20.0,),
                
                Container(
                  width: 4,
                  height: 40,
                  decoration: BoxDecoration(
                      color: _filtercolour[widget.task!.category], borderRadius: BorderRadius.circular(10)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
