import 'package:Busyman/provider/taskprovider.dart';
import 'package:Busyman/screens/Bottom_Tabs/Profile_Section/Image_upload/AllTaskVM.dart';
import 'package:Busyman/screens/Bottom_Tabs/Profile_Section/Image_upload/BeforeImageLoading.dart';
import 'package:Busyman/screens/Bottom_Tabs/Profile_Section/Image_upload/imagefull_show.dart';
import 'package:Busyman/screens/Twitter/backend/providers/dashboard_provider.dart';
import 'package:Busyman/screens/tasks/taskfilters.dart';
import 'package:Busyman/services/AddressCaluclator.dart';
import 'package:Busyman/services/appColor.dart';
import 'package:Busyman/services/date_to_str.dart';
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
  Map<String, Color> _filtercolour = {
    "Political" :const Color(0xff81B4FE),
    "Ward": const Color(0xffd1b3ff),
    "Work": const Color(0xffFEB765),
    "Business":const Color(0xff5CC581),
    "Extra" : const Color(0xffFF866B)
  };
  bool isLoading = false;
  bool _permissionDenied = false;
  bool initial = true;
  double lat = 0.0, long = 0.0;
  String location = "", address = "", currentdateTime = ""; 
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
      location = task.location.trim();
      lat = double.parse(location.split(",")[0].trim());
      long = double.parse(location.split(",")[1].trim());
      AddressCalculator(lat, long).getLocation().then((value)
      {
        address = value;
        setState(() {});
      });
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
        padding: const EdgeInsets.all(12.0),
            
        children: [
         Text(
            "$nameText",
            style: TextStyle(
                color: Color(0xff297687),
                fontWeight: FontWeight.w700,
                fontSize: 20),
          ),
          SizedBox(
            height: _app.appVerticalPadding(2.0),
          ),
          Text(
            "$descriptionText",
            style: TextStyle(
                color: Color(0xff858585),
                fontWeight: FontWeight.w400,
                fontSize: 16),
          ),
          SizedBox(
            height: _app.appVerticalPadding(3.0),
          ),
                  
          Align(
            alignment: Alignment.centerLeft,
            child: FilterChip(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              backgroundColor: _filtercolour[category],
              label:
                   Text('$category', style: TextStyle(color: Colors.white)),
              selectedColor: Colors.purpleAccent,
              onSelected: (bool selected) {},
              elevation: 6,
            ),
          ),
          SizedBox(
            height: _app.appVerticalPadding(3.0),
          ),
          const Text("Work", style: TextStyle(
            color: Color(0xff959595)
          ),),
          SizedBox(
                    height: _app.appVerticalPadding(1.5),
                  ),
          workingFor.isEmpty
                      ? const Text("No Contact Selected")
                      : SizedBox(
                          height: _app.appHeight(10),
                          width: _app.appWidth(70),
                          child: ListView.builder(
                              itemCount: workingFor.length,
                              itemBuilder: (ctx, i) {
                                return workingFor
                                    .map((e) => Row(
                                      children: [
                                        Icon(Icons.perm_identity,
                                        color: Color(0xff959595),),
                                        SizedBox(width: 10.0,),
                                        
                                        Text(
                                              e.replaceAll("\n"," "),
                                              overflow: TextOverflow.ellipsis,
                                              
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff2E2E2E)),
                                            ),
                                      ],
                                    ))
                                    .toList()[i];
                              }),
                        ),
          const Text("Allocation",style: TextStyle(
            color: Color(0xff959595)
          ),),
          
          SizedBox(
                    height: _app.appVerticalPadding(1.5),
                  ),
          allocatedTo.isEmpty
                      ? const Text("No Contact Selected")
                      : SizedBox(
                          height: _app.appHeight(10),
                          width: _app.appWidth(70),
                          child: ListView.builder(
                              itemCount: allocatedTo.length,
                              itemBuilder: (ctx, i) {
                                return allocatedTo
                                    .map((e) => Row(
                                      children: [
                                        Icon(Icons.perm_identity,
                                        color: Color(0xff959595),),
                                        SizedBox(width: 10.0,),
                                        
                                        Text(
                                              e.replaceAll("\n"," "),
                                              overflow: TextOverflow.ellipsis,
                                              
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff2E2E2E)),
                                            ),
                                      ],
                                    ))
                                    .toList()[i];
                              }),
                        ),
       
        const Text("Reference",style: TextStyle(
            color: Color(0xff959595)
          ),),
        SizedBox(
                    height: _app.appVerticalPadding(1.5),
                  ),                  
        reference.isEmpty
                      ? const Text("No Contact Selected")
                      : SizedBox(
                          height: _app.appHeight(10),
                          width: _app.appWidth(70),
                          child: ListView.builder(
                              itemCount: reference.length,
                              itemBuilder: (ctx, i) {
                                return reference
                                    .map((e) => Row(
                                      children: [
                                        Icon(Icons.perm_identity,
                                        color: Color(0xff959595)),
                                        SizedBox(width: 10.0,),
                                        
                                        Text(
                                              e.replaceAll("\n"," "),
                                              overflow: TextOverflow.ellipsis,
                                              
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff2E2E2E)),
                                            ),
                                      ],
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
                    return SizedBox(
                      height: _app.appHeight(5),
                      child: Center(
                        child: Text("No Photos attached",
                        style: TextStyle(
                          fontSize: 16.0
                        ),),
                      ),
                    );
                    }
                  ),
         SizedBox(
            height: _app.appVerticalPadding(5),
          ),         
         Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.timer,
              color: Color(0xff959595)),
              SizedBox(
                width: _app.appHorizontalPadding(2),
              ),
              Expanded(
                flex: 1,
                child: Text("Created On")),
              Expanded(
                flex: 3,
                child: Text(" ${DateToStr.instance.datetostr(currentdateTime)}  ${DateToStr.instance.datetoTime(currentdateTime)}")),
            
            ],
          ),
          SizedBox(
            height: _app.appVerticalPadding(0.5),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on_outlined,
              color: Color(0xff959595)),
              SizedBox(
                width: _app.appHorizontalPadding(2),
              ),
              Expanded(
                flex: 1,
                child: const Text("Created at")),
              Expanded(
                flex: 3,
                child: Container(
                  width: _app.appWidth(60),
                  height: _app.appHeight(10),
                  child: Text("${address}",
                  maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: _app.appVerticalPadding(3.0),
          ),
                    
        ],
      )),
    );
  }
}
