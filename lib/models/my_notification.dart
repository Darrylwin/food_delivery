import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String description;
  final String time;

  NotificationItem({
    required this.title,
    required this.description,
    required this.time,
  });
}

class NotificationProvider extends ChangeNotifier {
  List<NotificationItem> _notifications = [];

  List<NotificationItem> get notifications => _notifications;

  void addNotification(NotificationItem notification) {
    _notifications.insert(0, notification);
    notifyListeners();
  }
}
