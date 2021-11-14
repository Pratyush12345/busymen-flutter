import 'package:busyman/models/task.dart';
import 'package:busyman/provider/taskprovider.dart';
import 'package:busyman/screens/tasks/contacttile.dart';
import 'package:busyman/screens/tasks/taskfilters.dart';
import 'package:busyman/services/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:provider/provider.dart';

class EditTask extends StatefulWidget {
  final String id;
  EditTask(this.id);
  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late App _app;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _descriptioncontroller = TextEditingController();
  late String category = '';
  late List<String> workingFor = [];
  late List<String> allocatedTo = [];
  late List<String> reference = [];
  bool initial = true;
  bool isLoading = false;
  DateFormat formatter = DateFormat('dd MMM, yyyy');
  List<Contact>? _contacts;
  bool _permissionDenied = false;

  Future _fetchContacts() async {
    bool getPermission =
        await FlutterContacts.requestPermission(readonly: true);
    if (!getPermission) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts();
      setState(() => _contacts = contacts);
    }
  }

  Future<List<String>> showContacts(BuildContext context) async {
    Map<String, bool> contacts = {};
    List<String> contact = [];
    _contacts?.forEach((val) {
      contacts[val.displayName] = false;
    });
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        // backgroundColor: const Color(0xff297687),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                contacts.forEach((key, value) {
                  if (value) {
                    contact.add(key);
                  }
                });

                Navigator.of(ctx).pop();
                // Navigator.of(context).pop();
              },
              child: const Text('Ok'))
        ],
        content: Container(
          height: 450,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(

              // color: Colors.white,
              border: Border.all(color: const Color(0xff297687)),
              borderRadius: BorderRadius.circular(15)),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: contacts.length,
              clipBehavior: Clip.hardEdge,
              itemBuilder: (ctx, i) => contacts.keys
                  .map((e) => Column(
                        children: [
                          ContactTile(e, contacts),
                          const SizedBox(
                            height: 12,
                          )
                        ],
                      ))
                  .toList()[i]),
        ),
      ),
    );
    return contact;
  }

  @override
  void didChangeDependencies() {
    if (initial) {
      final task =
          Provider.of<TaskProvider>(context, listen: false).findTask(widget.id);
      _namecontroller.text = task.taskName;
      _descriptioncontroller.text = task.description;
      category = task.category;
      workingFor = task.workingFor;
      allocatedTo = task.allocatedTo;
      reference = task.reference;
    }
    initial = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _namecontroller.dispose();
    _descriptioncontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _app = App(context);
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Create New Task',
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
        padding: const EdgeInsets.all(12.0),
        child: Form(
            key: _formKey,
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
                    decoration:
                        const InputDecoration(labelText: 'Task name'),
                  ),
                  SizedBox(
                    height: _app.appVerticalPadding(2.0),
                  ),
                  TextFormField(
                    controller: _descriptioncontroller,
                    keyboardType: TextInputType.name,
                    decoration:
                        const InputDecoration(labelText: 'Description'),
                  ),
                  SizedBox(
                    height: _app.appVerticalPadding(2.0),
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //         child: TextFormField(
                  //       readOnly: true,
                  //       controller: _startDatecontroller,
                  //       validator: (str) {
                  //         if (str == null || str.isEmpty) {
                  //           return 'This field can not be empty';
                  //         }
                  //       },
                  //       decoration: InputDecoration(
                  //           label: const Text('Start Date'),
                  //           suffixIcon: IconButton(
                  //               onPressed: () async {
                  //                 String text;
                  //                 DateTime? selectedDate = await showDatePicker(
                  //                     context: context,
                  //                     initialDate: DateTime.now(),
                  //                     firstDate: DateTime.now(),
                  //                     lastDate: DateTime(2050));
                  //                 if (selectedDate != null) {
                  //                   text = formatter.format(selectedDate);
                  //                   _startDatecontroller.text = text;
                  //                 }
                  //               },
                  //               icon: const Icon(Icons.date_range))),
                  //     )),
                  //     const SizedBox(
                  //       width: 30,
                  //     ),
                  //     Expanded(
                  //         child: TextFormField(
                  //       readOnly: true,
                  //       controller: _startTimecontroller,
                  //       decoration: InputDecoration(
                  //         label: const Text('Start Time'),
                  //         suffixIcon: IconButton(
                  //             onPressed: () async {
                  //               String text;
                  //               TimeOfDay? time = await showTimePicker(
                  //                   context: context,
                  //                   initialTime: TimeOfDay.now(),
                  //                   builder: (context, childWidget) {
                  //                     return MediaQuery(
                  //                         data: MediaQuery.of(context).copyWith(
                  //                             alwaysUse24HourFormat: false),
                  //                         child: childWidget!);
                  //                   });

                  //               if (time != null) {
                  //                 print(time.format(context));
                  //                 if (time.hour > 12) {
                  //                   _startTimecontroller.text =
                  //                       (time.hour - 12).toString() +
                  //                           ' : ' +
                  //                           time.minute.toString() +
                  //                           ' ' +
                  //                           'pm';
                  //                 } else {
                  //                   _startTimecontroller.text =
                  //                       (time.hour.toString().length == 1
                  //                               ? ('0' + time.hour.toString())
                  //                               : time.hour.toString()) +
                  //                           ' : ' +
                  //                           time.minute.toString() +
                  //                           ' ' +
                  //                           'am';
                  //                 }
                  //               }
                  //             },
                  //             icon: const Icon(Icons.watch_later)),
                  //       ),
                  //       validator: (str) {
                  //         if (str == null || str.isEmpty) {
                  //           return 'This field can not be empty';
                  //         }
                  //       },
                  //     ))
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //         child: TextFormField(
                  //       readOnly: true,
                  //       controller: _endDatecontroller,
                  //       decoration: InputDecoration(
                  //           label: const Text('End Date'),
                  //           suffixIcon: IconButton(
                  //               onPressed: () async {
                  //                 String text;
                  //                 DateTime? selectedDate = await showDatePicker(
                  //                     context: context,
                  //                     initialDate: DateTime.now(),
                  //                     firstDate: DateTime.now(),
                  //                     lastDate: DateTime(2050));
                  //                 if (selectedDate != null) {
                  //                   text = formatter.format(selectedDate);
                  //                   _endDatecontroller.text = text;
                  //                 }
                  //               },
                  //               icon: const Icon(Icons.date_range))),
                  //       validator: (str) {
                  //         if (str == null || str.isEmpty) {
                  //           return 'This field can not be empty';
                  //         }
                  //       },
                  //     )),
                  //     const SizedBox(
                  //       width: 30,
                  //     ),
                  //     Expanded(
                  //         child: TextFormField(
                  //       readOnly: true,
                  //       controller: _endTimecontroller,
                  //       decoration: InputDecoration(
                  //         label: const Text('End time'),
                  //         suffixIcon: IconButton(
                  //             onPressed: () async {
                  //               TimeOfDay? time = await showTimePicker(
                  //                   context: context,
                  //                   initialTime: TimeOfDay.now(),
                  //                   builder: (context, childWidget) {
                  //                     return MediaQuery(
                  //                         data: MediaQuery.of(context).copyWith(
                  //                             alwaysUse24HourFormat: false),
                  //                         child: childWidget!);
                  //                   });

                  //               if (time != null) {
                  //                 if (time.hour > 12) {
                  //                   _endTimecontroller.text =
                  //                       (time.hour - 12).toString() +
                  //                           ' : ' +
                  //                           time.minute.toString() +
                  //                           ' ' +
                  //                           'pm';
                  //                 } else {
                  //                   _endTimecontroller.text =
                  //                       (time.hour.toString().length == 1
                  //                               ? ('0' + time.hour.toString())
                  //                               : time.hour.toString()) +
                  //                           ' : ' +
                  //                           time.minute.toString() +
                  //                           ' ' +
                  //                           'am';
                  //                 }
                  //               }
                  //             },
                  //             icon: const Icon(Icons.watch_later)),
                  //       ),
                  //       validator: (str) {
                  //         if (str == null || str.isEmpty) {
                  //           return 'This field can not be empty';
                  //         }
                  //       },
                  //     ))
                  //   ],
                  // ),
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
                  Filters(callback: (val) {
                    category = val;
                  }),
                  SizedBox(
                    height: _app.appVerticalPadding(2.5),
                  ),
                  const Text(
                    'Working for',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff959595)),
                  ),
                  SizedBox(
                    height: _app.appVerticalPadding(1.5),
                  ),
                  workingFor.isEmpty
                      ? TextButton(
                          onPressed: () async {
                            await _fetchContacts();
                            setState(() async {
                              workingFor = await showContacts(context);
                            });
                          },
                          child: Container(
                            height: _app.appHeight(4),
                            width: _app.appWidth(20),
                            child: const Center(
                                child: const Text(
                              'Add',
                              style: TextStyle(color: const Color(0xff297687)),
                            )),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xff297687)),
                                borderRadius: BorderRadius.circular(12)),
                          ))
                      : SizedBox(
                          height: _app.appHeight(10),
                          width: _app.appWidth(20),
                          child: ListView.builder(
                              itemCount: workingFor.length,
                              itemBuilder: (ctx, i) {
                                return workingFor
                                    .map((e) => Text(
                                          e,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff2E2E2E)),
                                        ))
                                    .toList()[i];
                              }),
                        ),
                  SizedBox(
                    height: _app.appVerticalPadding(2.0),
                  ),
                  const Text(
                    'Allocate people',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff959595)),
                  ),
                  SizedBox(
                    height: _app.appVerticalPadding(1.0),
                  ),
                  allocatedTo.isEmpty
                      ? TextButton(
                          onPressed: () async {
                            await _fetchContacts();
                            setState(() async {
                              allocatedTo = await showContacts(context);
                            });
                          },
                          child: Container(
                            height: _app.appHeight(4),
                            width: _app.appWidth(20),
                            child: const Center(
                                child: const Text(
                              'Add',
                              style: TextStyle(color: const Color(0xff297687)),
                            )),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xff297687)),
                                borderRadius: BorderRadius.circular(12)),
                          ))
                      : SizedBox(
                          height: _app.appHeight(10),
                          width: _app.appWidth(20),
                          child: ListView.builder(
                              itemCount: allocatedTo.length,
                              itemBuilder: (ctx, i) {
                                return allocatedTo
                                    .map((e) => Text(
                                          e,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff2E2E2E)),
                                        ))
                                    .toList()[i];
                              }),
                        ),

                  SizedBox(
                    height: _app.appVerticalPadding(2.0),
                  ),
                  const Text(
                    'Reference',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff959595)),
                  ),
                  SizedBox(
                    height: _app.appVerticalPadding(1.0),
                  ),
                  reference.isEmpty
                      ? TextButton(
                          onPressed: () async {
                            await _fetchContacts();
                            await showContacts(context)
                                .then((value) => setState(() {
                                      reference = value;
                                    }));
                          },
                          child: Container(
                            height: _app.appHeight(4),
                            width: _app.appWidth(20),
                            child: const Center(
                                child: const Text(
                              'Add',
                              style: TextStyle(color: const Color(0xff297687)),
                            )),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xff297687)),
                                borderRadius: BorderRadius.circular(12)),
                          ))
                      : SizedBox(
                          height: _app.appHeight(10),
                          width: _app.appWidth(50),
                          child: ListView.builder(
                              itemCount: reference.length,
                              itemBuilder: (ctx, i) {
                                return reference
                                    .map((e) => Text(
                                          e,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff2E2E2E)),
                                        ))
                                    .toList()[i];
                              }),
                        ),

                  isLoading
                      ? const Center(child: const CircularProgressIndicator())
                      : TextButton(
                          onPressed: () {
                            print(category);
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              Task task = Task(
                                  id: widget.id,
                                  taskName: _namecontroller.text,
                                  description: _descriptioncontroller.text,
                                  workingFor: workingFor,
                                  allocatedTo: allocatedTo,
                                  category: category,
                                  reference: reference,
                                  location:
                                      taskProvider.findTask(widget.id).location,
                                  currentDateTime: taskProvider
                                      .findTask(widget.id)
                                      .currentDateTime);

                              taskProvider.editTask(task).whenComplete(() {
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.of(context).pop();
                              });
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
