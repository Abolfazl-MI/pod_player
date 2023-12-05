import 'package:podcast_search/podcast_search.dart' as podcast;

class PodcastProvider {
  /// load List<Item> from chart
  Future<podcast.SearchResult> loadChartFeed() async {
    //country default iran

    return await podcast.Search().charts( limit: 20);
  }

  /// load podcast from feed url
  Future<podcast.Podcast> loadPodcastFromFeed({required String feedUrl}) async {
    return await podcast.Podcast.loadFeed(url: feedUrl);
  }

  /// search podcast by term sent
  Future<podcast.SearchResult>searchPodcast({required String query})async{
    return await podcast.Search().search(query);
  }
}
