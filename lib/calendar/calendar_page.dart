import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/calendar/cubit/cubit/calendar_cubit.dart';
import 'package:glad/today/model/today_model.dart';
import 'package:glad/utils/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<CalendarCubit>(
        create: (context) => CalendarCubit()..fetchMonthData(DateTime.now()),
        child: BlocBuilder<CalendarCubit, CalendarState>(
          builder: (context, state) {
            if (state is CalendarLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CalendarMonthDataLoaded) {
              return TableCalendar(
                focusedDay: state.selectedMonth,
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                calendarFormat: CalendarFormat.month,
                onPageChanged: (focusedDay) {
                  print('page changed $focusedDay');
                  context.read<CalendarCubit>().fetchMonthData(focusedDay);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  final todayModel = context
                      .read<CalendarCubit>()
                      .getTodayModelByDate(state.monthData, selectedDay);
                  print('today model $todayModel');
                  if (todayModel != null) {
                    showTodayModelDialog(context, todayModel);
                  }
                },
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    if (context
                        .read<CalendarCubit>()
                        .isDataExistOn(state.monthData, date)) {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.headingColor,
                          ),
                          width: 7,
                          height: 7,
                          margin: const EdgeInsets.only(bottom: 10),
                        ),
                      );
                    }
                    return null;
                  },
                ),
              );
            } else if (state is CalendarFailure) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            }
            return const Center(child: Text('Please select a month'));
          },
        ),
      ),
    );
  }

  void showTodayModelDialog(BuildContext context, TodayModel todayModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text(
            "Details",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.headingColor, // Customize as needed
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                _buildDetailRow("Grateful for", todayModel.grateful),
                _buildDetailRow("Learned", todayModel.learned),
                _buildDetailRow("Appreciated", todayModel.appreciated),
                _buildDetailRow("Delighted by", todayModel.delighted),
                // _buildDetailRow("Date", todayModel.date),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.white,
                backgroundColor: AppColors.headingColor,
              ),
              child: const Text("Close"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 16, color: AppColors.black),
          children: <TextSpan>[
            TextSpan(
                text: "$label: ",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
