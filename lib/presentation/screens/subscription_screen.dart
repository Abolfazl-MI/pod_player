import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_player/app/config/router/route_names.dart';
import 'package:pod_player/app/core/resources/debouncer.dart';
import 'package:pod_player/app/core/services/getit.dart';
import 'package:pod_player/presentation/blocs/player/player_controller.dart';
import 'package:pod_player/presentation/blocs/search/search_podcast_bloc.dart';

import 'package:pod_player/presentation/widgets/drawer_widget.dart';
import 'package:pod_player/presentation/widgets/player_bottom_widget.dart';

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
    context.read<SearchPodcastBloc>().add(LoadFeedEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: ValueListenableBuilder(
              valueListenable: locator<PlayerController>().playState,
              builder: (context, value, child) {
                if (!value) {
                  return const SizedBox.shrink();
                } else {
                  return const PlayerBottomSheet();
                }
              },
            ),
      appBar: AppBar(
        title: const Text('Subscriptions'),
      ),
      drawer: DrawerWidget(drawerKey: drawerKey),
      body: BlocBuilder<SearchPodcastBloc, SearchState>(
        builder: (context, state) {
          return switch (state) {
            SubscriptionInitialState() => Container(),
            SubscriptionLoadingState() => _body(state, size, context),
            SubscriptionLoadedState() => _body(state, size, context),
            //TODO: implement the time out and try again error
            SubscriptionFailedState() => Center(
                child: Text('failed ${state.error}'),
              )
          };
        },
      ),
    );
  }

  // _loading() {
  //   return Expanded(
  //     child: Container(
  //       child: Center(
  //         child: CircularProgressIndicator(
  //           color: Colors.red,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  _body(SearchState state, Size size, BuildContext context) {
    Debouncer debouncer = Debouncer(500);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          /// SEARCH BOX
          TextFormField(
            onChanged: (String? query) async {
              print(query);
              if (query != null && query.isNotEmpty) {
                debouncer.run(() {
                  context.read<SearchPodcastBloc>().add(
                        SearchPodcastEvent(
                          query.trim(),
                        ),
                      );
                });
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

          /// Loading state
          if (state is SubscriptionLoadingState) ...[
            Expanded(
              child: Container(
                  child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              )
                  // color: Colors.red,
                  ),
            )
          ],

          /// loaded state
          if (state is SubscriptionLoadedState) ...[
            /// empty state
            if (state.data.isEmpty)
              Expanded(
                  child: Container(
                // color: Colors.red,
                child: Center(
                  child: Text(
                    'No Result found ...',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ))
            else

              /// full state
              Expanded(
                child: Container(
                  // color: Colors.green,
                  child: CustomScrollView(
                    slivers: [
                      SliverGrid(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          Item item = state.data[index];
                          return SearchItem(item: item);
                        }, childCount: state.data.length),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: (size.width / 150).floor(),
                        ),
                      )
                    ],
                  ),
                ),
              )
          ]
        ],
      ),
    );
    // return Container(

    //   child: Column(
    //     children: [

    //
    //     ],
    //   ),
    // );
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
        Navigator.of(context).pushNamed(
          RouteNames.podcastSingleInfo,
          arguments: item
        );
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
            const SizedBox(
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
