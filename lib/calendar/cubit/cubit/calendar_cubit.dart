import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/today/model/today_model.dart';
import 'package:intl/intl.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarLoading());

  // Future<void> fetchMonthData(DateTime month) async {
  //   emit(CalendarLoading());
  //   try {
  //     String monthFormatted =
  //         "${month.year}-${month.month.toString().padLeft(2, '0')}";
  //     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //         .collection('todayData')
  //         .where('date', isGreaterThanOrEqualTo: '$monthFormatted-01')
  //         .where('date', isLessThan: '$monthFormatted-31')
  //         .get();

  //     List<TodayModel> monthData = querySnapshot.docs
  //         .map((doc) => TodayModel.fromMap(doc.data() as Map<String, dynamic>))
  //         .toList();
  //     // for (var i = 0; i < monthData.length; i++) {
  //     //   print('date: ${DateTime.parse(monthData[i].date).day} ');
  //     // }
  //     emit(CalendarMonthDataLoaded(monthData, month));
  //   } catch (e) {
  //     emit(CalendarFailure(e.toString()));
  //   }
  // }
  Future<void> fetchMonthData(DateTime month) async {
    emit(CalendarLoading());
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        emit(CalendarFailure("User not logged in"));
        return;
      }

      String monthFormatted = "${month.year}-${month.month.toString().padLeft(2, '0')}";
      CollectionReference userTodayCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('todayData');

      QuerySnapshot querySnapshot = await userTodayCollection
          .where('date', isGreaterThanOrEqualTo: '$monthFormatted-01')
          .where('date', isLessThan: '$monthFormatted-31')
          .get();

      List<TodayModel> monthData = querySnapshot.docs
          .map((doc) => TodayModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      emit(CalendarMonthDataLoaded(monthData, month));
    } catch (e) {
      emit(CalendarFailure(e.toString()));
    }
  }
  bool isDataExistOn(List<TodayModel> monthData, DateTime date) {
    return monthData.any((data) {
      DateTime dataDate = DateFormat('yyyy-MM-dd').parse(data.date);
      String formattedDataDate = DateFormat('yyyy-MM-dd').format(dataDate);
      String formattedCalendarDate = DateFormat('yyyy-MM-dd').format(date);
      return formattedDataDate == formattedCalendarDate;
    });
  }

  TodayModel? getTodayModelByDate(
      List<TodayModel> monthData, DateTime targetDate) {
    String formattedTargetDate = DateFormat('yyyy-MM-dd').format(targetDate);

    try {
      return monthData.firstWhere((todayModel) {
        return DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(todayModel.date)) ==
            formattedTargetDate;
      });
    } catch (e) {
      return null;
    }
  }
}
