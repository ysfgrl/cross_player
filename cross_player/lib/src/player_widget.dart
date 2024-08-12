import 'dart:math';

import 'package:cross_player/src/player_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cross_player/src/bloc/cross_player_bloc.dart';

class CrossPlayerWidget extends StatefulWidget {
  final PlayerController controller;
  final double? height;
  final double? width;
  const CrossPlayerWidget({super.key,
    required this.controller,
    this.height,
    this.width
  });

  @override
  VideoJsWidgetState createState() => VideoJsWidgetState();
}

class VideoJsWidgetState extends State<CrossPlayerWidget> with AutomaticKeepAliveClientMixin  {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  void didUpdateWidget(CrossPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      // _isInitialized = widget.controller.value.isInitialized;
    }
  }
  @override
  void deactivate() {
    super.deactivate();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: widget.width ?? constraints.maxWidth ,
          height:  widget.height ?? constraints.maxWidth * 9 / 16,
          child: BlocConsumer<CrossPlayerBloc, CrossPlayerState>(
            bloc: widget.controller.bloc,
            builder: (context, state) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: widget.controller.bloc.buildView((id) {
                      widget.controller.bloc.add(CrossPlayerSetViewIdEvent(id));
                    }, audioView: widget.controller.audioView),
                  ),
                  // Positioned.fill(
                  //   child: CrossPlayerControls(controller: widget.controller),
                  // )
                ],
              );
            },
            listener: (context, state) {
              widget.controller.playingStream.sink.add(Random().nextInt(100));
            },
            listenWhen: (previous, current) => true,
          ),
        );
      },
    );
  }
  @override
  bool get wantKeepAlive => true;
}
