import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/music_service/music_service.dart';

import '../preferences/shared_preferences.dart';

abstract class HelpEvent {}

class OnLoadHelpEvent extends HelpEvent {}

class PlayOrPauseMusicEvent extends HelpEvent {}

abstract class HelpState {}

class OnLoadHelpState extends HelpState {}

class HelpBloc extends Bloc<HelpEvent, HelpState> {
  late MusicService _service;
  late SharedPreferencesService _sharedPreferencesService;
  HelpBloc(
      MusicService service, SharedPreferencesService sharedPreferencesService)
      : super(OnLoadHelpState()) {
    _service = service;
    _sharedPreferencesService = sharedPreferencesService;

    on<OnLoadHelpEvent>((event, emit) async {
      // _service.openPlayer();
      //
      // _service.isReadyToPlay().listen((event) async {
      //   // bool autoPlayMusic = bool.parse(
      //   //     await _sharedPreferencesService.readValue("play_music") ?? "false");
      //   //
      //   // if (autoPlayMusic) {
      //   //   add(PlayOrPauseMusicEvent());
      //   // }
      // });
    });

    on<PlayOrPauseMusicEvent>((event, emit) async {
      //_service.pauseOrPlayMusic();
    });
  }
}
