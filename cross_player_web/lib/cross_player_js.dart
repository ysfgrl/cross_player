@JS('CrossPlayer')
library cross_player.js;
import 'package:js/js.dart';
import 'package:cross_player_web/promise.dart';

external void printConsole(String msg);
external PromiseJsImpl<bool> isInit(String videoId);
external PromiseJsImpl<bool> create(String videoId, dynamic options);
external PromiseJsImpl<void> setSrc(String videoId, String url, String? mimeType);
external PromiseJsImpl<void> play(String videoId);
external PromiseJsImpl<void> pause(String videoId);
external PromiseJsImpl<void> dispose(String videoId);

external PromiseJsImpl<void> setLooping(String videoId, bool looping);
external PromiseJsImpl<bool> isPlaying(String videoId);
external PromiseJsImpl<bool> isPaused(String videoId);
external PromiseJsImpl<bool> isSeekable(String videoId);
external PromiseJsImpl<double> getTime(String videoId);
external PromiseJsImpl<double> getDuration(String videoId);
external PromiseJsImpl<double> getVolume(String videoId);
