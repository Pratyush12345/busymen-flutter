import 'package:Busyman/provider/taskprovider.dart';
import 'package:Busyman/screens/tasks/alltaskstopwidget.dart';
import 'package:Busyman/screens/tasks/taskFilterHomePage.dart';
import 'package:Busyman/screens/tasks/taskwidget1.dart';
import 'package:Busyman/services/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskTab extends StatefulWidget {
  const TaskTab({ Key? key }) : super(key: key);

  @override
  _TaskTabState createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {

  late App _app;
  List<bool> tasks = [false];
  bool initial = true;
  bool isLoading = false;
  
  @override
    void initState() {
      
      super.initState();
    }
  
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    print("INITIAL_______------------------$initial");
    print("IS LOADING_______------------------$isLoading");
    print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");

    if (initial) {
      setState(() {
        isLoading = true;
      });
      Future.delayed(Duration.zero).whenComplete(() async =>
          await Provider.of<TaskProvider>(context, listen: false)
              .fetchTasks(reinitialize: true )
              .whenComplete(() => setState(() {
                    isLoading = false;
                  })));
    }
    initial = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    _app = App(context);
    
    return Column( 
        children: [
          TopView(headername: "Tasks",),
          SizedBox(
            height: _app.appVerticalPadding(5.5),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: HomePageFilters(
              callback: (val) {
                taskProvider.onFilter(val);
              }, isedit: false,
            ),
          ),
          SizedBox(
            height: _app.appVerticalPadding(0.0),
          ),
          isLoading
              ? Container(
                height: 400,
                child: const Center(
                    child: CircularProgressIndicator(),
                  ),
              )
              : Expanded(
                  child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView.builder(
                      itemCount: taskProvider.tasks.length,
                      itemBuilder: (ctx, i) {
                        return taskProvider.tasks
                            .map((e) => Column(
                                  children: [
                                    TaskWidget(
                                      task: e,
                                    ),
                                    SizedBox(
                                      height: _app.appVerticalPadding(1.0),
                                    )
                                  ],
                                ))
                            .toList()[i];
                      }),
                )),
        ],
      );
  }
}