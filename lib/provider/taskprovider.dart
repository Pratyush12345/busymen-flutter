import 'dart:convert';

import 'package:Busyman/models/task.dart';
import 'package:Busyman/screens/Bottom_Tabs/Profile_Section/Image_upload/AllTaskVM.dart';
import 'package:Busyman/screens/Twitter/backend/utils/global_variable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> _tasksdup = [];
  List<Task> get tasks {
    return [..._tasks];
  }

  // List<Task> get ongoingtasks {
  //   return _tasks.where((element) => element.status == Status.Ongoing).toList();
  // }

  // List<Task> get pendingtasks {
  //   return _tasks.where((element) => element.status == Status.Pending).toList();
  // }

  // List<Task> get upcomingtasks {
  //   return _tasks
  //       .where((element) => element.status == Status.Upcoming)
  //       .toList();
  // }

  // List<Task> get completedtasks {
  //   return _tasks
  //       .where((element) => element.status == Status.Completed)
  //       .toList();
  // }

  init(){
   _tasks = [];
  _tasksdup = [];
  
  }

  Future<void> addNewTask(Task task) async {
    try {
      final ref = await FirebaseDatabase.instance
          .reference()
          .child('Users/${GlobalVariable.uid}/Tasks/');
      final ref2 = await ref.push().key;
      task.imageUrlList = await AllTaskVM.instance.getUrlListOfImage(ref2.toString());
      ref.child(ref2.toString()).set(task.toJson());
      task.id = ref2;
      // statusUpdate(task);
      _tasks.add(task);
      _tasks.sort((a,b)=> DateTime.parse(b.currentDateTime).compareTo(DateTime.parse(a.currentDateTime)));
      _tasksdup.clear();
      _tasksdup = List.from(_tasks);
      notifyListeners();
    } catch (e) {
      print('error occured in line 15 task provider');
    }
  }

  Future<void> deleteTask(String id,BuildContext context ) async {
    try {
      await FirebaseDatabase.instance
          .reference()
          .child('Users/${GlobalVariable.uid}/Tasks/$id')
          .remove();
      AllTaskVM.instance.deleteAllImageFirebaseStorage(id, context);  
      _tasks.removeWhere((element) => element.id == id);
      _tasksdup.clear();
      _tasksdup = List.from(_tasks);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> editTask(Task task) async {
    print("Edit Task");
    try {
      task.imageUrlList = await (AllTaskVM.instance.getUpdatedUrlListOfImage(task.id));
      await FirebaseDatabase.instance
          .reference()
          .child('Users/${GlobalVariable.uid}/Tasks/${task.id}')
          .update(task.toJson());
      int index = _tasks.indexWhere((element) => element.id == task.id);
      _tasks[index] = task;
      _tasks.sort((a,b)=> DateTime.parse(b.currentDateTime).compareTo(DateTime.parse(a.currentDateTime)));
      _tasksdup.clear();
      _tasksdup = List.from(_tasks);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  // Future<void> updateTask(Task task) async {
  //   try {
  //     await FirebaseDatabase.instance
  //         .reference()
  //         .child('Users/641Wbl9iOLe09ecDYKG7qUKtfz92/Tasks/${task.id}')
  //         .update({"completed": task.completed});
  //     notifyListeners();
  //   } catch (e) {}
  // }

  Future<void> fetchTasks({required bool? reinitialize }) async {
    print("FETCHING TASK_________________________________%%%%%%%%%%%");
    print("GLOB UID-----------${GlobalVariable.uid}");
    if(reinitialize!){
     init();
    }
    if (_tasks.isEmpty) {
      final tasks = await FirebaseDatabase.instance
          .reference()
          .child('Users/${GlobalVariable.uid}/Tasks/')
          .once();
      print(tasks.value);
      if(tasks.value !=null){
      final string = jsonEncode(tasks.value);
      final Map<String, dynamic> data = jsonDecode(string);
      for (int i = 0; i < data.keys.length; i++) {
        print("${data.values.toList()[i]['imageUrls']}");
        
        List<dynamic> imageUrls = data.values.toList()[i]['imageUrls']??[]; 
        print(imageUrls);
        Task task = Task(
          id: data.keys.toList()[i],
          taskName: data.values.toList()[i]['taskName'],
          isDone: data.values.toList()[i]['isDone'] ?? false,
          description: data.values.toList()[i]['description'],
          workingFor: data.values.toList()[i]['workingFor'] != null
              ? data.values
                  .toList()[i]['workingFor']
                  .map<String>((e) => e.toString())
                  .toList()
              : [],
          reference: data.values.toList()[i]['reference'] != null
              ? data.values
                  .toList()[i]['reference']
                  .map<String>((e) => e.toString())
                  .toList()
              : [],
          allocatedTo: data.values.toList()[i]['allocatedTo'] != null
              ? data.values
                  .toList()[i]['allocatedTo']
                  .map<String>((e) => e.toString())
                  .toList()
              : [],
          imageUrlList: imageUrls,       
          category: data.values.toList()[i]['category']??"",
          location: data.values.toList()[i]['location']??"",
          currentDateTime: data.values.toList()[i]['currentDateTime']??"",
        );
        // statusUpdate(task);

        _tasks.add(task);
      }
      _tasks.sort((a,b)=> DateTime.parse(b.currentDateTime).compareTo(DateTime.parse(a.currentDateTime)));
      _tasksdup.clear();
      _tasksdup = List.from(_tasks);
    }
    }
  }

  onSearch(String val){
   if(val.isNotEmpty){
    List<Task> _searchedList = [];

    _searchedList = _tasksdup.where((element) => element.taskName.toLowerCase().contains(val.toLowerCase()) ||
    element.description.toLowerCase().contains(val.toLowerCase())).toList();
     
     if(_searchedList.isEmpty){
       _searchedList = _tasksdup.where((element){
         List<String> _dupAllocatedList = element.allocatedTo.where((element) => element.toLowerCase().contains(val.toLowerCase())).toList();
         if(_dupAllocatedList.isNotEmpty){
           return true;
         }   
         else{
           return false;
         }
      } ).toList();
     }
     if(_searchedList.isEmpty){
       _searchedList = _tasksdup.where((element){
         List<String> _dupAllocatedList = element.workingFor.where((element) => element.toLowerCase().contains(val.toLowerCase())).toList();
         if(_dupAllocatedList.isNotEmpty){
           return true;
         }   
         else{
           return false;
         }
      } ).toList();
     }
     if(_searchedList.isEmpty){
       _searchedList = _tasksdup.where((element){
         List<String> _dupAllocatedList = element.reference.where((element) => element.toLowerCase().contains(val.toLowerCase())).toList();
         if(_dupAllocatedList.isNotEmpty){
           return true;
         }   
         else{
           return false;
         }
      } ).toList();
     }
    _tasks.clear();
    _tasks = List.from(_searchedList);
   }else{
    _tasks.clear();
    _tasks = List.from(_tasksdup);
   }
   notifyListeners();
  }

  onFilter(String val){
   if(val.isNotEmpty){
    List<Task> _searchedList = [];
    if(val == "Done"){
    _searchedList = _tasksdup.where((element) => element.isDone).toList();
    }
    else if(val == "Undone"){
    _searchedList = _tasksdup.where((element) => !element.isDone).toList();  
    }
    else{
    _searchedList = _tasksdup.where((element) => element.category.contains(val)).toList();
    }
    _tasks.clear();
    _tasks = List.from(_searchedList);
   }else{
    _tasks.clear();
    _tasks = List.from(_tasksdup);
   }
   notifyListeners();
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  Task findTask(String id) {
    return _tasks.firstWhere((element) => element.id == id);
  }
  
  // List<Task> findListByStatus(Status status) {
  //   List<Task> list = [];
  //   if (status == Status.Ongoing) {
  //     list = ongoingtasks;
  //   } else if (status == Status.Pending) {
  //     list = pendingtasks;
  //   } else if (status == Status.Completed) {
  //     list = completedtasks;
  //   } else if (status == Status.Upcoming) {
  //     list = upcomingtasks;
  //   }
  //   return list;
  // }

  // void statusUpdate(Task task) {
  //   DateTime startDate =
  //       DateFormat('dd MMM, yyyy').parse(task.startDate.toString());
  //   DateTime endDate =
  //       DateFormat('dd MMM, yyyy').parse(task.endDate.toString());

  //   int diffbetstartandtoday = daysBetween(DateTime.now(), startDate);
  //   int diffbetendandtoday = daysBetween(DateTime.now(), endDate);

  //   if (diffbetstartandtoday > 0 && task.completed == false) {
  //     task.status = Status.Upcoming;
  //   } else if (diffbetstartandtoday <= 0 &&
  //       diffbetendandtoday >= 0 &&
  //       task.completed == false) {
  //     task.status = Status.Ongoing;
  //   } else if (diffbetendandtoday < 0 && task.completed == false) {
  //     task.status = Status.Pending;
  //   } else if (task.completed == true) {
  //     task.status = Status.Completed;
  //   }
  // }
}
