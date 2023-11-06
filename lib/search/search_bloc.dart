import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/daily_entry/repository/main_repository.dart';

import '../preferences/shared_preferences.dart';
import 'event_model.dart';

abstract class SearchEvent {}

class OnLoadSearchEvent extends SearchEvent {}

class OnPageChangedEvent extends SearchEvent {
  late final DateTime focusedDate;
  OnPageChangedEvent(this.focusedDate);
}

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



    on<OnPageChangedEvent>((event, emit) async {

          var date = event.focusedDate;
          var eventList = await loadEvents(date, recordRepository);
          emit(GetEventsForDateState(eventList));

    });

    on<OnLoadSearchEvent>((event, emit) async {


           var eventList = await loadEvents(DateTime.now(), recordRepository);
           emit(GetEventsForDateState(eventList));

    });


  }


  Future<LinkedHashMap<DateTime, List<Event>>> loadEvents(DateTime dateTime, RecordRepository recordRepository) async{
     var recordList = await recordRepository.getMonthlyRecord(dateTime.month);


     var eventsMap = {
       for (var item in recordList)
         DateTime.parse("${DateTime.parse(item.date)}Z") :
         [Event(id: item.id, date: item.date)]
     };


     events = LinkedHashMap<DateTime, List<Event>>(
     )..addAll(eventsMap );

     return events;

   }


 }

