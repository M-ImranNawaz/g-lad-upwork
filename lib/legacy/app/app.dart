import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sizer/sizer.dart';

import '../../app_router.dart';
import '../daily_entry/repository/main_repository.dart';
import '/music_service/music_service.dart';
import '../preferences/shared_preferences.dart';


BehaviorSubject<Color> appThemeColor = BehaviorSubject<Color>.seeded(Colors.deepPurple);

class MyApp extends StatefulWidget {
   const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   @override
  Widget build(BuildContext context) {
     return Sizer(builder: (context, orientation, deviceType){
         // var appThemeColor;
         return MultiRepositoryProvider(
           providers: [
             RepositoryProvider(
               create: (context) => RecordRepository(),
             ),
             RepositoryProvider(
               create: (context) => MusicService(),
             ),
             RepositoryProvider(
               create: (context) => SharedPreferencesService(),
             ),
           ],
           child: StreamBuilder<Object>(
             stream: appThemeColor.stream,
             builder: (context, snapshot) {
               return MaterialApp.router(
                 routerConfig: router,

                 theme: ThemeData(
                   useMaterial3: true,
                   colorScheme: ColorScheme.fromSeed(seedColor: appThemeColor.value)


                 ),
                 darkTheme: ThemeData(
                   colorSchemeSeed: Colors.deepPurpleAccent,
                   brightness: Brightness.dark,
                   useMaterial3: true,
                 ),

               );
             }
           ),
         );
     });
  }
}

