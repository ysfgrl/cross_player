

import 'dart:async';

import 'package:cross_player/src/player_source.dart';
import 'package:cross_player/src/bloc/cross_player_bloc.dart';

class PlayerController{
  final StreamController<int> playingStream = StreamController<int>();
  PlayerController({
    bool autoInitialize = true,
    bool autoPlay = true,
    DataSource? media,
    this.audioView = true,
    Map<String, dynamic>? webOptions,
  }):_bloc = CrossPlayerBloc(CrossPlayerState(
    autoInitialize: autoInitialize,
    autoPlay: autoPlay,
    media: media,
    webOptions: webOptions
  ));

  final bool audioView;
  final CrossPlayerBloc _bloc;
  CrossPlayerBloc get bloc => _bloc;


  void dispose() async{
    await _bloc.dispose();
  }
  void setMedia(DataSource media){
    _bloc.add(CrossPlayerSetMediaEvent(media, true));
  }

  CrossPlayerState get value => bloc.state;

}