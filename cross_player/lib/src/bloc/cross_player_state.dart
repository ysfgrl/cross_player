part of 'cross_player_bloc.dart';



class CrossPlayerState extends Equatable{

  final bool autoInitialize;
  final bool autoPlay;
  final int viewId;
  final PlayerState playerState;
  final PlayingState playingState;
  final DataSource? media;
  final Map<String, dynamic>? webOptions;

  final Duration duration;
  final Duration position;
  final int volume;
  final double bufferPercent;
  final double playbackSpeed;

  const CrossPlayerState({
    this.playerState = PlayerState.init,
    this.playingState = PlayingState.init,
    this.viewId = -1,
    this.autoPlay = true,
    this.autoInitialize = true,
    this.media,
    this.webOptions,

    this.duration = Duration.zero,
    this.position = Duration.zero,
    this.bufferPercent = 0.0,
    this.volume = 100,
    this.playbackSpeed = 1.0,
  });

  CrossPlayerState copyWith({
    PlayerState? playerState,
    PlayingState? playingState,
    int? viewId,
    DataSource? media,
    Map<String, dynamic>? webOptions,
    bool? autoPlay,
    bool? autoInitialize,
    Duration? duration,
    Duration? position,
    int? volume,
    double? bufferPercent,
    double? playbackSpeed,
  }) {
    return CrossPlayerState(
      playerState: playerState ?? this.playerState,
      playingState: playingState ?? this.playingState,
      viewId: viewId ?? this.viewId,
      media: media?? this.media,
      webOptions: webOptions?? this.webOptions,
      autoPlay: autoPlay?? this.autoPlay,
      autoInitialize: autoInitialize?? this.autoInitialize,
      duration: duration?? this.duration,
      position: position?? this.position,
      bufferPercent: bufferPercent?? this.bufferPercent,
      playbackSpeed: playbackSpeed?? this.playbackSpeed,
    );
  }

  
  @override
  List<Object> get props => [playerState, playingState];
}
