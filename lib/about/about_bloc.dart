import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/music_service/music_service.dart';

import '../preferences/shared_preferences.dart';

abstract class AboutEvent {}

class OnLoadHelpEvent extends AboutEvent {}

class PlayOrPauseMusicEvent extends AboutEvent {}

abstract class AboutState {}

class OnLoadAboutState extends AboutState {}

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  late MusicService _service;
  late SharedPreferencesService _sharedPreferencesService;
  AboutBloc(
      MusicService service, SharedPreferencesService sharedPreferencesService)
      : super(OnLoadAboutState()) {
    _service = service;
    _sharedPreferencesService = sharedPreferencesService;

    on<OnLoadHelpEvent>((event, emit) async {
      _service.openPlayer();

      _service.isReadyToPlay().listen((event) async {
        bool autoPlayMusic = bool.parse(
            await _sharedPreferencesService.readValue("play_music") ?? "false");

        if (autoPlayMusic) {
          add(PlayOrPauseMusicEvent());
        }
      });
    });

    on<PlayOrPauseMusicEvent>((event, emit) async {
      _service.pauseOrPlayMusic();
    });
  }
}
