import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
 
class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async { 
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future<dynamic> selectNotification(String? payload) async {
    //Handle notification tapped logic here
  }
  
  int count = 0;
  tz.TZDateTime _nextInstanceOfTenAM(Duration days) {
    print(tz.local);
    tz.initializeTimeZones();
    
    var ist = tz.getLocation('Asia/Colombo');
    print(ist);
    final tz.TZDateTime now = tz.TZDateTime.now(ist);
    
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(ist, now.year, now.month, now.day, now.hour, now.minute );
    // if (scheduledDate.isBefore(now)) {
    //   scheduledDate = scheduledDate.add(days);
    // }
    scheduledDate = scheduledDate.add(days);
    return scheduledDate;
  }

  void scheduleNotification(
    String title,
    String description,
    Duration days,
    int notificationId
  ) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
        "Busymen",
        description,
        _nextInstanceOfTenAM(days),
         NotificationDetails(
            android: AndroidNotificationDetails(
          'title101',
          'description101',
          'Busyman Reminders'
        )),
        androidAllowWhileIdle:false,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime);
    count++;
  } 

  deleteNotification(int id){
    flutterLocalNotificationsPlugin.cancel(id);
  }

   showNotification(String title, String body, String id) async {
    var android = AndroidNotificationDetails(
        title + id,
        title + id,
        body,
        importance: Importance.high);
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);

    flutterLocalNotificationsPlugin.show(
        int.parse(id), title, body, platform,
        payload: "FLUTTER_NOTIFICATION_CLICK");
  }
}
