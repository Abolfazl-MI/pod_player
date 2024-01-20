import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_player/app/core/resources/data_state.dart';
import 'package:pod_player/app/core/services/getit.dart';
import 'package:pod_player/data/providers/data_source/local/audio_service/audio_service.dart';
import 'package:pod_player/domain/repositories/download/download_episode_repository.dart';
import 'package:pod_player/presentation/blocs/episode/episode_state.dart';
import 'package:pod_player/presentation/blocs/player/player_controller.dart';

class EpisodeCubit extends Cubit<EpisodeState> {
  final DownloadEpisodeRepository downloadEpisodeRepository;
  EpisodeCubit({required this.downloadEpisodeRepository})
      : super(InitialEpisodeState());
  bool needToReload = true;
  loadDownloaded() async {
    emit(LoadingEpisodeState());
    Future.delayed(Duration(seconds: 2));
    DataState<List<File>> files =
        downloadEpisodeRepository.readAllSavedEpisodes();
    if (files is DataSuccess) {
      // check if not  playing something to create playlist
      bool playingState = locator<PlayerController>().playState.value;
     
     
        locator<MyAudioHandler>().clearPlayList();
        await locator<MyAudioHandler>()
            .addQueueItemsFromFiles(files.data ?? []);
    
      emit(LoadedEpisodeState(files.data ?? []));
    } else {
      emit(ErrorEpisodeState(error: files.error ?? 'something went wrong'));
    }
  }

  resetPlayList(List<File>files)async {
    needToReload = false;
        locator<MyAudioHandler>().clearPlayList();
        await locator<MyAudioHandler>()
            .addQueueItemsFromFiles(files);
  }
}
