import 'dart:developer';

import 'package:dart_rss/dart_rss.dart';
import 'package:dart_rss/domain/rss1_feed.dart';
import 'package:flutter/material.dart';
import 'package:podcast_search/podcast_search.dart';

class SinglePodInfoScreen extends StatefulWidget {
  const SinglePodInfoScreen({Key? key, required this.item}) : super(key: key);
  final Item item;

  @override
  State<SinglePodInfoScreen> createState() => _SinglePodInfoScreenState();
}

class _SinglePodInfoScreenState extends State<SinglePodInfoScreen> {
  bool similarPodcastLoading = false;
  List<Item> similar_podcast = [];

  _loadPodcasts() async {
    try {
      setState(() {
        similarPodcastLoading = true;
      });
      var similarResult = await Search()
          .charts(limit: 10, genre: widget.item.primaryGenreName!);
      setState(() {
        similar_podcast = similarResult.items;
        similarPodcastLoading = false;
      });
    } catch (e) {
      setState(() {
        similarPodcastLoading = false;
      });
    }
  }

  _prossdata() async {
    // try {
    //   var result = await Podcast.loadFeed(url: widget.item.feedUrl!);
    //   log(result.);
    // } catch (e) {
    //   log(e.toString());
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPodcasts();
    _prossdata();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(widget.item.feedUrl);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.item.trackName ?? ''),
        ),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TODO: use cached network image widget
                Hero(
                  tag: 'artwork${widget.item.trackId}',
                  child: Container(
                    width: size.width,
                    height: size.height * 0.3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(widget.item.bestArtworkUrl!))),
                  ),
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
                                NetworkImage(widget.item.thumbnailArtworkUrl!),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: size.width * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.item.trackName ?? '', maxLines: 12),
                                Text(widget.item.artistName ?? '',
                                    maxLines: 12),
                                Text(
                                    '${widget.item.releaseDate!.year}/${widget.item.releaseDate!.month}${widget.item.releaseDate!.day}')
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
                  children: widget.item.genre!
                      .map((e) => Padding(
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Simillar Podcast',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                AnimatedOpacity(
                  opacity: similarPodcastLoading ? 0.0 : 1.0,
                  duration: Duration(seconds: 2),
                  child: Container(
                    width: size.width,
                    height: size.height * 0.28,
                    // color: Colors.green,
                    child: PageView.builder(
                      padEnds: false,
                      controller: PageController(viewportFraction: 0.4),
                      itemBuilder: (context, index) {
                        Item similar_item = similar_podcast[index];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    SinglePodInfoScreen(item: similar_item)));
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
                      itemCount: similar_podcast.length,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
