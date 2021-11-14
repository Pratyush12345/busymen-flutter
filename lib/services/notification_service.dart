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
        AndroidInitializationSettings('clock');

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
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
    if (scheduledDate.isBefore(now)) {
      print('yes');
      scheduledDate = scheduledDate.add(days);
    }
    return scheduledDate;
  }

  void scheduleNotification(
    String title,
    String description,
    Duration days,
  ) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        count,
        title,
        description,
        _nextInstanceOfTenAM(days),
        const NotificationDetails(
            android: AndroidNotificationDetails(
          'Busyman1234',
          'Busyman',
          'Busyman Reminders'
        )),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
    count++;
  }
}
