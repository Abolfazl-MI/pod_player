import 'package:pod_player/app/core/resources/data_state.dart';
import 'package:pod_player/data/models/downloaded_episode/downloaded_episode_model.dart';

abstract interface class DownloadEpisodeRepository {
  Future<DataState<bool>> saveEpisode(
      {required DownloadEpisodeModel episodeData});
  DataState<String> readAllSavedEpisodes();

  void cancelDownload();
}
