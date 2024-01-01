import 'package:equatable/equatable.dart';
import 'package:pod_player/domain/entities/single_podcast/single_podcast_entity.dart';
import 'package:podcast_search/podcast_search.dart';

class SinglePodcastModel extends Equatable {
  String? feedUrl;
  String? trackCensoredName;
  String? podcastName;
  String? artistName;
  String? description;
  String? image;
  DateTime? releaseDate;
  List<Episode>? episodes;
  List<Genre>? genres;
  bool? subscribed;
  List<Item>? similarItems;

  SinglePodcastModel(
      {this.feedUrl,
      this.artistName,
      this.description,
      this.image,
      this.releaseDate,
      this.episodes,
      this.genres,
      this.subscribed,
      this.similarItems,
      this.podcastName,
      this.trackCensoredName});

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

  factory SinglePodcastModel.fromData(Item item, Podcast podcast,
          {List<Item>? similarItem}) =>
      SinglePodcastModel(
          feedUrl: item.feedUrl,
          releaseDate: item.releaseDate,
          artistName: item.artistName,
          image: podcast.image,
          description: podcast.description,
          episodes: podcast.episodes,
          genres: item.genre,
          similarItems: similarItem,
          podcastName: podcast.title,
          trackCensoredName: item.trackCensoredName);

  factory SinglePodcastModel.fromEntity(SinglePodcastEntity entity) =>
      SinglePodcastModel(
          subscribed: entity.subscribed,
          genres: entity.genres,
          episodes: entity.episodes,
          description: entity.description,
          image: entity.image,
          artistName: entity.artistName,
          releaseDate: entity.releaseDate,
          feedUrl: entity.feedUrl,
          similarItems: entity.similarItems,
          podcastName: entity.podcastName,
          trackCensoredName: entity.trackCensoredName);

  factory SinglePodcastModel.fromRawPodcast(Podcast podcast) =>
      SinglePodcastModel(
        feedUrl: podcast.link,
        podcastName: podcast.title,
        episodes: podcast.episodes,
        image: podcast.image,
        description: podcast.description,
      );

  SinglePodcastEntity toEntity() => SinglePodcastEntity(
      feedUrl: feedUrl,
      releaseDate: releaseDate,
      artistName: artistName,
      image: image,
      description: description,
      episodes: episodes,
      genres: genres,
      subscribed: subscribed,
      similarItems: similarItems,
      podcastName: podcastName,
      trackCensoredName: trackCensoredName);
}
