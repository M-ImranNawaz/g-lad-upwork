import 'dart:async';


//import 'package:assets_audio_player_web/assets_audio_player_web.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:rxdart/src/streams/value_stream.dart';

class MusicService{
  late AssetsAudioPlayer _assetsAudioPlayer;
  final List<StreamSubscription> _subscriptions = [];
  late final _audios = <Audio>[
    Audio.network(
      'https://files.freemusicarchive.org/storage-freemusicarchive-org/music/Music_for_Video/springtide/Sounds_strange_weird_but_unmistakably_romantic_Vol1/springtide_-_03_-_We_Are_Heading_to_the_East.mp3',
      metas: Metas(
        id: 'Online',
        title: 'Online',
        artist: 'Florent Champigny',
        album: 'OnlineAlbum',
        // image: MetasImage.network('https://www.google.com')
        image: MetasImage.network(
            'https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg'),
      ),
    ),
    Audio("assets/a.mp3",metas: Metas()),
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