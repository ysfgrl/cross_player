
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:cross_player_platform_interface/src/message_channel_cross_player.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class CrossPlayerPlatformInterface extends PlatformInterface{

  static final Object _token = Object();
  CrossPlayerPlatformInterface(): super(token: _token);
  static CrossPlayerPlatformInterface _instance = MessageChannelCrossPlayer();

  static CrossPlayerPlatformInterface get instance => _instance;

  static set instance(CrossPlayerPlatformInterface instance){
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  void printConsole(String msg){
    throw UnimplementedError('printConsole has not been implemented.');
  }

  Future<void> init() {
    throw _unimplemented('init');
  }
  Future<void> dispose(int viewId ) {

    throw _unimplemented('dispose');
  }

  Widget buildView(PlatformViewCreatedCallback onPlatformViewCreated,
  {bool virtualDisplay = true}) {
    throw _unimplemented('buildView');
  }
  
  Future<bool> create({
    required int viewId,
    Map<String, dynamic>? webOptions,
  }) {
    throw _unimplemented('create');
  }
  Future<void> setStreamUrl(int viewId, {required String uri, String? mimeType}) {
    throw _unimplemented('setStreamUrl');
  }
  Future<void> play(int viewId) {
    throw _unimplemented('play');
  }

  Future<void> pause(int viewId) {
    throw _unimplemented('pause');
  }
  Future<void> stop(int viewId) {
    throw _unimplemented('stop');
  }
  Future<void> setLooping(int viewId, bool looping) {
    throw _unimplemented('setLooping');
  }

  Future<bool?> isPlaying(int viewId) {
    throw _unimplemented('isPlaying');
  }
  Future<bool?> isPaused(int viewId) {
    throw _unimplemented('isPaused');
  }
  Future<bool?> isSeekable(int viewId) {
    throw _unimplemented('isSeekable');
  }
  Future<void> setTime(int viewId, Duration position) {
    throw _unimplemented('setTime');
  }
  Future<void> seekTo(int viewId, Duration position) {
    throw _unimplemented('seekTo');
  }
  Future<Duration> getTime(int viewId) {
    throw _unimplemented('getTime');
  }
  Future<Duration> getPosition(int viewId) {
    throw _unimplemented('getPosition');
  }
  Future<Duration> getDuration(int viewId) {
    throw _unimplemented('getDuration');
  }
  Future<void> setVolume(int viewId, int volume) {
    throw _unimplemented('setVolume');
  }
  Future<int?> getVolume(int viewId) {
    throw _unimplemented('getVolume');
  }

  Future<Uint8List> takeSnapshot(int viewId) {
    throw _unimplemented('takeSnapshot');
  }

  Future<void> setVideoAspectRatio(int viewId, String aspect) {
    throw _unimplemented('setVideoAspectRatio');
  }
  Future<String?> getVideoAspectRatio(int viewId) {
    throw _unimplemented('getVideoAspectRatio');
  }

  Future<int?> getAudioTracksCount(int viewId) {
    throw _unimplemented('getAudioTracksCount');
  }
  Future<Map<int, String>> getAudioTracks(int viewId) {
    throw _unimplemented('getAudioTracks');
  }
  Future<void> setAudioTrack(int viewId, int audioTrackNumber) {
    throw _unimplemented('setAudioTrack');
  }

  Future<void> setAudioDelay(int viewId, int delay) {
    throw _unimplemented('setAudioDelay');
  }

  Future<int?> getAudioDelay(int viewId) {
    throw _unimplemented('getAudioDelay');
  }

  Future<int?> getAudioTrack(int viewId) {
    throw _unimplemented('getAudioTrack');
  }
  Future<int?> getSpuTracksCount(int viewId) {
    throw _unimplemented('getSpuTracksCount');
  }
  Future<Map<int, String>> getSpuTracks(int viewId) {
    throw _unimplemented('getSpuTracks');
  }
  Future<void> setSpuTrack(int viewId, int spuTrackNumber) {
    throw _unimplemented('setSpuTrack');
  }
  Future<int?> getSpuTrack(int viewId) {
    throw _unimplemented('getSpuTrack');
  }
  Future<void> setSpuDelay(int viewId, int delay) {
    throw _unimplemented('setSpuDelay');
  }
  Future<int?> getSpuDelay(int viewId) {
    throw _unimplemented('getSpuDelay');
  }

  Object _unimplemented(String methodName) {
    return UnimplementedError('$methodName has not been implemented.');
  }
}