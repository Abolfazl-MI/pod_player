import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pod_player/app/core/services/getit.dart';
import 'package:pod_player/presentation/blocs/player/player_controller.dart';
import 'package:podcast_search/podcast_search.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool _showFullText = false;
  Episode? episode;

  _formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        episode = ModalRoute.of(context)!.settings.arguments as Episode;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(episode?.title ?? ''),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_drop_down_sharp,
            size: 40,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              // color: Colors.green,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: size.width * 0.7,
                        height: size.width * 0.7,
                        // color: Colors.yellow,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(episode!.imageUrl!))),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      //TODO DESCRIPTION LENGTH SHOULD CHECK AND LOGICAL
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.1),
                        child: Html(
                          data: episode!.description,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Visibility(
                        visible: ((episode?.description.length ?? 0) > 420),
                        child: InkWell(
                          onTap: () {
                            print(episode!.description.length);
                            setState(() {
                              _showFullText = !_showFullText;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(12)),
                            // width:150,
                            // height: 50,
                            // color: Colors.orange,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.info_outline),
                                Text(_showFullText ? 'show less' : 'show more'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          // SizedBox(height: 20,),
          Container(
              width: size.width,
              height: size.height * 0.17,
              // color: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: _playerWidget())
        ],
      ),
    );
  }

  _playerWidget() {
    return Column(
      children: [
        ValueListenableBuilder(
            valueListenable: locator<PlayerController>().progressNotifier,
            builder: (context, progressBarState, child) {
              return Column(
                children: [
                  ProgressBar(
                      progress: progressBarState.current,
                      total: progressBarState.total,
                      buffered: progressBarState.buffered,
                      thumbColor: Theme.of(context).primaryColor,
                      progressBarColor: Colors.redAccent,
                      baseBarColor: Colors.grey.withOpacity(0.7),
                      bufferedBarColor: Colors.redAccent.withOpacity(0.5),
                      thumbGlowColor: Colors.redAccent.withOpacity(0.25),
                      timeLabelTextStyle:
                          const TextStyle(color: Colors.white, fontSize: 16)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_formattedTime(
                                timeInSecond:
                                    progressBarState.current.inSeconds) ??
                            '00:00'),
                        Text(_formattedTime(
                                timeInSecond:
                                    progressBarState.total.inSeconds) ??
                            '00:00'),
                      ],
                    ),
                  ),
                ],
              );
            }),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  Duration currentDuration = locator<PlayerController>()
                      .progressNotifier
                      .value
                      .current;
                  Duration total =
                      locator<PlayerController>().progressNotifier.value.total;
                  Duration tenSecondBefore =
                      currentDuration - const Duration(seconds: 10);
                  if (tenSecondBefore.inSeconds > 0 &&
                      tenSecondBefore < currentDuration) {
                    locator<PlayerController>().seek(tenSecondBefore);
                  }
                },
                icon: const Icon(
                  Icons.fast_rewind,
                  size: 40,
                )),
            ValueListenableBuilder(
                valueListenable:
                    locator<PlayerController>().isFirstSongNotifier,
                builder: (context, isFirstSong, child) {
                  return IconButton(
                      onPressed: isFirstSong
                          ? null
                          : () {
                              // player controller
                              PlayerController playerController =
                                  locator<PlayerController>();
                              // current media item
                              MediaItem currentMedia = playerController
                                  .currentSongDetailNotifier.value;
                              // finding index of it in playlist
                              int currentIndex = playerController
                                  .playlistNotifier.value
                                  .indexOf(currentMedia);
                              // getting the prviews media item to update ui base on
                              MediaItem prviewsItem = playerController
                                  .playlistNotifier.value[currentIndex - 1];
                              playerController.onPreviousPressed();
                              setState(() {
                                episode = Episode(
                                    guid: prviewsItem.id,
                                    title: prviewsItem.title,
                                    description:
                                        prviewsItem.displayDescription ?? '',
                                    imageUrl: prviewsItem.extras!['imageUrl']);
                              });
                            },
                      icon: const Icon(
                        Icons.skip_previous,
                        size: 40,
                      ));
                }),
            ValueListenableBuilder(
              valueListenable: locator<PlayerController>().buttonNotifier,
              builder: (context, value, child) {
                return value == ButtonState.loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          if (value == ButtonState.playing) {
                            locator<PlayerController>().pause();
                          } else {
                            locator<PlayerController>().play();
                          }
                        },
                        icon: value == ButtonState.playing
                            ? const Icon(
                                Icons.pause,
                                size: 40,
                              )
                            : const Icon(
                                Icons.play_arrow,
                                size: 40,
                              ),
                      );
              },
            ),
            ValueListenableBuilder(
                valueListenable: locator<PlayerController>().isLastSongNotifier,
                builder: (context, isLastSong, child) {
                  return IconButton(
                      onPressed: isLastSong
                          ? null
                          : () {
                              // player controller
                              PlayerController playerController =
                                  locator<PlayerController>();
                              // current media item
                              MediaItem currentMedia = playerController
                                  .currentSongDetailNotifier.value;
                              // finding index of it in playlist
                              int currentIndex = playerController
                                  .playlistNotifier.value
                                  .indexOf(currentMedia);
                              // getting the prviews media item to update ui base on
                              MediaItem prviewsItem = playerController
                                  .playlistNotifier.value[currentIndex + 1];
                              playerController.onPreviousPressed();
                              setState(() {
                                episode = Episode(
                                    guid: prviewsItem.id,
                                    title: prviewsItem.title,
                                    description:
                                        prviewsItem.displayDescription ?? '',
                                    imageUrl: prviewsItem.extras!['imageUrl']);
                              });
                            },
                      icon: const Icon(Icons.skip_next, size: 40));
                }),
            IconButton(
                onPressed: () {
                  Duration currentDuration = locator<PlayerController>()
                      .progressNotifier
                      .value
                      .current;
                  Duration total =
                      locator<PlayerController>().progressNotifier.value.total;
                  Duration tenSecondLater =
                      currentDuration + const Duration(seconds: 10);
                  if (currentDuration < total) {
                    locator<PlayerController>().seek(tenSecondLater);
                  }
                },
                icon: const Icon(
                  Icons.fast_forward,
                  size: 40,
                )),
          ],
        ),
        // SizedBox(height: ,)
      ],
    );
  }
}
