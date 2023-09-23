import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/app_router.dart';
import 'package:glad/components/app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../blocs/main_bloc.dart';
import '../blocs/main_event.dart';
import '../blocs/main_state.dart';
import '../models/daily_record_model.dart';
import '../utils/contants.dart';
import '../widget/custom_textfield.dart';

class RecordEntryDailyPage extends StatefulWidget {
  final String date;
  const RecordEntryDailyPage({super.key, required this.date});

  @override
  // ignore: library_private_types_in_public_api
  _RecordEntryDailyPage createState() => _RecordEntryDailyPage();
}

class _RecordEntryDailyPage extends State<RecordEntryDailyPage> {
  String dateNow = "";
  int days = 0;
  bool isBack = true;

  TextEditingController etGrateful = TextEditingController();
  TextEditingController etLearned = TextEditingController();
  TextEditingController etAppreciated = TextEditingController();
  TextEditingController etDelighted = TextEditingController();
  late MainBloc mainBloc;
  DailyRecordModel? dailyRecordModel;

  @override
  void initState() {
    super.initState();
    mainBloc = BlocProvider.of<MainBloc>(context);
    DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MMMM d, y');
    dateNow = formatter.format(now);
    String formattedSearchDate = DateFormat('yyyy-MM-dd').format(now);

    isBack = false;
    if(widget.date.isNotEmpty){
      
      days = now.difference(DateTime.parse(widget.date)).inDays;
      mainBloc.add(GetDailyDataEvent(date: widget.date));
      dateNow = formatter.format(DateTime.parse(widget.date));

    }
    else{
      mainBloc.add(GetDailyDataEvent(date: formattedSearchDate));
    }



  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _save();
        isBack = true;
        mainBloc.add(SaveDailyDataEvent(data: dailyRecordModel!));

        return true;
      },
      child: CupertinoPageScaffold(


        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
            return <Widget>[
              const GladAppBar(titleOfPage: "Daily Records")
            ];
          },
          body: SingleChildScrollView(
            child: BlocListener<MainBloc, MainState>(
              listener: (context, state) {
                _listener(context, state);
              },
              child: Container(
                width: 100.w,
                height: 95.h,

                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                child: Column(
                  children: [

                    SizedBox(
                      width: 100.w,
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              width: 70.w,
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.h, horizontal: 3.w),
                              child: Text(
                                dateNow,
                                style: TextStyle(fontSize: 13.sp),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0.5.h,
                            child: InkWell(
                              onTap: () {
                                _moveLeft();
                              },
                              child: Icon(
                                Icons.arrow_circle_left,
                                size: 8.w,
                              ),
                            ),
                          ),
                          Visibility(
                              visible: days > 0,
                              child: Positioned(
                                right: 0,
                                top: 0.5.h,
                                child: InkWell(
                                  onTap: () {
                                    _moveRight();
                                  },
                                  child: Icon(
                                    Icons.arrow_circle_right,
                                    size: 8.w,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    CustomTextField(
                      title: Constants.GRATEFULTITLE,
                      hint: Constants.GRATEFULHINT,
                      controller: etGrateful,
                      enabled: days < 2,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    CustomTextField(
                      title: Constants.LEARNEDTITLE,
                      hint: Constants.LEARNEDHINT,
                      controller: etLearned,
                      enabled: days < 2,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    CustomTextField(
                      title: Constants.APPRECIATEDTITLE,
                      hint: Constants.APPRECIATEDHINT,
                      controller: etAppreciated,
                      enabled: days < 2,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    CustomTextField(
                      title: Constants.DELIGHTEDTITLE,
                      hint: Constants.DELIGHTEDHINT,
                      controller: etDelighted,
                      enabled: days < 2,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Visibility(
                        child: TextButton(
                          onPressed: () {
                            _save();

                            mainBloc.add(SaveDailyDataEvent(data: dailyRecordModel!));
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.2.h, horizontal: 16.w),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                  color: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.white : Colors.black,
                                  width: 1.0),
                            ),
                          ),
                          child: Text(
                            'SAVE',
                            style: TextStyle(fontSize: 13.sp,
                                color:  MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.white: Colors.black),
                          ),
                        )),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _moveLeft() {
    days++;
    // _save();
    // mainBloc
    //     .add(SaveDailyDataEvent(data: dailyRecordModel!));
    _changeDay();
  }

  void _moveRight() {
    days--;
    // _save();
    // mainBloc
    //     .add(SaveDailyDataEvent(data: dailyRecordModel!));
    _changeDay();
  }

  void _listener(BuildContext context, MainState state) {
    if (state is DailyRecordDataState) {
      if (state.data != null) {
        dailyRecordModel = state.data!;
        etDelighted.text = dailyRecordModel?.delighted ?? "";
        etAppreciated.text = dailyRecordModel?.appreciated ?? "";
        etLearned.text = dailyRecordModel?.learned ?? "";
        etGrateful.text = dailyRecordModel?.grateful ?? "";
        FocusScope.of(context).unfocus();
        setState(() {});
      }
      if (state.message != null) {

        if(!isBack){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message!),
              duration: const Duration(seconds: 1),
            ),
          );
        }



      }
    }
  }

  void _save() {
    DateTime parsedDate = DateFormat('MMMM d, y').parse(dateNow);
    // print(dateNow);
    String isoFormattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
    dailyRecordModel = DailyRecordModel(
        grateful: etGrateful.text,
        learned: etLearned.text,
        appreciated: etAppreciated.text,
        delighted: etDelighted.text,
        date: isoFormattedDate,
        month: parsedDate.month);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _changeDay() {
    dailyRecordModel = null;
    DateTime now = DateTime.now();
    DateTime oneDayAgo = now.subtract(Duration(days: days));

    final DateFormat formatter = DateFormat('MMMM d, y');
    dateNow = formatter.format(oneDayAgo);
    String formattedSearchDate = DateFormat('yyyy-MM-dd').format(oneDayAgo);
    mainBloc.add(GetDailyDataEvent(date: formattedSearchDate));
    setState(() {});
  }
}
