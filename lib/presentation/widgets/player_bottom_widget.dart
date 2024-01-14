
import 'package:flutter/material.dart';
import 'package:pod_player/app/core/services/getit.dart';
import 'package:pod_player/presentation/blocs/player/player_controller.dart';

class PlayerBottomSheet extends StatelessWidget {
  const PlayerBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: locator<PlayerController>().currentSongDetailNotifier,
      builder: (context, value, child) {
        print('image of cover=>${value.artUri.toString()}');
        return Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 8,
                    blurStyle: BlurStyle.inner)
              ]),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.07,
          // color: Colors.red,
          child: Row(
            children: [
              const SizedBox(
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
                  ],
                ),
              ),
              Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable:
                        locator<PlayerController>().isFirstSongNotifier,
                    builder: (ctx, data, child) => IconButton(
                      onPressed: data
                          ? null
                          : () {
                              locator<PlayerController>().onPreviousPressed();
                            },
                      icon: const Icon(
                        Icons.skip_previous,
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                      valueListenable:
                          locator<PlayerController>().buttonNotifier,
                      builder: (context, value, child) {
                        switch (value) {
                          case ButtonState.loading:
                            return const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.red,
                              ),
                            );
                          case ButtonState.paused:
                            return IconButton(
                              onPressed: () {
                                locator<PlayerController>().play();
                              },
                              icon: const Icon(
                                Icons.play_arrow,
                              ),
                            );
                          case ButtonState.playing:
                            return IconButton(
                                onPressed: () {
                                  locator<PlayerController>().pause();
                                },
                                icon: const Icon(Icons.pause));
                        }
                      }),
                  ValueListenableBuilder(
                    valueListenable:
                        locator<PlayerController>().isLastSongNotifier,
                    builder: (context, data, child) => IconButton(
                      onPressed: data
                          ? null
                          : () {
                              locator<PlayerController>().onNextPressed();
                            },
                      icon: const Icon(
                        Icons.skip_next,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}