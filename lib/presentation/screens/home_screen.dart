import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_player/app/config/router/route_names.dart';
import 'package:pod_player/app/core/services/getit.dart';
import 'package:pod_player/presentation/blocs/home_cubit/home_cubti.dart';
import 'package:pod_player/presentation/blocs/home_cubit/home_state.dart';
import 'package:pod_player/presentation/blocs/player/player_controller.dart';
import 'package:pod_player/presentation/widgets/cached_image.dart';
import 'package:pod_player/presentation/widgets/drawer_widget.dart';
import 'package:pod_player/presentation/widgets/player_bottom_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var drawerKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadHomeFeed();
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
      key: drawerKey,
      drawer: DrawerWidget(drawerKey: drawerKey),
      appBar: AppBar(
        title: const Text('PodPlayer'),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        return switch (state) {
          NoInternetConnection() => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.signal_wifi_connected_no_internet_4_outlined,
                    size: 50,
                  ),
                  const Text('No Internet Connection'),
                  TextButton(
                    onPressed: () {
                      context.read<HomeCubit>().loadHomeFeed();
                    },
                    child: const Text('Try again'),
                  )
                ],
              ),
            ),
          HomeLoadingState() => const Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: Colors.red,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Loading...',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            )),
          HomeLoadedState() =>
            state.subs.isEmpty ? const EmptyState() : _body(state, size),
          HomeErrorState() => const Center(
              child: Text('error'),
            ),
          HomeInitialState() => Container()
        };
      }),
    );
  }

  _body(HomeLoadedState state, Size size) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: size.width,
      height: size.height,
      child: CustomScrollView(
        slivers: [
          SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteNames.podcastSingle,
                        arguments: state.subs[index].subscriptionUrl);
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CachedImage(
                            imageUrl: state.subs[index].artWorkUrl!,
                          ),
                          // child: Container(
                          //   decoration: BoxDecoration(
                          //     image: DecorationImage(
                          //         image: NetworkImage(
                          //           state.subs[index].artWorkUrl!,
                          //         ),
                          //         fit: BoxFit.fill),
                          //   ),
                          // ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(state.subs[index].trackName!),
                              // Text('Test-test$index'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }, childCount: state.subs.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (size.width / 150).floor(),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10))
        ],
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.podcasts,
                size: 30,
              ),
              // SizedBox(
              //   width: 5,
              // ),
              Text('Wellcome to PODPlayer!',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold)),
              Text(
                'No subscription found! add one from subscriptions page ',
                maxLines: 12,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        ));
  }
}
