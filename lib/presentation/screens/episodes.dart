import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_player/app/core/services/getit.dart';
import 'package:pod_player/presentation/blocs/episode/episode_cubit.dart';
import 'package:pod_player/presentation/blocs/episode/episode_state.dart';
import 'package:pod_player/presentation/blocs/player/player_controller.dart';
import 'package:pod_player/presentation/screens/podcast_single.dart';
import 'package:pod_player/presentation/widgets/drawer_widget.dart';
import 'package:podcast_search/podcast_search.dart';

class DownloadedEpisodeScreen extends StatefulWidget {
  const DownloadedEpisodeScreen({super.key});

  @override
  State<DownloadedEpisodeScreen> createState() =>
      DownloadedEpisodeScreenState();
}

class DownloadedEpisodeScreenState extends State<DownloadedEpisodeScreen> {
  var drawerKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<EpisodeCubit>().loadDownloaded();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const Text('Episodes'),
      ),
      // bottomNavigationBar: ValueListenableBuilder(
      //         valueListenable: locator<PlayerController>().playState,
      //         builder: (context, value, child) {
      //           if (!value) {
      //             return SizedBox.shrink();
      //           } else {
      //             return PlayerBottemSheet();
      //           }
      //         },
      //       ),
      drawer: DrawerWidget(drawerKey: drawerKey),
      body: BlocBuilder<EpisodeCubit, EpisodeState>(
        builder: (context, state) {
          if (state is LoadingEpisodeState || state is InitialEpisodeState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          if (state is LoadedEpisodeState) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: state.downloadedEpisodes.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text('data$index'),
                  ),
                ),
              ),
            );
          }
          if (state is ErrorEpisodeState) {
            return Center(
              child: Text('err'),
            );
          }
          return Container();
        },
      ),
    );
  }
}
