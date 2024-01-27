import 'package:echo_era/views/player_view/player_bloc/player_event.dart';
import 'package:echo_era/views/player_view/player_bloc/player_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  late VideoPlayerController videoPlayerController;

  PlayerBloc(List<String> videoUrl, int index)
      : super(const PlayerState.initial()) {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl[index]));
    videoPlayerController.initialize().then((_) {
      videoPlayerController.play();
      videoPlayerController.addListener(() {
        add(PlayerEventOnStart(
          progress: videoPlayerController.value.position,
          total: videoPlayerController.value.duration,
          isPlaying: videoPlayerController.value.isPlaying,
          buffered: videoPlayerController.value.buffered.isEmpty
              ? null
              : videoPlayerController.value.buffered.last.end,
          index: index,
        ));
      });

      on<PlayerEventOnStart>((event, emit) => emit(state.copyWith(
            pageState: PlayerPageState.loaded,
            progress: event.progress,
            total: event.total,
            isPlaying: event.isPlaying,
            buffered: event.buffered,
            index: event.index,
          )));

      on<PlayerEventOnPlayPause>((event, emit) {
        if (videoPlayerController.value.isPlaying) {
          videoPlayerController.pause();
        } else {
          videoPlayerController.play();
        }
        emit(state.copyWith(
          isPlaying: videoPlayerController.value.isPlaying,
        ));
      });
    });
    on<PlayerEventOnSkipForward>((event, emit) {
      if (state.index < videoUrl.length - 1) {
        int currentIndex = (state.index + 1) % videoUrl.length;

        videoPlayerController.dispose();
        videoPlayerController =
            VideoPlayerController.networkUrl(Uri.parse(videoUrl[currentIndex]));

        if (videoPlayerController.value.hasError) {
          emit(state.copyWith(index: currentIndex + 1));

          add(const PlayerEventOnSkipForward());
        } else {
          videoPlayerController.initialize().then((_) {
            videoPlayerController.play();
            videoPlayerController.addListener(() {
              add(PlayerEventOnStart(
                progress: videoPlayerController.value.position,
                total: videoPlayerController.value.duration,
                isPlaying: videoPlayerController.value.isPlaying,
                buffered: videoPlayerController.value.buffered.isEmpty
                    ? null
                    : videoPlayerController.value.buffered.last.end,
                index: currentIndex,
              ));
            });
          });
        }
      }
    });

    on<PlayerEventOnSkipPrevious>((event, emit) {
      if (state.index > 0) {
        int currentIndex = (state.index - 1) % videoUrl.length;

        videoPlayerController.dispose();
        videoPlayerController =
            VideoPlayerController.networkUrl(Uri.parse(videoUrl[currentIndex]));
        videoPlayerController.initialize().then((_) {
          videoPlayerController.play();
          videoPlayerController.addListener(() {
            add(PlayerEventOnStart(
              progress: videoPlayerController.value.position,
              total: videoPlayerController.value.duration,
              isPlaying: videoPlayerController.value.isPlaying,
              buffered: videoPlayerController.value.buffered.isEmpty
                  ? null
                  : videoPlayerController.value.buffered.last.end,
              index: currentIndex,
            ));
          });
        });
      }
    });
  }
  @override
  Future<void> close() {
    videoPlayerController.dispose();
    return super.close();
  }
}
