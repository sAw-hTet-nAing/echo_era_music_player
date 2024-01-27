import 'package:equatable/equatable.dart';

class PlayerState extends Equatable {
  final PlayerPageState pageState;
  final Duration progress;
  final Duration total;
  final bool isPlaying;
  final Duration? buffered;
  final int index;

  const PlayerState(
    this.pageState,
    this.progress,
    this.total,
    this.isPlaying,
    this.buffered,
    this.index,
  );

  const PlayerState.initial()
      : this(
          PlayerPageState.initial,
          const Duration(),
          const Duration(),
          true,
          const Duration(),
          0,
        );

  PlayerState copyWith({
    PlayerPageState? pageState,
    Duration? progress,
    Duration? total,
    bool? isPlaying,
    Duration? buffered,
    int? index,
  }) {
    return PlayerState(
      pageState ?? this.pageState,
      progress ?? this.progress,
      total ?? this.total,
      isPlaying ?? this.isPlaying,
      buffered ?? this.buffered,
      index ?? this.index,
    );
  }

  @override
  List<Object> get props => [
        progress,
        total,
        isPlaying,
        buffered ?? const Duration(),
        index,
      ];
}

enum PlayerPageState { initial, loading, loaded, error }
