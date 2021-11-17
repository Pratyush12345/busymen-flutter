import 'package:busyman/provider/loginprovider.dart';
import 'package:busyman/provider/reminderprovider.dart';
import 'package:busyman/provider/taskprovider.dart';
import 'package:busyman/screens/No_internet/connectivity_wrapper.dart';
import 'package:busyman/screens/Twitter/backend/providers/change_bottom_tab_provider.dart';
import 'package:busyman/screens/Twitter/backend/providers/dashboard_provider.dart';
import 'package:busyman/screens/login/loginscreen.dart';
import 'package:busyman/screens/tasks/Bottom_Tabs/Profile_Section/profile_tab.dart';
import 'package:busyman/screens/tasks/alltasks.dart';
import 'package:busyman/screens/wrapper.dart';
import 'package:busyman/services/notification_service.dart';
import 'package:busyman/services/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FBUser>.value(
      value: Auth.instance.appuser,
      initialData: FBUser(uid: ""),
      
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => TaskProvider()),
           ChangeNotifierProvider(create: (ctx) => ChangeAddTaskImageProvider()),
          ChangeNotifierProvider(create: (ctx) => Reminderprovider()),
          ChangeNotifierProvider(create: (ctx) => FollowingDashboardProvider()),
          ChangeNotifierProvider(create: (ctx) => FollowerDashboardProvider()),
          ChangeNotifierProvider(create: (ctx) => AllSelectedDashboardProvider()),
          ChangeNotifierProvider(create: (ctx) => SearchUserProvider()),
          ChangeNotifierProvider(create: (ctx) => ChangeBottomTabProvider()),
          ChangeNotifierProvider(create: (ctx) => UserProfileProvider()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: ConnectivityWrapper(),
          initialRoute: '/',
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }
}
