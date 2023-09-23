

import '../models/daily_record_model.dart';

abstract class MainState{}


class MainStateInitial extends MainState {}


class DailyRecordDataState extends MainState{
  final DailyRecordModel? data;
  final bool? isLoading;
  final bool? isSaveSuccess;
  final String? message;

  DailyRecordDataState({this.data,this.isLoading,this.isSaveSuccess, this.message});

}
