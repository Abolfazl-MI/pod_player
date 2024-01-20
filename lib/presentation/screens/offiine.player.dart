import 'dart:developer';
import 'dart:io';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pod_player/app/core/services/getit.dart';
import 'package:pod_player/presentation/blocs/player/player_controller.dart';

class OfflinePlayer extends StatefulWidget {
  const OfflinePlayer({super.key});

  @override
  State<OfflinePlayer> createState() => _OfflinePlayerState();
}

class _OfflinePlayerState extends State<OfflinePlayer> {
  File? file;
  bool isLoading = false;
  var drawerKey = GlobalKey<ScaffoldState>();
  var retriever = MetadataRetriever();
  Metadata? metaData;
  loadMeta(File inputFile) async {
    Metadata result = await MetadataRetriever.fromFile(inputFile);
    log(result.toString());
    setState(() {
      metaData = result;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        file = ModalRoute.of(context)!.settings.arguments as File;
        loadMeta(ModalRoute.of(context)!.settings.arguments as File);
      });
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text(file != null ? file!.path.split('/')[5].split('.')[0] : ''),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              )
            : Column(
                children: [
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: _playerWidget(),
                  )
                ],
              ));
  }

  _formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
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
                              // // player controller
                              // PlayerController playerController =
                              //     locator<PlayerController>();
                              // // current media item
                              // MediaItem currentMedia = playerController
                              //     .currentSongDetailNotifier.value;
                              // // finding index of it in playlist
                              // int currentIndex = playerController
                              //     .playlistNotifier.value
                              //     .indexOf(currentMedia);
                              // // getting the prviews media item to update ui base on
                              // MediaItem prviewsItem = playerController
                              //     .playlistNotifier.value[currentIndex - 1];
                              // playerController.onPreviousPressed();
                              // setState(() {
                              //   episode = Episode(
                              //       guid: prviewsItem.id,
                              //       title: prviewsItem.title,
                              //       description:
                              //           prviewsItem.displayDescription ?? '',
                              //       imageUrl: prviewsItem.extras!['imageUrl']);
                              // });
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
                              // // player controller
                              // PlayerController playerController =
                              //     locator<PlayerController>();
                              // // current media item
                              // MediaItem currentMedia = playerController
                              //     .currentSongDetailNotifier.value;
                              // // finding index of it in playlist
                              // int currentIndex = playerController
                              //     .playlistNotifier.value
                              //     .indexOf(currentMedia);
                              // // getting the prviews media item to update ui base on
                              // MediaItem prviewsItem = playerController
                              //     .playlistNotifier.value[currentIndex + 1];
                              // playerController.onPreviousPressed();
                              // setState(() {
                              //   episode = Episode(
                              //       guid: prviewsItem.id,
                              //       title: prviewsItem.title,
                              //       description:
                              //           prviewsItem.displayDescription ?? '',
                              //       imageUrl: prviewsItem.extras!['imageUrl']);
                              // });
                            },
                      icon: const Icon(Icons.skip_next, size: 40));
                }),
            IconButton(
              onPressed: () {
                Duration currentDuration =
                    locator<PlayerController>().progressNotifier.value.current;
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
              ),
            ),
          ],
        ),
        // SizedBox(height: ,)
      ],
    );
  }
}
