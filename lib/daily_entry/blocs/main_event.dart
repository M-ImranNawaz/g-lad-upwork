

import '../models/daily_record_model.dart';

abstract class MainEvent {}

class GetDailyDataEvent extends MainEvent{
  final String date;
  GetDailyDataEvent({required this.date});
}

class SaveDailyDataEvent extends MainEvent{
  final DailyRecordModel data;
  SaveDailyDataEvent({required this.data});
}