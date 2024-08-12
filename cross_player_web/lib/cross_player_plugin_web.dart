import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:cross_player_platform_interface/cross_player_platform_interface.dart';
import 'package:js/js.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'dart:async';
import 'package:cross_player_web/cross_player_js.dart' as cross_player_js;
import 'dart:ui_web' as ui_web;
import 'dart:js_util' as js_util;
const _divKey = "playerDiv";
const _videoKey = "playerVideo";

class CrossPlayerPluginWeb extends CrossPlayerPlatformInterface{

  static void registerWith(Registrar registrar) {
    CrossPlayerPlatformInterface.instance = CrossPlayerPluginWeb();
  }
  @override
  void printConsole(String msg) {
    cross_player_js.printConsole(msg);
  }

  @override
  Future<bool> create({required int viewId, Map<String, dynamic>? webOptions,}) async {
    var jsMap = js_util.newObject();
    if(webOptions!=null){
      webOptions.forEach((key, value) {
        js_util.setProperty(jsMap, key,value);
      },);
    }
    return await js_util.promiseToFuture<bool>(
        cross_player_js.create(
            "$_videoKey$viewId",jsMap
        )
    );
  }

  @override
  Future<void> setStreamUrl(int viewId, {required String uri, String? mimeType}) async{
    cross_player_js.setSrc("$_videoKey$viewId", uri, mimeType);
  }

  @override
  Future<void> dispose(int viewId) async{
    await cross_player_js.dispose("$_videoKey$viewId");
    html.Element? ele = html.querySelector("#$_divKey$viewId");
    if (html.querySelector("#$_divKey$viewId") != null) {
      ele!.remove();
    }
  }

  @override
  Future<void> stop(int viewId) async{
    return Future.value();
  }
  @override
  Future<void> play(int viewId) async{
    cross_player_js.play("$_videoKey$viewId");
  }
  @override
  Future<void> pause(int viewId) async{
    cross_player_js.pause("$_videoKey$viewId");
  }

  @override
  Future<bool?> isPlaying(int viewId) {
    final completer = Completer<bool>();
    cross_player_js.isPlaying("$_videoKey$viewId").then(
      // onResolve
      allowInterop((value) {
        completer.complete(value);
      }),
      // onReject
      allowInterop((error) {
        completer.completeError(error);
      }),
    );
    return completer.future;
  }

  @override
  Future<bool?> isPaused(int viewId) {
    final completer = Completer<bool>();
    cross_player_js.isPaused("$_videoKey$viewId").then(
      // onResolve
      allowInterop((value) {
        completer.complete(value);
      }),
      // onReject
      allowInterop((error) {
        completer.completeError(error);
      }),
    );
    return completer.future;
  }

  @override
  Future<Duration> getPosition(int viewId) {
    final completer = Completer<Duration>();
    cross_player_js.getDuration("$_videoKey$viewId").then(
      // onResolve
      allowInterop((value) {
        completer.complete(Duration(milliseconds: (value*1000).toInt()));
      }),
      // onReject
      allowInterop((error) {
        completer.completeError(error);
      }),
    );
    return completer.future;
  }
  @override
  Future<Duration> getTime(int viewId) {
    final completer = Completer<Duration>();
    cross_player_js.getTime("$_videoKey$viewId").then(
      // onResolve
      allowInterop((value) {
        completer.complete(Duration(milliseconds: (value*1000).toInt()));
      }),
      // onReject
      allowInterop((error) {
        completer.completeError(error);
      }),
    );
    return completer.future;
  }

  @override
  Future<int?> getVolume(int viewId) {
    final completer = Completer<int>();
    cross_player_js.getVolume("$_videoKey$viewId").then(
      // onResolve
      allowInterop((value) {
        var val = value*100.0;
        completer.complete(val.toInt());
      }),
      // onReject
      allowInterop((error) {
        completer.completeError(error);
      }),
    );
    return completer.future;
  }

  @override
  Future<Duration> getDuration(int viewId) {
    final completer = Completer<Duration>();
    cross_player_js.getDuration("$_videoKey$viewId").then(
      // onResolve
      allowInterop((value) {
        completer.complete(Duration(milliseconds: (value*1000).toInt()));
      }),
      // onReject
      allowInterop((error) {
        completer.completeError(error);
      }),
    );
    return completer.future;
  }

  @override
  Widget buildView(PlatformViewCreatedCallback onPlatformViewCreated, {bool virtualDisplay = false}) {

    if(virtualDisplay) {
      ui_web.platformViewRegistry.registerViewFactory(
          "CrossPlayerContentId", (int id) {
        final html.Element htmlElement = html.DivElement()
          ..id = "$_divKey$id"
          ..style.width = '100%'
          ..style.height = '100%'
          ..children = [
            html.AudioElement()
              ..id = "$_videoKey$id"
              ..style.minHeight = "100%"
              ..style.minHeight = "100%"
              ..style.width = "100%"
              ..style.height = "100%"
              ..className = "video-js vjs-default-skin"
            // ..attributes = {"poster":"http://localhost/DATA/FILM_1722695174882.png"}
            // html.ScriptElement()
            //   ..innerHtml = """
            //     CrossPlayer.create('$_videoKey$id');
            //   """
          ];

        return htmlElement;
      });
    }else{
      ui_web.platformViewRegistry.registerViewFactory(
          "CrossPlayerContentId", (int id) {
        final html.Element htmlElement = html.DivElement()
          ..id = "$_divKey$id"
          ..style.width = '100%'
          ..style.height = '100%'
          ..children = [
            html.VideoElement()
              ..id = "$_videoKey$id"
              ..style.minHeight = "100%"
              ..style.minHeight = "100%"
              ..style.width = "100%"
              ..style.height = "100%"
              ..className = "video-js vjs-default-skin"
            // ..attributes = {"poster":"http://localhost/DATA/FILM_1722695174882.png"}
            // html.ScriptElement()
            //   ..innerHtml = """
            //     CrossPlayer.create('$_videoKey$id');
            //   """
          ];

        return htmlElement;
      });

    }
    return HtmlElementView(
      viewType: "CrossPlayerContentId",
      onPlatformViewCreated: onPlatformViewCreated,
    );
  }
}