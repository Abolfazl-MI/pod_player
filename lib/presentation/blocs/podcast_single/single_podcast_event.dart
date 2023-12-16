part of 'single_podcast_bloc.dart';

@immutable
abstract class SinglePodcastEvent extends Equatable {}

class LoadPodcastDetial extends SinglePodcastEvent {
  final Item item;

  LoadPodcastDetial(this.item);

  @override
  // TODO: implement props
  List<Object?> get props => [item];
}

class SubscribeToPodcast extends SinglePodcastEvent {
  final SubscribeParam param;

  SubscribeToPodcast(this.param);

  @override
  // TODO: implement props
  List<Object?> get props => [param];
}

class UnSubscribeToPodcast extends SinglePodcastEvent {
  final int id;

  UnSubscribeToPodcast(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CheckSubscription extends SinglePodcastEvent {
  final String urlFeed;

  CheckSubscription(this.urlFeed);

  @override
  List<Object?> get props => [];
}

final class LoadPodcastFromFeed extends SinglePodcastEvent {
  final String feedUrl;

  LoadPodcastFromFeed(this.feedUrl);

  @override
  List<Object?> get props => [feedUrl];
}
