
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/main_repository.dart';
import 'main_event.dart';
import 'main_state.dart';

class MainBloc extends Bloc<MainEvent,MainState>{

  final RecordRepository mainRepository = RecordRepository();

  MainBloc() : super(MainStateInitial()){
    on<GetDailyDataEvent>(_onGetDailyDataEvent);
    on<SaveDailyDataEvent>(_onSaveDailyDataEvent);
  }

  void _onGetDailyDataEvent(GetDailyDataEvent event, Emitter<MainState> emit) async{
      var data = await mainRepository.getDailyRecord(event.date);
      emit(DailyRecordDataState(data: data));
  }


  void _onSaveDailyDataEvent(SaveDailyDataEvent event, Emitter<MainState> emit) async{
    var data = await mainRepository.saveDailyRecord(event.data);
    emit(DailyRecordDataState(data: data,isSaveSuccess: true,message: "Save success"));
  }

}