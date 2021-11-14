import 'dart:convert';

import 'package:busyman/models/reminder.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Reminderprovider extends ChangeNotifier {
  DateFormat formatter = DateFormat('dd MMM, yyyy');
  List<Reminder> _reminders = [];
  List<Reminder> get reminders {
    return [..._reminders];
  }

  Map<int, List<Reminder>> dateViseReminders = {
    0: [],
    1: [],
    2: [],
    3: [],
    4: [],
    5: [],
  };

  fetchDateVise(DateTime date) {
    DateTime day1 = date.subtract(const Duration(days: 2));
    DateTime day2 = date.subtract(const Duration(days: 1));
    DateTime day3 = date;
    DateTime day4 = date.add(const Duration(days: 1));
    DateTime day5 = date.add(const Duration(days: 2));
    DateTime day6 = date.add(const Duration(days: 3));
    dateViseReminders[0] = _reminders
        .where((element) => element.date == formatter.format(day1))
        .toList();
    dateViseReminders[1] = _reminders
        .where((element) => element.date == formatter.format(day2))
        .toList();
    dateViseReminders[2] = _reminders
        .where((element) => element.date == formatter.format(day3))
        .toList();
    dateViseReminders[3] = _reminders
        .where((element) => element.date == formatter.format(day4))
        .toList();
    dateViseReminders[4] = _reminders
        .where((element) => element.date == formatter.format(day5))
        .toList();
    dateViseReminders[5] = _reminders
        .where((element) => element.date == formatter.format(day6))
        .toList();
    notifyListeners();
  }

  Future<void> addReminder(Reminder reminder) async {
    try {
      final ref = await FirebaseDatabase.instance
          .reference()
          .child('Users/641Wbl9iOLe09ecDYKG7qUKtfz92/Reminders/');
      final ref2 = await ref.push().get();
      ref.child(ref2.key.toString()).set(reminder.toJson());
      reminder.id = ref2.key!;

      _reminders.add(reminder);
      notifyListeners();
    } catch (e) {}
  }

  Future<void> deleteReminder(String id) async {
    try {
      await FirebaseDatabase.instance
          .reference()
          .child('Users/641Wbl9iOLe09ecDYKG7qUKtfz92/Reminders/$id')
          .remove();
      _reminders.removeWhere((element) => element.id == id);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> editReminder(Reminder reminder) async {
    try {
      await FirebaseDatabase.instance
          .reference()
          .child('Users/641Wbl9iOLe09ecDYKG7qUKtfz92/Reminders/${reminder.id}')
          .update(reminder.toJson());
      int index = _reminders.indexWhere((element) => element.id == reminder.id);
      _reminders[index] = reminder;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchReminders() async {
    if (_reminders.isEmpty) {
      final tasks = await FirebaseDatabase.instance
          .reference()
          .child('Users/641Wbl9iOLe09ecDYKG7qUKtfz92/Reminders/')
          .get();
      print(tasks.value);
      final string = jsonEncode(tasks.value);
      final Map<String, dynamic> data = jsonDecode(string);
      for (int i = 0; i < data.keys.length; i++) {
        Reminder task = Reminder(
          id: data.keys.toList()[i],
          reminderName: data.values.toList()[i]['reminderName'],
          date: data.values.toList()[i]['date'],
          time: data.values.toList()[i]['time'],
          category: data.values.toList()[i]['category'],
        );

        _reminders.add(task);
      }
    }
  }

  Reminder findReminder(String id) {
    return _reminders.firstWhere((element) => element.id == id);
  }
}