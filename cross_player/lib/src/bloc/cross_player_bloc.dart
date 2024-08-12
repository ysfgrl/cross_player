
import 'dart:async';
import 'package:cross_player/src/enum/player_state.dart';
import 'package:cross_player/src/enum/playing_state.dart';
import 'package:cross_player/src/player_source.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cross_player_platform_interface/cross_player_platform_interface.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

part 'cross_player_event.dart';
part 'cross_player_state.dart';

@visibleForTesting
var fPlayerPlatformInstance = CrossPlayerPlatformInterface.instance;

class CrossPlayerBloc extends Bloc<CrossPlayerEvent,CrossPlayerState> {


  CrossPlayerBloc(super.state){
    on<CrossPlayerSetViewIdEvent>(_setViewId);
    on<CrossPlayerSetInitEvent>(_init);
    on<CrossPlayerSetMediaEvent>(_setMedia);
    on<CrossPlayerPlayEvent>(_play);
    on<CrossPlayerPauseEvent>(_pause);
  }

  Future<bool?> isPlaying() async {
    return await fPlayerPlatformInstance.isPlaying(state.viewId);
  }
  void _setViewId(CrossPlayerSetViewIdEvent event, Emitter<CrossPlayerState> emitter) async{
    emitter(state.copyWith(
      viewId: event.id,
      playerState: PlayerState.readyToInitialize,
    ));
    Future.delayed(Duration(milliseconds: 500), () => add(const CrossPlayerSetInitEvent()),);
  }
  void _init(CrossPlayerSetInitEvent event, Emitter<CrossPlayerState> emitter)async{
    if(state.playerState == PlayerState.readyToInitialize) {
      emitter(state.copyWith(
          playerState: PlayerState.initializing
      ));
    }
    if(state.playerState == PlayerState.readyToInitialize ||
        state.playerState == PlayerState.initializing) {
      if (await fPlayerPlatformInstance.create(
          viewId: state.viewId,
          webOptions: state.webOptions
      )) {
        emitter(state.copyWith(
            playerState: PlayerState.initialized
        ));
        if (state.media != null) {
          add(CrossPlayerSetMediaEvent(state.media!, state.autoPlay));
        }
      } else {
        debugPrint("Create Error");
        // add(const CrossPlayerSetInitEvent());
      }
    }
  }
  void _setMedia(CrossPlayerSetMediaEvent event, Emitter<CrossPlayerState> emitter) async{
    await fPlayerPlatformInstance.stop(state.viewId);
    await fPlayerPlatformInstance.setStreamUrl(
      state.viewId,
      uri: event.media.source,
      mimeType: event.media.mimeType,
    );
    emitter(state.copyWith(
      playingState: PlayingState.init,
    ));
    if(state.autoPlay || event.play){
      add(const CrossPlayerPlayEvent());
    }
  }
  void _play(CrossPlayerPlayEvent event, Emitter<CrossPlayerState> emitter) async{
    if(state.playingState!=PlayingState.playing && state.playerState==PlayerState.initialized){
      await fPlayerPlatformInstance.play(state.viewId);
      emitter(state.copyWith(
        playingState: PlayingState.playing,
      ));

    }
  }
  void _pause(CrossPlayerPauseEvent event, Emitter<CrossPlayerState> emitter) async{
    if(state.playingState!=PlayingState.paused && state.playerState==PlayerState.initialized){
      await fPlayerPlatformInstance.pause(state.viewId);
      emitter(state.copyWith(
          playingState: PlayingState.paused,
      ));

    }
  }
  Widget buildView(PlatformViewCreatedCallback onPlatformViewCreated, {bool audioView = false}) {
    return fPlayerPlatformInstance.buildView(onPlatformViewCreated, virtualDisplay: audioView);
  }

  Future<void> dispose() async {
    return fPlayerPlatformInstance.dispose(state.viewId);
  }

  Future<void> printConsole() async {
    fPlayerPlatformInstance.printConsole("test message");
  }
  // Future<bool?> isPlaying() async {
  //   return await fPlayerPlatformInstance.isPlaying(state.viewId);
  // }
  Future<bool?> isPaused() async {
    return await fPlayerPlatformInstance.isPaused(state.viewId);
  }
  Future<Duration?> getTime() async {
    return await fPlayerPlatformInstance.getTime(state.viewId);
  }
  Future<Duration?> getDuration() async {
    return await fPlayerPlatformInstance.getDuration(state.viewId);
  }
  Future<int?> getVolume() async {
    return await fPlayerPlatformInstance.getVolume(state.viewId);
  }


}
