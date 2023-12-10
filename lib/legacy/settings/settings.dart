import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:glad/legacy/components/app_bar.dart';
import 'package:glad/main.dart';
import 'package:glad/legacy/preferences/shared_preferences.dart';
import 'package:glad/legacy/settings/settings_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../app/app.dart';
import '../music_service/music_service.dart';
import '../notification_manager/notification_manager.dart';

class TimeHHmmPickerModel extends TimePickerModel {
  TimeHHmmPickerModel(DateTime initialTime, LocaleType localType)
      : super(currentTime: initialTime, locale: localType);

  @override
  String rightDivider() => "";

  @override
  List<int> layoutProportions() => [100, 100, 1];
}


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  late final FlutterSecureStorage _storage;

  //late SharedPreferencesService _sharedPreferencesService;
  String scheduledTimeString = "";
  bool isSwitched = false;
  bool showReminderNotificationButton = false;
  DateTime scheduleTime = DateTime.now().add(const Duration(minutes: 1));
  
  
  late Color myColor;


  String convertDateTimeToTime (DateTime dateTime){

    var finalTime = DateFormat.jm().format(dateTime);

    return finalTime;
  }


  @override
  void initState() {

    super.initState();


    
    WidgetsBinding.instance.addPostFrameCallback((_){
        myColor = Theme.of(context).colorScheme.primary;
        _storage =  const FlutterSecureStorage();
        setEnableReminderSetting();
    });
  }

  void setEnableReminderSetting() async {
      var enableReminderString = await _storage.read(key: "enableReminder");

      var enableReminder = false;

      switch (enableReminderString){
        case "true":
              enableReminder = true;
              break;

        case "false":
              enableReminder = false;
              break;

      }

      setState(() {
         showReminderNotificationButton = enableReminder;
      });

  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => SettingBloc(
                RepositoryProvider.of<MusicService>(context),
                RepositoryProvider.of<SharedPreferencesService>(context))
              ..add(OnLoadHomeEvent())),
      ],
      child: BlocBuilder<SettingBloc, bool>(builder: (context, state) {
        return CupertinoPageScaffold(
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
              return <Widget>[
                const GladAppBar(titleOfPage: "Settings")
              ];
            },
            body: Material(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50,),
                     Row(
                      children: [

                        Text("Sounds",
                            style: GoogleFonts.actor(
                              fontSize: 31,
                              fontWeight:  FontWeight.w400,
                              height:  1.2575,

                            )),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Meditation Sounds", style: GoogleFonts.actor(
                          fontSize:  20,
                          fontWeight:  FontWeight.w400,
                          height:  1.2575,

                        ),),
                        Switch(
                          value: state,
                          onChanged: (value) =>
                              BlocProvider.of<SettingBloc>(context)
                                  .add(PlayOrPauseMusicEvent(value)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Text("Notification",
                            style: GoogleFonts.actor(
                              fontSize: 31,
                              fontWeight:  FontWeight.w400,
                              height:  1.2575,

                            )
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Enable reminder notification", style: GoogleFonts.actor(
                          fontSize:  20,
                          fontWeight:  FontWeight.w400,
                          height:  1.2575,

                        ),),
                        Switch(
                          value: showReminderNotificationButton,
                          onChanged: (value) async{
                               if(!showReminderNotificationButton){
                                  await NotificationService().cancelAllNotifications();
                                }

                               switch (value){
                                 case true:
                                   await _storage.write(key: "enableReminder", value:"true");
                                 case false:
                                   await _storage.write(key: "enableReminder", value:"false");
                               }

                               var enableReminderString = await _storage.read(key: "enableReminder");


                                setState(()  {
                                   showReminderNotificationButton = value;
                                });
                          }
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Visibility(
                      visible: showReminderNotificationButton,
                      child: SizedBox(
                        width: 300,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                            minimumSize: const Size.fromHeight(40),
                            backgroundColor: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.deepPurpleAccent : Colors.black,
                            elevation: 0,
                          ),
                          onPressed: () {


                            DatePicker.showTime12hPicker(context,

                                showTitleActions: true,
                                // minTime: DateTime.now(),
                                // maxTime: DateTime(2030, 6, 7),
                                onChanged: (date) {

                                  setState(() {
                                    scheduleTime = date;
                                  });

                                },
                                onConfirm: (date) {

                                   setState(() {
                                     if(showReminderNotificationButton){
                                        scheduledTimeString = "Your reminder notification will show daily at ${convertDateTimeToTime(scheduleTime)}";
                                     }
                                     else{
                                       scheduledTimeString = "";
                                     }

                                   });


                                   NotificationService().scheduleNotification(
                                        title: 'glad',
                                        body: 'Time to add your record in glad',
                                        scheduledNotificationDateTime: scheduleTime
                                   );
                                },

                                currentTime: DateTime.now().add(const Duration(minutes: 1)),

                                locale: LocaleType.en);
                          },
                          child: const Text(
                            "Set Reminder notification",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Visibility(
                      visible:  showReminderNotificationButton,
                        child: Text("$scheduledTimeString")
                    ),
                    const SizedBox(height: 12),
                    Visibility(
                      visible: false,
                      child: Row(
                        children: [
                          Text("Styles",
                              style: GoogleFonts.actor(
                                fontSize: 31,
                                fontWeight:  FontWeight.w400,
                                height:  1.2575,

                              )),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: false,
                      child: Column(
                        children: [

                          GestureDetector(
                            onTap: (){
                              appThemeColor.sink.add(Colors.deepPurpleAccent);

                            },
                            child: Container(
                              height: 44,
                              decoration:  BoxDecoration (
                                borderRadius:  BorderRadius.circular(50),
                                gradient:  const LinearGradient (
                                  begin:  Alignment(0, -1),
                                  end:  Alignment(0, 1),
                                  colors:  <Color>[Color(0xb27145c1), Color(0xff7145c1)],
                                  stops:  <double>[0, 1],
                                ),
                                boxShadow:  const [
                                  BoxShadow(
                                    color:  Color(0x3f000000),
                                    offset:  Offset(0, 4),
                                    blurRadius:  2,
                                  ),
                                ],
                              ),
                              child: Center(

                                child: Text("Original", style: GoogleFonts.actor(
                                  fontSize:  18.5963916779,
                                  fontWeight:  FontWeight.w400,
                                  height:  1.2575,
                                  color:  Color(0xffffffff),
                                ),),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: (){
                              appThemeColor.sink.add(myColor);

                            },
                            child: Container(
                              height: 44,
                              decoration:  BoxDecoration (
                                borderRadius:  BorderRadius.circular(50),
                                gradient:  const LinearGradient (
                                  begin:  Alignment(0, -1),
                                  end:  Alignment(0, 1),
                                  colors:  <Color>[Color(0xb2eb0e0e), Color(0xccf9ff00), Color(0xe500fdfd), Color(0xff05ff00)],
                                  stops:  <double>[0, 0.347, 0.68, 1],
                                ),
                                boxShadow:  const [
                                  BoxShadow(
                                    color:  Color(0x3f000000),
                                    offset:  Offset(0, 4),
                                    blurRadius:  2,
                                  ),
                                ],
                              ),
                              child: Center(

                                child: Text("Rainbow", style: GoogleFonts.actor(
                                  fontSize:  18.5963916779,
                                  fontWeight:  FontWeight.w400,
                                  height:  1.2575,
                                  color: Colors.black,
                                ),),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: (){
                              appThemeColor.sink.add(Colors.pinkAccent);

                            },
                            child: Container(
                              height: 44,
                              decoration:  BoxDecoration (
                                borderRadius:  BorderRadius.circular(50),
                                gradient:  const LinearGradient (
                                  begin:  Alignment(0, -1),
                                  end:  Alignment(0, 1),
                                  colors:  <Color>[Color(0xb2ff00c6), Color(0xffff00c7)],
                                  stops:  <double>[0, 1],
                                ),
                                boxShadow:  const [
                                  BoxShadow(
                                    color:  Color(0x3f000000),
                                    offset:  Offset(0, 4),
                                    blurRadius:  2,
                                  ),
                                ],
                              ),
                              child: Center(

                                child: Text("Pink", style: GoogleFonts.actor(
                                  fontSize:  18.5963916779,
                                  fontWeight:  FontWeight.w400,
                                  height:  1.2575,
                                  color: Colors.white,
                                ),),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                appThemeColor.sink.add(Colors.blue);

                              },
                              child: Container(
                                height: 44,
                                decoration:  BoxDecoration (
                                  borderRadius:  BorderRadius.circular(50),
                                  gradient:  const LinearGradient (
                                    begin:  Alignment(0, -1),
                                    end:  Alignment(0, 1),
                                    colors:  <Color>[Color(0xb20093ff), Color(0xff0094ff)],
                                    stops:  <double>[0, 1],
                                  ),
                                  boxShadow:  const [
                                    BoxShadow(
                                      color:  Color(0x3f000000),
                                      offset:  Offset(0, 4),
                                      blurRadius:  2,
                                    ),
                                  ],
                                ),

                                child: Center(

                                  child: Text("Blue", style: GoogleFonts.actor(
                                    fontSize:  18.5963916779,
                                    fontWeight:  FontWeight.w400,
                                    height:  1.2575,
                                    color: Colors.white,
                                  ),),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Flexible(child:  GestureDetector(
                            onTap: (){

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                    return AlertDialog(
                                      title: const Text('Pick a color!'),
                                      content: SingleChildScrollView(
                                        child: ColorPicker(
                                          pickerColor: myColor, //default color

                                          onColorChanged: (Color color){ //on color picked
                                            setState(() {
                                              myColor = color;

                                            });
                                          },
                                        ),
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: const Text('DONE'),
                                          onPressed: () {
                                            appThemeColor.sink.add(myColor);

                                            Navigator.of(context).pop();



                                          },
                                        ),
                                      ],
                                    );
                                  }
                              );






                            },
                            child: Container(
                              height: 44,
                              decoration:  BoxDecoration (
                                borderRadius:  BorderRadius.circular(50),
                                gradient:  const LinearGradient (
                                  begin:  Alignment(0, -1),
                                  end:  Alignment(0, 1),
                                  colors:  <Color>[Color(0xb2000000), Color(0xff000000)],
                                  stops:  <double>[0, 1],
                                ),
                                boxShadow:  const [
                                  BoxShadow(
                                    color:  Color(0x3f000000),
                                    offset:  Offset(0, 4),
                                    blurRadius:  2,
                                  ),
                                ],
                              ),
                              child: Center(

                                child: Text("Custom", style: GoogleFonts.actor(
                                  fontSize:  18.5963916779,
                                  fontWeight:  FontWeight.w400,
                                  height:  1.2575,
                                  color: Colors.white,
                                ),),
                              ),
                            ),
                          )),

                          const SizedBox(
                            height: 20,
                          ),

                        ],
                      ),
                    ),
                    const SizedBox(height: 35),



                  ],
                ),
              ),
            ),
          ));


      }),
    );
  }
}
