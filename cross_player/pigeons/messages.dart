import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: '../cross_player_platform_interface/lib/src/messages.g.dart',
  dartTestOut: '../cross_player_platform_interface/test/messages.g.dart',
))
@HostApi(dartHostTestHandler: 'TestCrossPlayerApi')
abstract class CrossPlayerApi {
  void test(String msg);
}
