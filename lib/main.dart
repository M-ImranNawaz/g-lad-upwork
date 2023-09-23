import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'app/app.dart';
import 'notification_manager/notification_manager.dart';
import 'package:timezone/data/latest.dart' as tz;

BehaviorSubject<Color> appThemeColor = BehaviorSubject<Color>.seeded(Colors.deepPurple);


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.requestPermission();
  runApp(const MyApp());
}
