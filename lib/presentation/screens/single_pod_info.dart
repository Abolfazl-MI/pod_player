import 'dart:developer';

import 'package:dart_rss/dart_rss.dart';
import 'package:dart_rss/domain/media/media.dart';
import 'package:dart_rss/domain/rss1_feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_player/app/config/router/router.dart';
import 'package:pod_player/domain/entities/subscription/single_podcast_entity.dart';
import 'package:pod_player/presentation/blocs/podcast_single/single_podcast_bloc.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:flutter_html/flutter_html.dart';
class SinglePodInfoScreen extends StatefulWidget {
  const SinglePodInfoScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SinglePodInfoScreen> createState() => _SinglePodInfoScreenState();
}

class _SinglePodInfoScreenState extends State<SinglePodInfoScreen> {
  bool similarPodcastLoading = false;
  List<Item> similar_podcast = [];

  // Item item = Item();

  // _loadPodcasts() async {
  //   try {
  //     setState(() {
  //       similarPodcastLoading = true;
  //     });
  //     var similarResult =
  //     await Search().charts(limit: 10, genre: item.primaryGenreName!);
  //     setState(() {
  //       similar_podcast = similarResult.items;
  //       similarPodcastLoading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       similarPodcastLoading = false;
  //     });
  //   }
  // }

  _prossdata() async {
    // try {
    //   var result = await Podcast.loadFeed(url: item.feedUrl!);
    //   log(result.);
    // } catch (e) {
    //   log(e.toString());
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      print(ModalRoute
          .of(context)!
          .settings
          .arguments);
      setState(() {

        context.read<SinglePodcastBloc>().add(
          LoadPodcastDetial(
            ModalRoute
                .of(context)!
                .settings
                .arguments as Item,
          ),
        );
      });
    });
    // _loadPodcasts();
    // _prossdata();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    // print(item.feedUrl);
    return SafeArea(

      child: BlocConsumer<SinglePodcastBloc, SinglePodcastState>(
        builder: (context, state) {
          print(state);

          return Scaffold(
              appBar: AppBar(
                title: state is SinglePodLoaded ? Text(state.singlePodcastEntity.trackCensoredName??'') : null,
              ),
              body: _handleBodyState(state, MediaQuery
                  .of(context)
                  .size));
        },
        listener: (context, state) {},
      ),
    );
  }

  _handleBodyState(SinglePodcastState state, Size size) {
    SinglePodcastState totalState=state;
    return Container(
      width: size.width,
      height: size.height,
      child: state is SinglePodLoadingState
          ? _loadingState(size)
          : state is SinglePodError
          ? _failedToLoadState(state.error)
          : state is SinglePodLoaded
          ? _body(state, size,totalState)
          : Container(),
    );
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

  _body(SinglePodLoaded state, Size size,SinglePodcastState totalState) {
    List<Item>similarPodcasts = state.similarItems;
    SinglePodcastEntity singlePodcastEntity = state.singlePodcastEntity;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO: use cached network image widget
          Container(
            width: size.width,
            height: size.height * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(singlePodcastEntity.image!,),),),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Text(singlePodcastEntity.podcastName ?? '', maxLines: 12),
                          Text(singlePodcastEntity.artistName ?? '', maxLines: 12),
                          Visibility(
                            visible: singlePodcastEntity.releaseDate != null,
                            child: Text(
                                '${singlePodcastEntity.releaseDate?.year ?? ''}/${singlePodcastEntity
                                    .releaseDate?.month}${singlePodcastEntity.releaseDate
                                    ?.day}'),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      _prossdata();
                    },
                    child: const Text('subscribe'))
              ],
            ),
          ),
          Wrap(
            children: singlePodcastEntity.genres!
                .map((e) =>
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Chip(
                      label: RichText(
                        text: TextSpan(
                          // text: '#',
                          // style: TextStyle(color: Colors.blue),
                            children: [
                              const TextSpan(
                                  text: '#',
                                  style: TextStyle(color: Colors.blue)),
                              TextSpan(
                                  text: e.name,
                                  style: const TextStyle(
                                      color: Colors.black))
                            ]),
                      )),
                ))
                .toList(),
          ),
          const SizedBox(
            height: 10,
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Html(
              data: singlePodcastEntity.description,

            )
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Simillar Podcast',
              style: TextStyle(fontSize: 20),
            ),
          ),

          Container(
            width: size.width,
            height: size.height * 0.28,
            // color: Colors.green,
            child: PageView.builder(
              padEnds: false,
              controller: PageController(viewportFraction: 0.4),
              itemBuilder: (context, index) {
                Item similar_item = similarPodcasts[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        RouteNames.podcastSingleInfo,
                        arguments: similar_item);
                  },
                  child: Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          similar_item.bestArtworkUrl!))),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(similar_item.trackName ?? ''),
                          SizedBox(
                            height: 5,
                          ),
                          Text(similar_item.artistName ?? '')
                        ],
                      )),
                );
              },
              itemCount: similarPodcasts.length,
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
