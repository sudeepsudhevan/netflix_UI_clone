import 'dart:math';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/domain/downloads/models/downloads.dart';
import 'package:video_player/video_player.dart';
import 'package:share_plus/share_plus.dart';

class VideoListItemInheritedWidget extends InheritedWidget {
  //final Widget widget;
  final Downloads moviedata;

  const VideoListItemInheritedWidget(
      {required super.child, required this.moviedata, super.key});

  @override
  bool updateShouldNotify(covariant VideoListItemInheritedWidget oldWidget) {
    return moviedata != oldWidget.moviedata;
  }

  static VideoListItemInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VideoListItemInheritedWidget>();
  }
}

class VideoListItem extends StatelessWidget {
  final int index;
  const VideoListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final posterPath =
        VideoListItemInheritedWidget.of(context)?.moviedata.posterPath;
    final videoUrl = dummyvideoUrls[index % (dummyvideoUrls.length)];
    return Stack(
      children: [
        FastLaughVideoPlayer(
          videoUrl: videoUrl,
          onStateChanged: (bool) {},
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // left side
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black.withOpacity(0.7),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.volume_off,
                      size: 30,
                    ),
                  ),
                ),
                // right side
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: posterPath == null
                            ? null
                            : NetworkImage('$imageAppendUrl$posterPath'),
                      ),
                    ),
                    ValueListenableBuilder(
                        valueListenable: likedVideosIdsNotifier,
                        builder: (BuildContext c, Set<int> newLikedListIds,
                            Widget? _) {
                          final _index = index;
                          if (newLikedListIds.contains(_index)) {
                            return GestureDetector(
                              onTap: () {
                                likedVideosIdsNotifier.value.remove(_index);
                                likedVideosIdsNotifier.notifyListeners();
                              },
                              child: const VideoActionsWidget(
                                icon: Icons.favorite_outline,
                                title: 'Liked',
                              ),
                            );
                          }
                          return GestureDetector(
                            onTap: () {
                              likedVideosIdsNotifier.value.add(_index);
                              likedVideosIdsNotifier.notifyListeners();
                            },
                            child: const VideoActionsWidget(
                                icon: Icons.emoji_emotions, title: 'LOL'),
                          );
                        }),
                    const VideoActionsWidget(icon: Icons.add, title: 'My List'),
                    GestureDetector(
                      onTap: () {
                        final movieName =
                            VideoListItemInheritedWidget.of(context)
                                ?.moviedata
                                .title;
                        if (movieName != null) {
                          Share.share(movieName);
                        }
                      },
                      child: const VideoActionsWidget(
                        icon: Icons.share,
                        title: 'Share',
                      ),
                    ),
                    const VideoActionsWidget(
                        icon: Icons.play_arrow, title: 'Play')
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class VideoActionsWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const VideoActionsWidget(
      {super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Column(
        children: [
          Icon(
            icon,
            size: 30,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              //fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class FastLaughVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final void Function(bool isPlaying) onStateChanged;
  const FastLaughVideoPlayer(
      {super.key, required this.videoUrl, required this.onStateChanged});

  @override
  State<FastLaughVideoPlayer> createState() => _FastLaughVideoPlayerState();
}

class _FastLaughVideoPlayerState extends State<FastLaughVideoPlayer> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));

    _videoPlayerController.initialize().then((value) {
      setState(() {});
      _videoPlayerController.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: _videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }
}
