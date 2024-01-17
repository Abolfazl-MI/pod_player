import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_player/app/core/services/getit.dart';
import 'package:pod_player/presentation/blocs/episode/episode_cubit.dart';
import 'package:pod_player/presentation/blocs/episode/episode_state.dart';
import 'package:pod_player/presentation/blocs/player/player_controller.dart';
import 'package:pod_player/presentation/widgets/drawer_widget.dart';
import 'package:pod_player/presentation/widgets/player_bottom_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const Text('Episodes'),
      ),
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
            if (state.downloadedEpisodes.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.now_widgets_outlined),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'No Episode Downloaded yet',
                    ),
                    Text('Downloads would shown here')
                  ],
                ),
              );
            }
            return SizedBox(
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
            return const Center(
              child: Text('err'),
            );
          }
          return Container();
        },
      ),
    );
  }
}
