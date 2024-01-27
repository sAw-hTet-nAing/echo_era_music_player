import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:echo_era/core/utils/constants/app_dimesions.dart';
import 'package:echo_era/views/player_view/controls/controls.dart';
import 'package:echo_era/views/player_view/player_bloc/player_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import 'player_bloc/player_bloc.dart';
import 'player_bloc/player_event.dart';

class PlayerView extends StatefulWidget {
  const PlayerView({
    super.key,
  });

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        VideoPlayerController controller =
            context.watch<PlayerBloc>().videoPlayerController;
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          backgroundColor: Colors.black,
          body: Column(
            children: [
              const Spacer(),
              AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller)),
              ProgressBar(
                progress: state.progress,
                total: state.total,
                buffered: state.buffered,
                onSeek: (duration) => controller.seekTo(duration),
              ),
              const Spacer(),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ControlButtons(
                            onPressed: () {
                              controller.seekTo(controller.value.position +
                                  const Duration(seconds: 10));
                            },
                            icon: Icons.skip_previous_rounded),
                        ControlButtons(
                            onPressed: () {
                              controller.seekTo(controller.value.position -
                                  const Duration(seconds: 10));
                            },
                            icon: Icons.replay_10),
                        ControlButtons(
                          onPressed: () => context
                              .read<PlayerBloc>()
                              .add(const PlayerEventOnPlayPause()),
                          icon:
                              state.isPlaying ? Icons.pause : Icons.play_arrow,
                          size: AppDimesions.largeIconSize,
                        ),
                        ControlButtons(
                            onPressed: () {
                              controller.seekTo(controller.value.position +
                                  const Duration(seconds: 10));
                            },
                            icon: Icons.forward_10),
                        ControlButtons(
                            onPressed: () => context
                                .read<PlayerBloc>()
                                .add(const PlayerEventOnSkipForward()),
                            icon: Icons.skip_next_rounded)
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
