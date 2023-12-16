import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pod_player/domain/entities/subscription/single_podcast_entity.dart';
import 'package:pod_player/presentation/blocs/podcast_single/single_podcast_bloc.dart';
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
          appBar: state is SinglePodLoaded
              ? AppBar(
                  title: Text(state.singlePodcastEntity.podcastName ?? ''),
                )
              : null,
          body: _handleBodyState(state, MediaQuery.of(context).size,context)
        );
      },
    );
  }

  _handleBodyState(
    SinglePodcastState state,
    Size size,
      BuildContext context
  ) {
    return SizedBox(
        width: size.width,
        height: size.height,
        child: state is SinglePodLoadingState
            ? _loadingState(size)
            : state is SinglePodError
                ? _failedToLoadState(state.error)
                : state is SinglePodLoaded
                    ? _body(size, state,context)
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

  _body(Size size, SinglePodLoaded state,BuildContext context) {
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
                    title: Text(episode.title),
                    trailing: IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () {},
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
            height: size.height*0.08,
            // color: Colors.black,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Icon(Icons.podcasts),
                  SizedBox(width: 10,),
                  Text('PodPlayer',style: Theme.of(context).textTheme.bodySmall,)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
