class Reminder {
  String id;
  String reminderName;
  String date;
  String time;
  String category;
  int notificationId;
  Reminder(
      {required this.id,
      required this.date,
      required this.reminderName,
      required this.time,
      required this.notificationId,
      required this.category});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['time'] = this.time;
    data['reminderName'] = this.reminderName;
    data['category'] = this.category;
    data['notificationId'] =  this.notificationId;
    return data;
  }
}
