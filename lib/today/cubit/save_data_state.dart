part of 'save_data_cubit.dart';

abstract class SaveDataState {}

class SaveDataInitial extends SaveDataState {}

class SaveDataLoading extends SaveDataState {}

class SaveDataSuccess extends SaveDataState {}


class SaveDataValidFailure extends SaveDataState {
   final String error;
  SaveDataValidFailure(this.error);
}

class SaveDataFailure extends SaveDataState {
  final String error;

  SaveDataFailure(this.error);
}
