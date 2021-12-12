import 'package:Busyman/provider/loginprovider.dart';
import 'package:Busyman/provider/reminderprovider.dart';
import 'package:Busyman/provider/taskprovider.dart';
import 'package:Busyman/screens/No_internet/connectivity_wrapper.dart';
import 'package:Busyman/screens/Twitter/backend/providers/change_bottom_tab_provider.dart';
import 'package:Busyman/screens/Twitter/backend/providers/dashboard_provider.dart';
import 'package:Busyman/services/notification_service.dart';
import 'package:Busyman/services/routes.dart';
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
       child: GestureDetector(
         onTap: () {
         FocusManager.instance.primaryFocus!.unfocus();
        },
      
         child: MaterialApp(
           title: 'Busymen',
           debugShowCheckedModeBanner: false,
           theme: ThemeData(
             primarySwatch: MaterialColor(
               0xff205072,
               <int, Color>{
                 50: Color(0xff205072),
                100: Color(0xff205072),
                200: Color(0xff205072),
                300: Color(0xff205072),
                400: Color(0xff205072),
                500: Color(0xff205072),
                600: Color(0xff205072),
                700: Color(0xff205072),
                800: Color(0xff263238),
                900: Color(0xff205072),
               }
             ),
           ),
           home: ConnectivityWrapper(),
           initialRoute: '/',
           onGenerateRoute: RouteGenerator.generateRoute,
         ),
       ),
     ),
      );
  }
}
