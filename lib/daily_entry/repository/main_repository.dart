import '../models/daily_record_model.dart';
import '../services/main_service.dart';

class RecordRepository {
  final RecordService _recordService = RecordService();

  Future<DailyRecordModel> saveDailyRecord(DailyRecordModel dailyRecord) async{
    return await _recordService.saveDailyRecord(dailyRecord);
  }

  Future<List<DailyRecordModel>> getMonthlyRecord (int month) async{
    return  await _recordService.getMonthlyRecord(month);
  }

  Future<SearchResult> getKeywordSearchRecord (String keyword) async{
    print("keyword is $keyword");
    return  await _recordService.getKeywordSearchRecord(keyword);
  }

  Future<DailyRecordModel> getDailyRecord(String date) async {
    return await _recordService.getDailyRecord(date);
  }

}