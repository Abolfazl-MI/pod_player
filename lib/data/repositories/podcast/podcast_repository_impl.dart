
import 'package:pod_player/app/core/resources/data_state.dart';
import 'package:pod_player/data/providers/data_source/local/podcast_provider/podcast_provider.dart';
import 'package:pod_player/domain/repositories/podcst/podcast_repository.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:podcast_search/src/model/item.dart';
import 'package:podcast_search/src/model/podcast.dart';

class PodcastRepositoryImpl implements PodcastRepository{
  final PodcastProvider _podcastProvider;

  PodcastRepositoryImpl(this._podcastProvider);

  @override
  Future<DataState<List<Item>>> loadChartFeed() async{
    try{
      SearchResult searchResult=await _podcastProvider.loadChartFeed();
      if(searchResult.successful){
        List<Item> podcastItems=searchResult.items;
        return DataSuccess(podcastItems);
      }
      return const DataSuccess([]);
    }
    catch(e){
      return const DataFailed('failed to load charts');
    }
  }

  @override
  Future<DataState<Podcast>> loadPodcastFromFeed({required String feedUrl})async {
    try{
      Podcast podcast= await _podcastProvider.loadPodcastFromFeed(feedUrl: feedUrl);
      return DataSuccess(podcast);
    }catch(e){
      if(e is PodcastTimeoutException){
        return const DataFailed('Network Timeout on loading');
      }
      return const DataFailed('SomeThing went wrong');
    }
  }

  @override
  Future<DataState<List<Item>>> searchPodcast({required String query})async {
    try{
      SearchResult result=await _podcastProvider.searchPodcast(query: query);
      if(result.successful) {
        List<Item>searchResult = result.items;
        return DataSuccess(searchResult);
      }
      return const DataSuccess([]);
    }catch(e){
      return  const DataFailed('Something went wrong');
    }
  }

}