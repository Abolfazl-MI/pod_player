import 'package:pod_player/app/core/resources/data_state.dart';
import 'package:pod_player/domain/entities/subscription/single_podcast_entity.dart';
import 'package:podcast_search/podcast_search.dart' as podcast;

abstract interface class PodcastRepository {
  // because the package has provided lots of class fro podcast we wont create entity for it and use from the package resuources

  Future<DataState<List<podcast.Item>>> loadChartFeed();

  Future<DataState<List<podcast.Item>>> searchPodcast({required String query});

  Future<DataState<SinglePodcastEntity>> loadPodcastFromItem(
      {required podcast.Item item});
  Future<DataState<List<podcast.Item>>>loadSimilarPodcasts({required String genre});
}
