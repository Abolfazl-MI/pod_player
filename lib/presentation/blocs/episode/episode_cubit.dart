import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_player/app/core/resources/data_state.dart';
import 'package:pod_player/domain/repositories/download/download_episode_repository.dart';
import 'package:pod_player/presentation/blocs/episode/episode_state.dart';

class EpisodeCubit extends Cubit<EpisodeState> {
  final DownloadEpisodeRepository downloadEpisodeRepository;
  EpisodeCubit({required this.downloadEpisodeRepository})
      : super(InitialEpisodeState());
  loadDownloaded() {
    emit(LoadingEpisodeState());
    Future.delayed(Duration(seconds: 2));
    DataState<List<File>> files =
        downloadEpisodeRepository.readAllSavedEpisodes();
    if (files is DataSuccess) {
      emit(LoadedEpisodeState(files.data ?? []));
    } else {
      emit(ErrorEpisodeState(error: files.error??'someting went wrong'));
    }
  }
}
