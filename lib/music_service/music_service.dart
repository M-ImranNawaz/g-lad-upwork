import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:rxdart/src/streams/value_stream.dart';

class MusicService{
  late AssetsAudioPlayer _assetsAudioPlayer;
  final List<StreamSubscription> _subscriptions = [];
  late final _audios = <Audio>[
    Audio("assets/a.mp3"),
    Audio("assets/b.mp3"),
    Audio("assets/c.mp3")
  ];


  MusicService(){
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

    _subscriptions.add(_assetsAudioPlayer.playlistAudioFinished.listen((data) {
      print('playlistAudioFinished : $data');
    }));
    _subscriptions.add(_assetsAudioPlayer.audioSessionId.listen((sessionId) {
      print('audioSessionId : $sessionId');
    }));

    _subscriptions.add(_assetsAudioPlayer.onReadyToPlay.listen((event) {
         print("event: $event");
    }));
    //_openPlayer();
  }


  Stream isReadyToPlay (){
    return _assetsAudioPlayer.onReadyToPlay;
  }

  void openPlayer() async{
    await _assetsAudioPlayer.open(
      Playlist(audios: _audios, startIndex: 0),
      showNotification: false,
      autoStart: false,
    );
  }



  void pauseOrPlayMusic() async{

    await _assetsAudioPlayer.playOrPause();
  }

  Future<ValueStream<bool>> isAudioPlaying() async {
     return _assetsAudioPlayer.isPlaying;
  }

}