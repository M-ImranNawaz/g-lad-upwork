import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:glad/app/GladApp.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'legacy/notification_manager/notification_manager.dart';
import 'package:timezone/data/latest.dart' as tz;


void main() async {
  await dotenv.load(fileName: "assets/.env");
  await Supabase.initialize(
    url: dotenv.env['ANON_URL'] ?? "",
    anonKey: dotenv.env['ANON_KEY'] ?? "",
  );

  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.requestPermission();
  runApp(const GladApp());
}
