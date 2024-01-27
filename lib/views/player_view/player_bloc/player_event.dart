import 'package:echo_era/views/player_view/player_bloc/player_state.dart';

abstract class PlayerEvent {
  const PlayerEvent();
}

class PlayerEventOnStart extends PlayerEvent {
  final Duration progress;
  final Duration total;
  final bool isPlaying;
  final Duration? buffered;
  final int index;

  const PlayerEventOnStart({
    required this.progress,
    required this.total,
    required this.isPlaying,
    this.buffered,
    required this.index,
  });
}

class PlayerEventOnPlayPause extends PlayerEvent {
  const PlayerEventOnPlayPause();
}

class PlayerEventOnSeek extends PlayerEvent {
  final Duration progress;
  final Duration total;

  const PlayerEventOnSeek({
    required this.progress,
    required this.total,
  });
}

class PlayerEventOnEnd extends PlayerEvent {
  const PlayerEventOnEnd();
}

class PlayerEventOnError extends PlayerEvent {
  const PlayerEventOnError();
}

class PlayerEventOnFullScreen extends PlayerEvent {
  final bool isFullScreen;

  const PlayerEventOnFullScreen({
    required this.isFullScreen,
  });
}

class PlayerEventOnSkipPrevious extends PlayerEvent {
  const PlayerEventOnSkipPrevious();
}

class PlayerEventOnSkipForward extends PlayerEvent {
  const PlayerEventOnSkipForward();
}
