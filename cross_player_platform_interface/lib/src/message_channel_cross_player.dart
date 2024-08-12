
import 'package:cross_player_platform_interface/cross_player_platform_interface.dart';
import 'package:cross_player_platform_interface/src/messages.g.dart';

class MessageChannelCrossPlayer extends CrossPlayerPlatformInterface{

  final _api = CrossPlayerApi();

  @override
  void printConsole(String msg) {
    _api.test(msg);
  }
}