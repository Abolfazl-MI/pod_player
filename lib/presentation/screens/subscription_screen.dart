import 'package:flutter/material.dart';
import 'package:pod_player/presentation/widgets/drawer_widget.dart';
import 'package:pod_player/presentation/screens/single_pod_info.dart';

import 'package:podcast_search/podcast_search.dart';

class Subscriptions extends StatefulWidget {
  const Subscriptions({Key? key}) : super(key: key);

  @override
  State<Subscriptions> createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
  late GlobalKey<ScaffoldState> drawerKey;

  var search = Search();
  bool isLoading = false;

  List<Item> search_result = [];

  void _loadFeatureds() async {
    try {
      setState(() {
        isLoading = true;
      });
      SearchResult result = await search.charts();

      setState(() {
        search_result = result.items;
        isLoading = false;
      });
    } catch (e) {}
  }

  void _searchPodcast(String query) async {
    try {
      setState(() {
        isLoading = true;
        search_result.clear();
      });
      SearchResult result = await Search().search(query);
      setState(() {
        search_result = result.items;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        search_result = [];
      });
    }
  }

  @override
  void initState() {
    drawerKey = GlobalKey<ScaffoldState>();
    // TODO: implement initState
    super.initState();
    _loadFeatureds();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Subscriptions'),
        ),
        drawer: DrawerWidget(drawerKey: drawerKey),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              TextFormField(
                onFieldSubmitted: (query) async {
                  if (query != null && query.isNotEmpty) {
                    _searchPodcast(query);
                  }
                },
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        // _loadFeatureds();
                      },
                    ),
                    hintText: 'search podcast ...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Container(
                // color: Colors.green,
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : CustomScrollView(
                        slivers: [
                          // SliverList(
                          //   delegate:
                          //       SliverChildBuilderDelegate((context, index) {
                          //     if (home_result.isEmpty) {
                          //       return const Center(
                          //         child: Text('no result'),
                          //       );
                          //     } else {
                          //       Item item = home_result[index];
                          //       return InkWell(
                          //         onTap: () {
                          //           Navigator.of(context).push(MaterialPageRoute(
                          //               builder: (context) =>
                          //                   SinglePodInfoScreen(item: item)));
                          //         },
                          //         child: Card(
                          //           child: Padding(
                          //               padding: const EdgeInsets.all(8.0),
                          //               child: ListTile(
                          //                 title: Text(item.trackName ?? ''),
                          //                 subtitle:
                          //                     Text(item.genre?.first.name ?? ''),
                          //                 leading: Hero(
                          //                   tag: 'artwork_hero',
                          //                   child: Container(
                          //                     width: 50,
                          //                     height: 50,
                          //                     decoration: BoxDecoration(
                          //                         image: item.thumbnailArtworkUrl !=
                          //                                 null
                          //                             ? DecorationImage(
                          //                                 image: NetworkImage(item
                          //                                     .thumbnailArtworkUrl!))
                          //                             : null),
                          //                     // color: Colors.green
                          //                   ),
                          //                 ),
                          //               )),
                          //         ),
                          //       );
                          //     }
                          //   }, childCount: home_result.length),
                          // )
                          SliverGrid(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                              Item item = search_result[index];
                              if (search_result.isEmpty) {
                                return Center(
                                  child: Text('No result'),
                                );
                              } else {
                                return SearchItem(item: item);
                              }
                            }, childCount: search_result.length),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: (size.width / 150).floor(),
                            ),
                          )
                        ],
                      ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class SearchItem extends StatelessWidget {
  const SearchItem({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SinglePodInfoScreen(item: item)));
      },
      child: Card(
        // child: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: ListTile(
        //     title: Text(item.trackName ?? ''),
        //     subtitle:
        //         Text(item.genre?.first.name ?? ''),
        //     leading: Hero(
        //       tag: 'artwork_hero',
        //       child: Container(
        //         width: 50,
        //         height: 50,
        //         decoration: BoxDecoration(
        //             image: item.thumbnailArtworkUrl !=
        //                     null
        //                 ? DecorationImage(
        //                     image: NetworkImage(item
        //                         .thumbnailArtworkUrl!))
        //                 : null),
        //         // color: Colors.green
        //       ),
        //     ),
        //   ),
        // ),
        child: Column(
          children: [
            // TODO use cached network image
            Expanded(
              child: Hero(
                tag: 'artwork${item.trackId}',
                child: Container(
                  // color: Colors.greenf,
                  decoration: BoxDecoration(
                      image: item.thumbnailArtworkUrl != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(item.bestArtworkUrl!))
                          : null),
                  // color: Colors.green
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item.trackName ?? ''),
            )
          ],
        ),
      ),
    );
  }
}
