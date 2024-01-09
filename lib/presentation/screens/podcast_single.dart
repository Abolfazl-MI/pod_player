import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pod_player/app/config/router/route_names.dart';
import 'package:pod_player/app/core/services/getit.dart';
import 'package:pod_player/data/models/downloaded_episode/downloaded_episode_model.dart';
import 'package:pod_player/domain/entities/single_podcast/single_podcast_entity.dart';
import 'package:pod_player/presentation/blocs/download_cubit/downloader.state.dart';
import 'package:pod_player/presentation/blocs/download_cubit/downloader_cubit.dart';
import 'package:pod_player/presentation/blocs/player/player_controller.dart';
import 'package:pod_player/presentation/blocs/podcast_single/single_podcast_bloc.dart';
import 'package:pod_player/presentation/widgets/draggableSheet.dart';
import 'package:podcast_search/podcast_search.dart';

class PodcastSingleScreen extends StatefulWidget {
  const PodcastSingleScreen({Key? key}) : super(key: key);

  @override
  State<PodcastSingleScreen> createState() => _PodcastSingleScreenState();
}

class _PodcastSingleScreenState extends State<PodcastSingleScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SinglePodcastBloc>().add(LoadPodcastFromFeed(
          ModalRoute.of(context)!.settings.arguments as String));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SinglePodcastBloc, SinglePodcastState>(
      builder: (context, state) {
        return Scaffold(
            bottomNavigationBar: ValueListenableBuilder(
              valueListenable: locator<PlayerController>().playState,
              builder: (context, value, child) {
                if (!value) {
                  return SizedBox.shrink();
                } else {
                  return PlayerBottemSheet();
                }
              },
            )
            // state is SinglePodLoaded
            //     ? ValueListenableBuilder(
            //         valueListenable: locator<PlayerController>().buttonNotifier,
            //         builder: (context, value, child) {
            //            switch(value){
            //             case ButtonState.loading:
            //               return PlayerBottemSheet(singlePodcastEntity: singlePodcastEntity);
            //               case ButtonState.
            //           };
            //         },
            //       )
            //     :
            ,
            appBar: state is SinglePodLoaded
                ? AppBar(
                    title: Text(state.singlePodcastEntity.podcastName ?? ''),
                  )
                : null,
            body:
                _handleBodyState(state, MediaQuery.of(context).size, context));
      },
    );
  }

  _handleBodyState(SinglePodcastState state, Size size, BuildContext context) {
    return SizedBox(
        width: size.width,
        height: size.height,
        child: state is SinglePodLoadingState
            ? _loadingState(size)
            : state is SinglePodError
                ? _failedToLoadState(state.error)
                : state is SinglePodLoaded
                    ? _body(size, state, context)
                    : Container());
  }

  _loadingState(Size size) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.red,
      ),
    );
  }

  _failedToLoadState(String error) {
    return Center(
      child: Text(error),
    );
  }

  _body(Size size, SinglePodLoaded state, BuildContext context) {
    SinglePodcastEntity singlePodcastEntity = state.singlePodcastEntity;
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                width: size.width,
                height: size.height * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      singlePodcastEntity.image!,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(singlePodcastEntity.image!),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: size.width * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(singlePodcastEntity.podcastName ?? '',
                                  maxLines: 12),
                              Text(singlePodcastEntity.artistName ?? '',
                                  maxLines: 12),
                              Visibility(
                                visible:
                                    singlePodcastEntity.releaseDate != null,
                                child: Text(
                                    '${singlePodcastEntity.releaseDate?.year ?? ''}/${singlePodcastEntity.releaseDate?.month}${singlePodcastEntity.releaseDate?.day}'),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Html(
                  data: singlePodcastEntity.description,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                Episode episode = state.singlePodcastEntity.episodes![index];
                return Card(
                  child: ListTile(
                    subtitle: BlocBuilder<DownloaderCubit, DownloaderState>(
                      builder: (context, state) {
                        if (state is DownloaderLoading &&
                            state.id == episode.guid) {
                          return const LinearProgressIndicator(
                            color: Colors.red,
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                    title: Text(episode.title),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.play_arrow),
                          onPressed: () {
                            // debugPrint(singlePodcastEntity.episodes.toString());
                            List<Episode> episodes =
                                singlePodcastEntity.episodes!;
                            // debugPrint(episodes[index].);
                            locator<PlayerController>().playFromPlaylist(index);
                            Navigator.of(context).pushNamed(
                                RouteNames.playerScreen,
                                arguments: episodes[index]);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.download),
                          onPressed: () async {
                            // log(episode..toString());
                            DownloadEpisodeModel data = DownloadEpisodeModel(
                                id: episode.guid,
                                downloadLink: episode.link!,
                                fileName: '${episode.title}.mp3',
                                episodeTitle: state.singlePodcastEntity
                                        .episodes?[index].title ??
                                    '');
                            log(data.toString());
                            context
                                .read<DownloaderCubit>()
                                .downloadEpisode(data);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: state.singlePodcastEntity.episodes!.length,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            width: size.width,
            height: size.height * 0.08,
            // color: Colors.black,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.podcasts),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'PodPlayer',
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class PlayerBottemSheet extends StatelessWidget {
  const PlayerBottemSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: locator<PlayerController>().currentSongDetailNotifier,
        builder: (context, value, child) {
          return Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 8,
                      blurStyle: BlurStyle.inner)
                ]),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.07,
            // color: Colors.red,
            child: Row(
              children: [
                /// image
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(value.artUri.toString()),
                          fit: BoxFit.cover)),
                  // color: Colors.green,
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                SizedBox(
                  width: 5,
                ),

                /// title description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        value.title,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        value.displayDescription ??
                            'this is description im writing here',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.skip_previous)),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: Icon(Icons.play_arrow),
                    // ),
                    ValueListenableBuilder(
                        valueListenable:
                            locator<PlayerController>().buttonNotifier,
                        builder: (context, value, child) {
                          switch (value) {
                            case ButtonState.loading:
                              return SizedBox();
                            case ButtonState.paused:
                              return IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.play_arrow));
                            case ButtonState.playing:
                              return IconButton(
                                  onPressed: () {}, icon: Icon(Icons.pause));
                          }
                        }),
                    IconButton(onPressed: () {}, icon: Icon(Icons.skip_next))
                  ],
                )
              ],
            ),
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //
            //   // mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Row(
            //       children: [
            //         Container(
            //           width: MediaQuery.of(context).size.width * 0.2,
            //           height: MediaQuery.of(context).size.height * 0.07,
            //           color: Colors.green,
            //         ),
            //         SizedBox(
            //           width: 5,
            //         ),
            //
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text('This is title'),
            //             Text(
            //               'This is description which im writing!',
            //               maxLines: 10,
            //               overflow: TextOverflow.ellipsis,
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //     Row(
            //       children: [
            //         IconButton(
            //             onPressed: () {}, icon: Icon(Icons.skip_previous)),
            //         IconButton(
            //             onPressed: () {}, icon: Icon(Icons.play_arrow)),
            //         IconButton(onPressed: () {}, icon: Icon(Icons.skip_next)),
            //       ],
            //     )
            //   ],
            // ),
          );
        });
  }
}
