part of 'calendar_cubit.dart';

@immutable
sealed class CalendarState {}

final class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {}

class CalendarMonthDataLoaded extends CalendarState {
  final List<TodayModel> monthData;
  final DateTime selectedMonth;
  CalendarMonthDataLoaded(this.monthData, this.selectedMonth);
}

class CalendarFailure extends CalendarState {
  final String errorMessage;
  CalendarFailure(this.errorMessage);
}
