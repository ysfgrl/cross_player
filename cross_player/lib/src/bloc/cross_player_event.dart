part of 'cross_player_bloc.dart';

abstract class CrossPlayerEvent extends Equatable{
  const CrossPlayerEvent();
  @override
  List<Object> get props => [];
}

final class CrossPlayerSetInitEvent extends CrossPlayerEvent{
  const CrossPlayerSetInitEvent();
  @override
  List<Object> get props => [];
}

final class CrossPlayerSetViewIdEvent extends CrossPlayerEvent{
  final int id;
  const CrossPlayerSetViewIdEvent(this.id);
  @override
  List<Object> get props => [id];
}

final class CrossPlayerSetMediaEvent extends CrossPlayerEvent{
  final DataSource media;
  final bool play;
  const CrossPlayerSetMediaEvent(this.media, this.play);
  @override
  List<Object> get props => [media, play];
}
final class CrossPlayerPlayEvent extends CrossPlayerEvent{
  const CrossPlayerPlayEvent();
  @override
  List<Object> get props => [];
}
final class CrossPlayerPauseEvent extends CrossPlayerEvent{
  const CrossPlayerPauseEvent();
  @override
  List<Object> get props => [];
}