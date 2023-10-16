import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/daily_record_model.dart';

class RecordService {


  Future<DailyRecordModel> saveDailyRecord(DailyRecordModel dailyRecord) async {
    //get db Path
    var pathDb = await _getPathDB();

    //open database
    var db = await openDatabase(pathDb);

    var queryResult = await db.query(
    'daily_record',
    where: 'date = ?',
    whereArgs: [dailyRecord.date],
    limit: 1,
    );

    if (queryResult.isNotEmpty) {
      //record exist, update
      var existDailyRecord = DailyRecordModel.fromJson(queryResult.first);
      dailyRecord.id = existDailyRecord.id;
      await db.update(
          'daily_record',
          {
            'grateful': dailyRecord.grateful,
            'learned': dailyRecord.learned,
            'appreciated': dailyRecord.appreciated,
            'delighted': dailyRecord.delighted,
            'date': dailyRecord.date,
            'month':dailyRecord.month
          },
          where: 'id = ?',
          whereArgs: [dailyRecord.id]);

    } else {
      //record no exist insert
      int recordId = await db.insert('daily_record', {
        'grateful': dailyRecord.grateful,
        'learned': dailyRecord.learned,
        'appreciated': dailyRecord.appreciated,
        'delighted': dailyRecord.delighted,
        'date': dailyRecord.date,
        'month': dailyRecord.month,
      });
      dailyRecord.id = recordId;
      print("insert");
    }
    await db.close();
    return dailyRecord;
  }



  Future<List<DailyRecordModel>> getMonthlyRecord(int month) async {
    //get db Path
    var pathDb = await _getPathDB();
    //open database
    var db = await openDatabase(pathDb);
    var queryResult = await db.query(
      'daily_record',
      where: 'month = ?',
      whereArgs: [month],

    );

    await db.close();
    if (queryResult.isNotEmpty) {
      return List.from(queryResult.map((e) => DailyRecordModel.fromJson(e)));

    } else {
      return [];
    }
  }




  Future<List<DailyRecordModel>> getKeywordSearchRecord(String keyword) async {

    //get db Path
    var pathDb = await _getPathDB();
    //open database
    var db = await openDatabase(pathDb);
   // OR learned OR appreciated OR delighted

    var queryResult = await db.rawQuery("""
    SELECT * FROM daily_record
    WHERE grateful  LIKE '%$keyword%'
    ORDER BY date DESC
    """);


    print("my query result is ${queryResult.length}");

    await db.close();
    if (queryResult.isNotEmpty) {
      return List.from(queryResult.map((e) => DailyRecordModel.fromJson(e)));

    } else {
      return [];
    }
  }



  int _getParsedDateMonth(String date){
    return DateTime.parse(date).month;
  }

  Future<DailyRecordModel> getDailyRecord(String date) async {
    //get db Path
    var pathDb = await _getPathDB();
    //open database
    var db = await openDatabase(pathDb);
    var queryResult = await db.query(
      'daily_record',
      where: 'date = ?',
      whereArgs: [date],
      limit: 1,
    );
    await db.close();
    if (queryResult.isNotEmpty) {
      return DailyRecordModel.fromJson(queryResult.first);
    } else {
      return DailyRecordModel(
          grateful: "",
          learned: "",
          appreciated: "",
          delighted: "",
          date: date,
          month: _getParsedDateMonth(date)
      );
    }
  }

  Future<String> _getPathDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "gladdb.db");

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);


         //print("write1");

         ByteData data = await rootBundle.load(url.join("assets", "gladdb.db"));
         List<int> bytes =
         data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);


        await File(path).writeAsBytes(bytes, flush: true);


      } catch (e) {
        print(e);
      }


      print("write2");
    } else {
      print("Opening existing database");
    }
    return path;
  }




}
