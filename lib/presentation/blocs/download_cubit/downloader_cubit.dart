import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_player/app/core/resources/data_state.dart';
import 'package:pod_player/data/models/downloaded_episode/downloaded_episode_model.dart';
import 'package:pod_player/presentation/blocs/download_cubit/downloader.state.dart';

import '../../../domain/repositories/download/download_episode_repository.dart';

class DownloaderCubit extends Cubit<DownloaderState> {
  final DownloadEpisodeRepository downloadEpisodeRepository;
  DownloaderCubit({required this.downloadEpisodeRepository})
      : super(DownloaderInitial());
  String downloadedId = '';
  downloadEpisode(DownloadEpisodeModel data) async {
    emit(DownloaderLoading(data.id));

    DataState<bool> downloadEpisodeResult =
        await downloadEpisodeRepository.saveEpisode(episodeData: data);
    if (downloadEpisodeResult is DataFailed) {
      emit(DownloaderFail(
          downloadEpisodeResult.error ?? 'SomeThing went wrong'));
      return;
    } else {
      log('downloaded');
      emit(DownloaderSuccess(data: data.toEntity()));
      downloadedId = data.id;
      return;
    }
  }

  cancelDownload() {
    downloadEpisodeRepository.cancelDownload();
  }
}
