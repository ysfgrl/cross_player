@JS()
library firebase.es6_interop;

import 'package:cross_player_web/func.dart';
import 'package:js/js.dart';

@JS('Promise')
class PromiseJsImpl<T> {
  external PromiseJsImpl(Function resolver);
  external PromiseJsImpl then([Func1? onResolve, Func1? onReject]);
}
