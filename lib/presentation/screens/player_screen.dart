import 'dart:developer';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pod_player/app/config/router/route_names.dart';
import 'package:pod_player/app/core/services/getit.dart';
import 'package:pod_player/data/models/downloaded_episode/downloaded_episode_model.dart';
import 'package:pod_player/domain/repositories/download/download_episode_repository.dart';
import 'package:pod_player/presentation/blocs/download_cubit/downloader.state.dart';
import 'package:pod_player/presentation/blocs/download_cubit/downloader_cubit.dart';
import 'package:pod_player/presentation/blocs/player/player_controller.dart';
import 'package:pod_player/presentation/widgets/cached_image.dart';

import 'package:podcast_search/podcast_search.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool _showFullText = false;
  Episode? episode;
  bool hasDownloadedBefore =
      false; // boolean to indicate that has episode downloaded before or not
  _formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

// "/storage/emulated/0/podPlayer/day_016_(genesis_1215)__year_6.mp3"
  _checkDownloadState() {
    String podcastName = (episode!.title.replaceAll(' ', '')) + '.mp3';
    Directory appDir = Directory("/storage/emulated/0/podPlayer");
    if (appDir.existsSync()) {
      List<String> filesNames = appDir.listSync().map((e) {
        String fullPath = e.path;
        String fileName = fullPath.split('/')[5].toString();
        return fileName;
      }).toList();
      log('Files  names in folder =>$filesNames');
      log('Episode current file name =>$podcastName');
      bool contains = filesNames.contains(podcastName);
      setState(() {
        hasDownloadedBefore = contains;
      });
    } else {
      return;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // print(ModalRoute.of(context)!.settings.arguments.toString());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        episode = ModalRoute.of(context)!.settings.arguments as Episode;
      });
      _checkDownloadState();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        DownloaderState downloaderState = context.read<DownloaderCubit>().state;
        if (downloaderState is DownloaderLoading) {
          log('DOWNLOADING SHIT! WHERE ARE YOU GOING???');
          _showCancleDownloadDialog(context);
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(episode?.title ?? ''),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_drop_down_sharp,
              size: 40,
            ),
            onPressed: () {
              DownloaderState downloaderState =
                  context.read<DownloaderCubit>().state;
              if (downloaderState is DownloaderLoading) {
                _showCancleDownloadDialog(context);
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
          actions: [
            hasDownloadedBefore
                ? const Icon(Icons.download_done_rounded)
                : BlocConsumer<DownloaderCubit, DownloaderState>(
                    listener: (context, state) {
                      if (state is DownloaderFail) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is DownloaderLoading) {
                        return const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        );
                      }
                      if (state is DownloaderFail) {
                        return const Icon(Icons.file_download_off_outlined);
                      }
                      if (state is DownloaderSuccess) {
                        return const Icon(Icons.download_done_rounded);
                      }
                      return IconButton(
                        onPressed: () async {
                          String fileName =
                              "${episode!.title.replaceAll(' ', '')}.mp3";
                          DownloadEpisodeModel data = DownloadEpisodeModel(
                              id: episode!.guid,
                              downloadLink: episode!.contentUrl!,
                              fileName: fileName,
                              episodeTitle: episode?.title ?? '');
                          await context
                              .read<DownloaderCubit>()
                              .downloadEpisode(data);
                        },
                        icon: const Icon(
                          Icons.file_download_rounded,
                        ),
                      );
                    },
                  ),
            const SizedBox(
              width: 10,
            )
          ],
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
                        CachedImage(
                          width: size.width * 0.7,
                          height: size.width * 0.7,
                          imageUrl: episode?.imageUrl ?? '',
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        //TODO DESCRIPTION LENGTH SHOULD CHECK AND LOGICAL
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.1),
                          child: Html(
                            data: episode?.description ?? '',
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: _playerWidget())
          ],
        ),
      ),
    );
  }

  Future<void> _showCancleDownloadDialog(BuildContext mainContext) {
    return showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => DownloaderCubit(
            downloadEpisodeRepository: locator<DownloadEpisodeRepository>()),
        child: AlertDialog(
          title: const Text('Alert!'),
          content:
              const Text('The download would be cancled if you leave the page'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('GetBack'),
            ),
            TextButton(
              onPressed: () {
                mainContext.read<DownloaderCubit>().cancelDownload();
                Navigator.of(context).popUntil(
                    (route) => route.settings.name == RouteNames.podcastSingle);
              },
              child: Text(
                'Leave',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.red),
              ),
            ),
          ],
        ),
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
