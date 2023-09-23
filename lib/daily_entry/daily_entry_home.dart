import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/daily_entry/ui/record_entry_daily_page.dart';

import 'blocs/main_bloc.dart';

class DailyEntryHome extends StatefulWidget{
  final String? date;
  const DailyEntryHome({super.key,  required this.date});

  @override
  State<DailyEntryHome> createState() => _DailyEntryHomeState();
}

class _DailyEntryHomeState extends State<DailyEntryHome> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(

       body:  BlocProvider<MainBloc>(
         create: (context) => MainBloc(),
         child:  RecordEntryDailyPage(date: widget.date ?? "",),
       ),
     );
  }
}