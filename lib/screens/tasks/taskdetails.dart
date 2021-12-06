import 'package:Busyman/provider/taskprovider.dart';
import 'package:Busyman/screens/Bottom_Tabs/Profile_Section/Image_upload/AllTaskVM.dart';
import 'package:Busyman/screens/Bottom_Tabs/Profile_Section/Image_upload/BeforeImageLoading.dart';
import 'package:Busyman/screens/Bottom_Tabs/Profile_Section/Image_upload/imagefull_show.dart';
import 'package:Busyman/screens/Twitter/backend/providers/dashboard_provider.dart';
import 'package:Busyman/screens/tasks/taskfilters.dart';
import 'package:Busyman/services/appColor.dart';
import 'package:Busyman/services/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import 'package:provider/provider.dart';
class TaskDetail extends StatefulWidget {
  final String id;
  TaskDetail(this.id);

  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  
  late String category = '';
  late List<String> workingFor = [];
  late List<String> allocatedTo = [];
  late List<String> reference = [];
  bool workingfor = false;
  bool allocatedto = false;
  DateFormat formatter = DateFormat('dd MMM, yyyy');
  String nameText = "";
  String descriptionText = "";
  List<Contact>? _contacts;
  Map<String, Color> _filtercolour = {
    "Political" :const Color(0xff81B4FE),
    "Ward": const Color(0xff81B4FE),
    "Work": const Color(0xffFEB765),
    "Business":const Color(0xff5CC581),
    "Extra" : const Color(0xffFF866B)
  };
  bool isLoading = false;
  bool _permissionDenied = false;
  bool initial = true;
  String location = "", currentdateTime = ""; 
  @override
    void initState() {
      AllTaskVM.instance.init();
      super.initState();
    }
  @override
  void didChangeDependencies() {
    if (initial) {
      final task =
          Provider.of<TaskProvider>(context, listen: false).findTask(widget.id);
      nameText = task.taskName;
      descriptionText = task.description;
      category = task.category;
      workingFor = task.workingFor;
      allocatedTo = task.allocatedTo;
      reference = task.reference;
      currentdateTime = task.currentDateTime;
      location = task.location;
      int count = 0;
      print("---------------");
      print(task.imageUrlList);
      print("---------------");
      task.imageUrlList.forEach((element) {
       if(element == null || element.toString().isEmpty){
         count++;
       }else{
       AllTaskVM.instance.imageUrlList.add(ImageTaskModel(
          file: File(""),
          fileurl: element??"",
          position: count++
        ));
       }
       });
       print("^^^^^^^^^^^^^^");
       AllTaskVM.instance.imageUrlList.forEach((element) { 
         print(element.position);
       });
       print("^^^^^^^^^^^^^^");
    }
    initial = false;
    super.didChangeDependencies();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    late App _app = App(context);
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Task Details',
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
      body: SafeArea(
          child: ListView(
        children: [
         Text(
            "$nameText",
            style: TextStyle(
                color: Color(0xff297687),
                fontWeight: FontWeight.w700,
                fontSize: 20),
          ),
          SizedBox(
            height: _app.appVerticalPadding(1.0),
          ),
          Text(
            "$descriptionText",
            style: TextStyle(
                color: Color(0xff858585),
                fontWeight: FontWeight.w400,
                fontSize: 14),
          ),
          SizedBox(
            height: _app.appVerticalPadding(1.0),
          ),
          const Text(
                    'Category',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff959595)),
                  ),
                  
          FilterChip(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: _filtercolour[category],
            label:
                 Text('$category', style: TextStyle(color: Colors.white)),
            selectedColor: Colors.purpleAccent,
            onSelected: (bool selected) {},
            elevation: 6,
          ),
          SizedBox(
            height: _app.appVerticalPadding(3.0),
          ),
          Row(
            children: [
              Icon(Icons.arrow_forward_ios),
              Icon(Icons.arrow_forward_ios),
              SizedBox(
                width: _app.appHorizontalPadding(2),
              ),
              Text("Created On"),
              Text("${currentdateTime}"),
              Text("12:00 pm"),
            ],
          ),
          SizedBox(
            height: _app.appVerticalPadding(0.5),
          ),
          Row(
            children: [
              const Icon(Icons.arrow_forward_ios),
              const Icon(Icons.arrow_forward_ios),
              SizedBox(
                width: _app.appHorizontalPadding(2),
              ),
              const Text("Created at"),
              Text("$location"),
              const Text("12:00 pm"),
            ],
          ),
          SizedBox(
            height: _app.appVerticalPadding(3.0),
          ),
          const Text("Work"),
          workingFor.isEmpty
                      ? const Text("No Contact Selected")
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
          const Text("Allocation"),
          allocatedTo.isEmpty
                      ? const Text("No Contact Selected")
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
        const Text("Reference"),
                          
        reference.isEmpty
                      ? const Text("No Contact Selected")
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
                  SizedBox(
                    height: _app.appVerticalPadding(2.0),
                  ),      
                  const Text(
                    'Task Photos',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff959595)),
                  ),
                 SizedBox(
                    height: _app.appVerticalPadding(1.0),
                  ),
                  Consumer<ChangeAddTaskImageProvider>(
                    builder: (context, model, child){
                    if(AllTaskVM.instance.imageUrlList.isNotEmpty)     
                    
                    return Row(children: AllTaskVM.instance.imageUrlList.map((e) =>
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ImageFullshow(
                          imageurl: e.fileurl,
                          isEdit: true,
                          pos: e.position,
                          taskid: widget.id,
                        )));
                      },
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        color: greyColour,
                        child: Image.network(e.fileurl),  
                      ),
                    ),
                     
                    ).toList() ,);
                    else
                    return SizedBox();
                    }
                  ),
                   
        ],
      )),
    );
  }
}
