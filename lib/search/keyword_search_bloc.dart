

import 'package:flutter_bloc/flutter_bloc.dart';

import '../daily_entry/models/daily_record_model.dart';
import '../daily_entry/repository/main_repository.dart';
import '../preferences/shared_preferences.dart';

abstract class KeywordSearchEvent {}
class OnLoadSearchEvent extends KeywordSearchEvent {}

class OnKeywordSearchBeginEvent extends KeywordSearchEvent{
   String keyword;
   OnKeywordSearchBeginEvent(this.keyword);
}

abstract class KeywordSearchState {}

class KeywordResultListState extends KeywordSearchState {
   String keyword;
   List<DailyRecordModel> list;
   KeywordResultListState(this.list, this.keyword);
}




class KeywordSearchBloc extends Bloc<KeywordSearchEvent, KeywordResultListState> {


  KeywordSearchBloc(
      RecordRepository recordRepository, SharedPreferencesService sharedPreferencesService)
      : super(KeywordResultListState([],"")) {


    on<OnLoadSearchEvent>((event, emit) async {});

    on<OnKeywordSearchBeginEvent>((event, emit) async {

         var keyword = event.keyword;
         if(keyword.isNotEmpty){
           SearchResult result = await recordRepository.getKeywordSearchRecord(keyword);
           List<DailyRecordModel> list = result.dailyRecordModel;

           list.sort((a, b) {
             int aDate = DateTime.parse(a.date ?? '').microsecondsSinceEpoch;
             int bDate = DateTime.parse(b.date ?? '').microsecondsSinceEpoch;
             return bDate.compareTo(aDate);
          });
           emit(KeywordResultListState(list,keyword));
         }
         else{
           emit(KeywordResultListState([],keyword));
         }



    });

  }

}