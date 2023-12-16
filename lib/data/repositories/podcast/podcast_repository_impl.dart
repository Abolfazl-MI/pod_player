import 'package:pod_player/app/core/resources/data_state.dart';
import 'package:pod_player/data/models/singlePodcast/single_podcast_info_model.dart';
import 'package:pod_player/data/providers/data_source/local/podcast_provider/podcast_provider.dart';
import 'package:pod_player/domain/entities/subscription/single_podcast_entity.dart';
import 'package:pod_player/domain/repositories/podcst/podcast_repository.dart';
import 'package:podcast_search/podcast_search.dart';

class PodcastRepositoryImpl implements PodcastRepository {
  final PodcastProvider _podcastProvider;

  PodcastRepositoryImpl(this._podcastProvider);

  @override
  Future<DataState<List<Item>>> loadChartFeed() async {
    try {
      SearchResult searchResult = await _podcastProvider.loadChartFeed();
      if (searchResult.successful) {
        List<Item> podcastItems = searchResult.items;
        return DataSuccess(podcastItems);
      }
      return DataFailed(searchResult.lastError);
    } catch (e) {
      return const DataFailed('failed to load charts');
    }
  }

  @override
  Future<DataState<SinglePodcastEntity>> loadPodcastFromItem(
      {required Item item}) async {
    try {
      // podcast instance which load from feed url
      Podcast podcast =
          await _podcastProvider.loadPodcastFromFeed(feedUrl: item.feedUrl!);
      // load similar items
      DataState<List<Item>> similarItems =
          await loadSimilarPodcasts(genre: item.primaryGenreName!);

      // after loading we create model
      SinglePodcastModel? singlePodcastModel;
      //if we could load similars we would add else we wont
      if (similarItems is DataSuccess) {
        singlePodcastModel = SinglePodcastModel.fromData(item, podcast,
            similarItem: similarItems.data);
      } else {
        singlePodcastModel = SinglePodcastModel.fromData(item, podcast);
      }
      return DataSuccess(singlePodcastModel.toEntity());
    } catch (e) {
      return const DataFailed("SomeThing went wrong");
    }
  }

  @override
  Future<DataState<List<Item>>> searchPodcast({required String query}) async {
    try {
      SearchResult result = await _podcastProvider.searchPodcast(query: query);
      if (result.successful) {
        List<Item> searchResult = result.items;
        return DataSuccess(searchResult);
      }
      return const DataSuccess([]);
    } catch (e) {
      return const DataFailed('Something went wrong');
    }
  }

  @override
  Future<DataState<List<Item>>> loadSimilarPodcasts(
      {required String genre}) async {
    try {
      SearchResult result =
          await _podcastProvider.loadSimilarPodcasts(genre: genre);
      if (result.successful) {
        return DataSuccess(result.items);
      }
      return const DataFailed('SomeThing went wrong');
    } catch (e) {
      return const DataFailed('SomeThing went wrong');
    }
  }

  @override
  Future<DataState<SinglePodcastEntity>> loadPodcastFromFeed(
      {required String feedUrl}) async {
    try {
      Podcast podcast =
          await _podcastProvider.loadPodcastFromFeed(feedUrl: feedUrl);
      SinglePodcastModel singlePodcastModel =
          SinglePodcastModel.fromRawPodcast(podcast);
      return DataSuccess(singlePodcastModel.toEntity());
    } catch (e) {
      return const DataFailed('SomeThing went wrong');
    }
  }
}
