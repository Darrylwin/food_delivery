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
  // ignore: prefer_final_fields
  List<NotificationItem> _notifications = [];
  int _unreadCount = 0;

  List<NotificationItem> get notifications => _notifications;
  int get unreadCount => _unreadCount;

  void addNotification(NotificationItem notification) {
    _notifications.add(notification);
    _unreadCount++;
    notifyListeners();
  }


  void markAllAsRead(){
    _unreadCount = 0;
    notifyListeners();
  }
}
