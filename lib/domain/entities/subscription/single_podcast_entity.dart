

import 'package:equatable/equatable.dart';
import 'package:podcast_search/podcast_search.dart';

class SinglePodcastEntity extends Equatable{
  String? feedUrl;
  String?trackCensoredName;
  String?podcastName;
  String? artistName;
  String? description;
  String? image;
  DateTime? releaseDate;
  List<Episode>? episodes;
  List<Genre>? genres;
  bool? subscribed;
  List<Item>? similarItems;

  SinglePodcastEntity(
      {this.feedUrl,
        this.artistName,
        this.description,
        this.image,
        this.releaseDate,
        this.episodes,
        this.genres,
        this.subscribed,this.similarItems,this.podcastName,this.trackCensoredName});

  @override
  // TODO: implement props
  List<Object?> get props => [
    feedUrl,
    artistName,
    description,
    image,
    releaseDate,
    episodes,
    genres,
    subscribed,
    podcastName,
    trackCensoredName
  ];

  @override
  String toString() {
    return 'SinglePodcastEntity{feedUrl: $feedUrl, artistName: $artistName, description: $description, image: $image, releaseDate: $releaseDate, episodes: $episodes, genres: $genres, subscribed: $subscribed, similarItems: $similarItems}';
  }
}