import 'package:busyman/models/task.dart';
import 'package:busyman/screens/login/loginscreen.dart';
import 'package:busyman/screens/login/otp_verfication.dart';
import 'package:busyman/screens/reminder/addreminder.dart';
import 'package:busyman/screens/reminder/allreminders.dart';
import 'package:busyman/screens/reminder/editreminder.dart';
import 'package:busyman/screens/tasks/addtaskscreen.dart';
import 'package:busyman/screens/tasks/alltasks.dart';
import 'package:busyman/screens/tasks/alltasks1.dart';
import 'package:busyman/screens/tasks/editTaskScreen.dart';
import 'package:busyman/screens/tasks/sectiontaskscreen.dart';
import 'package:busyman/screens/tasks/taskdetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    late final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LogInScreen());
      case '/Alltasks':
        return MaterialPageRoute(builder: (_) => const AllTasks());
      case '/AddTask':
        return MaterialPageRoute(builder: (_) => AddTask());
      case '/TaskDetail':
        return MaterialPageRoute(builder: (_) => const TaskDetail());
      // case '/SectionTask':
      //   return MaterialPageRoute(
      //       builder: (_) => SectionTaskScreen(
      //             list: args as List,
      //           ));
      case '/Reminders':
        return MaterialPageRoute(builder: (_) => const AllReminders());
      case '/AddReminder':
        return MaterialPageRoute(builder: (_) => const AddReminder());
      case '/otp':
        return MaterialPageRoute(builder: (_) => const OtpScreen());
      case '/EditTask':
        return MaterialPageRoute(
            builder: (_) => EditTask(
                  args! as String,
                ));
      case '/EditReminder':
        return MaterialPageRoute(
            builder: (_) => EditReminder(
                  args! as String,
                ));
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
