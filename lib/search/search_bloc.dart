import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/daily_entry/repository/main_repository.dart';

import '../preferences/shared_preferences.dart';
import 'event_model.dart';

abstract class SearchEvent {}

class OnLoadSearchEvent extends SearchEvent {}

abstract class SearchState {}

class OnLoadSearchState extends SearchState {}


class GetEventsForDateState extends SearchState {
  final LinkedHashMap<DateTime, List<Event>> data;
  GetEventsForDateState(this.data);
}

class SearchBloc extends Bloc<SearchEvent, GetEventsForDateState> {

  LinkedHashMap<DateTime, List<Event>> events = LinkedHashMap();
  late DateTime now;
  late DateTime eventDt;


  SearchBloc(
      RecordRepository recordRepository, SharedPreferencesService sharedPreferencesService)
      : super(GetEventsForDateState(LinkedHashMap())) {


    on<OnLoadSearchEvent>((event, emit) async {


      var recordList = await recordRepository.getMonthlyRecord(DateTime.now().month);


      var eventsMap = {
        for (var item in recordList)
          DateTime.parse("${DateTime.parse(item.date)}Z") :
          [Event(id: item.id, date: item.date)]
      };


      events = LinkedHashMap<DateTime, List<Event>>(
      )..addAll(eventsMap );

      emit(GetEventsForDateState(events));

    });


  }

  }

