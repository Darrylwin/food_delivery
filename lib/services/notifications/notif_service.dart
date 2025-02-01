import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';

class NotifService {
  final notificationPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialised => _isInitialized;

  Future<void> initNotifiaction() async {
    if (_isInitialized) return;

    //prepare android innit settings
    const initSettingAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    //prepare ios init settings
    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    //init settings
    const initSettings = InitializationSettings(
      android: initSettingAndroid,
      iOS: initSettingsIOS,
    );

    //Initialize the plugin
    await notificationPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        // Gérer le tap sur la notification ici
      },
    );

    // Demander les permissions explicitement pour iOS
    if (Platform.isIOS) {
      await notificationPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }

    _isInitialized = true;
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notification',
        channelDescription: 'Daily Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    if (!_isInitialized) {
      await initNotifiaction();
    }

    await notificationPlugin.show(
      id,
      title,
      body,
      notificationDetails(), // Utiliser les détails configurés
    );
  }
}
