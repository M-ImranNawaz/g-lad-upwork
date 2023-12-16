import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/src/streams/value_stream.dart';
import '/music_service/music_service.dart';
import '../preferences/shared_preferences.dart';

abstract class HomeEvent {}
class OnLoadHomeEvent extends HomeEvent{}
class PlayOrPauseMusicEvent extends HomeEvent{}

abstract class HomeState {}
class OnLoadHomeState extends HomeState{}

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  late MusicService _service;
  late SharedPreferencesService _sharedPreferencesService;
  HomeBloc(MusicService service,SharedPreferencesService sharedPreferencesService) :super(OnLoadHomeState()) {
       _service = service;
       _sharedPreferencesService = sharedPreferencesService;

       on<OnLoadHomeEvent>((event, emit) async {

         ValueStream<bool> isAudioPlaying =  await _service.isAudioPlaying();


            if(!isAudioPlaying.value){
              _service.openPlayer();
              _service.isReadyToPlay().listen((event) async {

                bool autoPlayMusic = bool.parse(await _sharedPreferencesService.readValue("play_music") ?? "false");

                if(autoPlayMusic){
                  add(PlayOrPauseMusicEvent());
                }

              });
            }


       });

       on<PlayOrPauseMusicEvent>((event, emit) async{
            _service.pauseOrPlayMusic();
       });
  }

}