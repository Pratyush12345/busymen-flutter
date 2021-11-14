import 'package:busyman/models/reminder.dart';
import 'package:busyman/provider/reminderprovider.dart';
import 'package:busyman/screens/tasks/taskfilters.dart';
import 'package:busyman/services/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditReminder extends StatefulWidget {
  final String id;
  EditReminder(this.id);

  @override
  _EditReminderState createState() => _EditReminderState();
}

class _EditReminderState extends State<EditReminder> {
  late App _app;
  final _reminderformkey = GlobalKey<FormState>();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _datecontroller = TextEditingController();
  TextEditingController _timecontroller = TextEditingController();
  late String category;
  List<bool> categorySelected = [false, false, false, false];
  bool initial = true;
  bool isLoading = false;
  DateFormat formatter = DateFormat('dd MMM, yyyy');
  @override
  void dispose() {
    // TODO: implement dispose
    _namecontroller.dispose();
    _datecontroller.dispose();
    _timecontroller.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (initial) {
      final reminder = Provider.of<Reminderprovider>(context, listen: false)
          .findReminder(widget.id);
      _namecontroller.text = reminder.reminderName;
      _datecontroller.text = reminder.date;
      _timecontroller.text = reminder.time;
      category = reminder.category;
    }
    initial = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final reminderProvider =
        Provider.of<Reminderprovider>(context, listen: false);
    _app = App(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Set New Reminder',
          style: TextStyle(color: Color(0xff297687)),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff297687),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
            key: _reminderformkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _namecontroller,
                    keyboardType: TextInputType.name,
                    validator: (str) {
                      if (str == null || str.isEmpty) {
                        return 'This field can not be empty';
                      }
                    },
                    decoration: const InputDecoration(
                        labelText: 'Reminder name'),
                  ),
                  SizedBox(
                    height: _app.appVerticalPadding(2.0),
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: _datecontroller,
                    validator: (str) {
                      if (str == null || str.isEmpty) {
                        return 'This field can not be empty';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Date',
                        suffixIcon: IconButton(
                            onPressed: () async {
                              String text;
                              DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2050));
                              if (selectedDate != null) {
                                text = formatter.format(selectedDate);
                                _datecontroller.text = text;
                              }
                            },
                            icon: const Icon(Icons.date_range))),
                  ),
                  SizedBox(
                    height: _app.appVerticalPadding(2.0),
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: _timecontroller,
                    decoration: InputDecoration(
                      labelText: 'Time',
                      suffixIcon: IconButton(
                          onPressed: () async {
                            String text;
                            TimeOfDay? time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                builder: (context, childWidget) {
                                  return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          alwaysUse24HourFormat: false),
                                      child: childWidget!);
                                });

                            if (time != null) {
                              print(time.format(context));
                              if (time.hour > 12) {
                                _timecontroller.text =
                                    (time.hour - 12).toString() +
                                        ' : ' +
                                        time.minute.toString() +
                                        ' ' +
                                        'pm';
                              } else {
                                _timecontroller.text =
                                    (time.hour.toString().length == 1
                                            ? ('0' + time.hour.toString())
                                            : time.hour.toString()) +
                                        ' : ' +
                                        time.minute.toString() +
                                        ' ' +
                                        'am';
                              }
                            }
                          },
                          icon: const Icon(Icons.watch_later)),
                    ),
                    validator: (str) {
                      if (str == null || str.isEmpty) {
                        return 'This field can not be empty';
                      }
                    },
                  ),
                  SizedBox(
                    height: _app.appVerticalPadding(2.5),
                  ),
                  const Text(
                    'Select Category',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff959595)),
                  ),
                  SizedBox(
                    height: _app.appVerticalPadding(1.5),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        category = 'Events';
                        categorySelected[0] = !categorySelected[0];
                        categorySelected[1] = false;
                        categorySelected[2] = false;
                        categorySelected[3] = false;
                      });
                    },
                    child: Stack(
                      children: [
                        categorySelected[0]
                            ? Container(
                                height: _app.appHeight(4),
                                width: _app.appWidth(20),
                                decoration: BoxDecoration(
                                    color: const Color(0xff297687),
                                    border: Border.all(
                                        color: const Color(0xff297687)),
                                    borderRadius: BorderRadius.circular(12)),
                              )
                            : const SizedBox(),
                        Container(
                          height: _app.appHeight(4),
                          width: _app.appWidth(20),
                          child: Center(
                              child: Text(
                            'Events',
                            style: TextStyle(
                                color: categorySelected[0]
                                    ? Colors.white
                                    : const Color(0xff297687)),
                          )),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xff297687)),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: _app.appVerticalPadding(1.5),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        category = 'Invitaion';
                        categorySelected[0] = false;
                        categorySelected[1] = !categorySelected[1];
                        categorySelected[2] = false;
                        categorySelected[3] = false;
                      });
                    },
                    child: Stack(
                      children: [
                        categorySelected[1]
                            ? Container(
                                height: _app.appHeight(4),
                                width: _app.appWidth(20),
                                decoration: BoxDecoration(
                                    color: const Color(0xff297687),
                                    border: Border.all(
                                        color: const Color(0xff297687)),
                                    borderRadius: BorderRadius.circular(12)),
                              )
                            : const SizedBox(),
                        Container(
                          height: _app.appHeight(4),
                          width: _app.appWidth(20),
                          child: Center(
                              child: Text(
                            'Invitation',
                            style: TextStyle(
                                color: categorySelected[1]
                                    ? Colors.white
                                    : const Color(0xff297687)),
                          )),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xff297687)),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: _app.appVerticalPadding(1.5),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        category = 'Personal';
                        categorySelected[0] = false;
                        categorySelected[1] = false;
                        categorySelected[2] = !categorySelected[2];
                        categorySelected[3] = false;
                      });
                    },
                    child: Stack(
                      children: [
                        categorySelected[2]
                            ? Container(
                                height: _app.appHeight(4),
                                width: _app.appWidth(20),
                                decoration: BoxDecoration(
                                    color: const Color(0xff297687),
                                    border: Border.all(
                                        color: const Color(0xff297687)),
                                    borderRadius: BorderRadius.circular(12)),
                              )
                            : const SizedBox(),
                        Container(
                          height: _app.appHeight(4),
                          width: _app.appWidth(20),
                          child: Center(
                              child: Text(
                            'Personal',
                            style: TextStyle(
                                color: categorySelected[2]
                                    ? Colors.white
                                    : const Color(0xff297687)),
                          )),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xff297687)),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: _app.appVerticalPadding(1.5),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        category = 'Birthday';
                        categorySelected[0] = false;
                        categorySelected[1] = false;
                        categorySelected[2] = false;
                        categorySelected[3] = !categorySelected[3];
                      });
                    },
                    child: Stack(
                      children: [
                        categorySelected[3]
                            ? Container(
                                height: _app.appHeight(4),
                                width: _app.appWidth(20),
                                decoration: BoxDecoration(
                                    color: const Color(0xff297687),
                                    border: Border.all(
                                        color: const Color(0xff297687)),
                                    borderRadius: BorderRadius.circular(12)),
                              )
                            : const SizedBox(),
                        Container(
                          height: _app.appHeight(4),
                          width: _app.appWidth(20),
                          child: Center(
                              child: Text(
                            'Birthday',
                            style: TextStyle(
                                color: categorySelected[3]
                                    ? Colors.white
                                    : const Color(0xff297687)),
                          )),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xff297687)),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: _app.appVerticalPadding(25),
                  ),
                  isLoading
                      ? const Center(child: const CircularProgressIndicator())
                      : TextButton(
                          onPressed: () {
                            if (_reminderformkey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              Reminder reminder = Reminder(
                                id: widget.id,
                                reminderName: _namecontroller.text,
                                date: _datecontroller.text,
                                time: _timecontroller.text,
                                category: category,
                              );
                              reminderProvider
                                  .editReminder(reminder)
                                  .whenComplete(() {
                                setState(() {
                                  isLoading = false;
                                });
                              });

                              Navigator.of(context).pop();
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 40,
                            child: const Center(
                              child: const Text("Done",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: const [
                                  Color(0xff205072),
                                  Color(0xff2E8C92)
                                ]),
                                borderRadius: BorderRadius.circular(15)),
                          ))
                ],
              ),
            )),
      ),
    );
  }
}
