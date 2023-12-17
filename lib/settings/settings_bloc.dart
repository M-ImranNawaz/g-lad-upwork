import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/music_service/music_service.dart';

import '../legacy/preferences/shared_preferences.dart';

abstract class SettingsEvent {}

class OnLoadHomeEvent extends SettingsEvent {}

class PlayOrPauseMusicEvent extends SettingsEvent {
  late final bool data;
  PlayOrPauseMusicEvent(this.data);
}

class SavePlayOrPauseMusicEvent extends SettingsEvent {
  late final bool data;
  SavePlayOrPauseMusicEvent(this.data);
}

class SaveEnableReminderEvent extends SettingsEvent {
  late final bool data;
  SaveEnableReminderEvent(this.data);
}

abstract class SettingsState {}

class OnLoadSettingState extends SettingsState {}

class OnLoadPlayMusicState extends SettingsState {}

class OnEnableRemindersState extends SettingsState {}

class SettingBloc extends Bloc<SettingsEvent, bool> {
  late SharedPreferencesService _sharedPreferencesService;
  late MusicService _service;

  SettingBloc(
      MusicService service, SharedPreferencesService sharedPreferencesService)
      : super(false) {
    _service = service;
    _sharedPreferencesService = sharedPreferencesService;

    on<OnLoadHomeEvent>((event, emit) async {
      bool autoPlayMusic = bool.parse(
          await _sharedPreferencesService.readValue("play_music") ?? "false");

      emit(autoPlayMusic);
      // _service.openPlayer();
    });

    on<PlayOrPauseMusicEvent>((event, emit) async {
      _service.pauseOrPlayMusic();
      String saveValue = "false";
      if (event.data) {
        saveValue = "true";
      }
      await _sharedPreferencesService.saveValue("play_music", saveValue);
      emit(event.data);
    });

    
  }
}
