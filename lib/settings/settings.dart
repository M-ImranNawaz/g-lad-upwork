import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:glad/app_router.dart';
import 'package:glad/components/app_text_field.dart';
import 'package:glad/legacy/preferences/shared_preferences.dart';
import 'package:glad/settings/cubit/delete_account_cubit.dart';
import 'package:glad/settings/settings_bloc.dart';
import 'package:glad/utils/app_utls.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../legacy/notification_manager/notification_manager.dart';
import '../music_service/music_service.dart';

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

  String convertDateTimeToTime(DateTime dateTime) {
    var finalTime = DateFormat.jm().format(dateTime);

    return finalTime;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      myColor = Theme.of(context).colorScheme.primary;
      _storage = const FlutterSecureStorage();
      setEnableReminderSetting();
    });
  }

  void setEnableReminderSetting() async {
    var enableReminderString = await _storage.read(key: "enableReminder");

    var enableReminder = false;

    switch (enableReminderString) {
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
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[];
          },
          body: Material(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text("Sounds",
                          style: GoogleFonts.inter(
                            fontSize: 31,
                            fontWeight: FontWeight.w400,
                          )),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Meditation Sounds",
                        style: GoogleFonts.actor(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          height: 1.2575,
                        ),
                      ),
                      Switch(
                        value: state,
                        onChanged: (value) =>
                            BlocProvider.of<SettingBloc>(context)
                                .add(PlayOrPauseMusicEvent(value)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text("Notification",
                          style: GoogleFonts.inter(
                            fontSize: 31,
                            fontWeight: FontWeight.w400,
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Enable reminder notification",
                        style: GoogleFonts.actor(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          height: 1.2575,
                        ),
                      ),
                      Switch(
                          value: showReminderNotificationButton,
                          onChanged: (value) async {
                            if (!showReminderNotificationButton) {
                              await NotificationService()
                                  .cancelAllNotifications();
                            }

                            switch (value) {
                              case true:
                                await _storage.write(
                                    key: "enableReminder", value: "true");
                              case false:
                                await _storage.write(
                                    key: "enableReminder", value: "false");
                            }

                            var enableReminderString =
                                await _storage.read(key: "enableReminder");

                            setState(() {
                              showReminderNotificationButton = value;
                            });
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: showReminderNotificationButton,
                    child: SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          minimumSize: const Size.fromHeight(40),
                          backgroundColor:
                              MediaQuery.of(context).platformBrightness ==
                                      Brightness.dark
                                  ? Colors.deepPurpleAccent
                                  : Colors.black,
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
                          }, onConfirm: (date) {
                            setState(() {
                              if (showReminderNotificationButton) {
                                scheduledTimeString =
                                    "Your reminder notification will show daily at ${convertDateTimeToTime(scheduleTime)}";
                              } else {
                                scheduledTimeString = "";
                              }
                            });

                            NotificationService().scheduleNotification(
                                title: 'glad',
                                body: 'Time to add your record in glad',
                                scheduledNotificationDateTime: scheduleTime);
                          },
                              currentTime: DateTime.now()
                                  .add(const Duration(minutes: 1)),
                              locale: LocaleType.en);
                        },
                        child: const Text(
                          "Set Reminder notification",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                      visible: showReminderNotificationButton,
                      child: Text(scheduledTimeString)),
                  const SizedBox(height: 48),
                  SizedBox(
                    width: double.infinity, // <-- match_parent

                    child: BlocListener<DeleteAccountCubit, DeleteAccountState>(
                      listener: (context, state) {
                        if (state is DeleteAccountLoading) {
                          AppUtils.showLoading(context);
                        } else if (state is DeleteAccountSuccess) {
                          AppUtils.hideLoading(context);
                          AppUtils.showSuccessSnackBar(
                              context, 'Accounts deleted successfully');
                          context.go(Routes.loginRoute);
                        } else if (state is DeleteAccountFailure) {
                          AppUtils.hideLoading(context);
                          AppUtils.showErrorSnackBar(context, state.error);
                        } else if (state is DeleteAccountValidFailure) {
                          AppUtils.showErrorSnackBar(context, state.error);
                        }
                      },
                      child: TextButton(
                          onPressed: () => showDeleteConfirmationDialog(
                              context), //=>context.read<SettingBloc>().add(dele),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                          child: const Text(
                            "Delete Account",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                    ),
                    // ),
                  )
                ],
              ),
            ),
          ),
        ));
      }),
    );
  }

  void showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Account"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text(
                  "Are you sure you want to delete your account? This action cannot be undone. Please enter your password to confirm.",
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  controller: context.read<DeleteAccountCubit>().passwordC,
                  iconData: Icons.lock_outlined,
                  hintText: 'Password',
                  isPasswordField: true,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                context.pop();
              },
            ),
            TextButton(
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
              onPressed: () {
                context.pop();
                // String password = passwordController.text;
                // if (password.isNotEmpty) {
                //   Navigator.of(context).pop();
                // Here you can integrate re-authentication logic with the provided password
                // And then call deleteAccount from the DeleteAccountCubit
                context.read<DeleteAccountCubit>().deleteAccount();
                // } else {
                // Optionally show an error message or prompt for password
                // }
              },
            ),
          ],
        );
      },
    );
  }
}
