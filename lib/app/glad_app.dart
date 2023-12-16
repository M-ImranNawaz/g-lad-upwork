import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/login/cubit/login_cubit.dart';
import 'package:glad/signup/cubit/signup_cubit.dart';
import 'package:sizer/sizer.dart';

import '../app_router.dart';
import '../legacy/daily_entry/repository/main_repository.dart';
import '../legacy/preferences/shared_preferences.dart';
import '../music_service/music_service.dart';

class GladApp extends StatelessWidget {
  const GladApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
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
          BlocProvider( 
            create: (context) => SignupCubit(),
          ),
          BlocProvider(
            create: (context) => LoginCubit(),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: router,
          theme: ThemeData(
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            useMaterial3: true,
          ),
        ),
      );
    });
  }
}
