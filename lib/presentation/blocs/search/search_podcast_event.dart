part of 'search_podcast_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class LoadFeedEvent extends SearchEvent {
  @override
  List<Object?> get props => [];
}

class SearchPodcastEvent extends SearchEvent {
  final String query;

  const SearchPodcastEvent(this.query);

  @override
  List<Object?> get props => [query];
}

// class SubscribeToPodcast extends SearchEvent {
//   final SubscriptionEntity subscriptionEntity;
//
//   const SubscribeToPodcast(this.subscriptionEntity);
//
//   @override
//   List<Object?> get props => [subscriptionEntity];
// }
//
// class UnSubscribeToPodcast extends SearchEvent {
//   final int podcastId;
//
//   const UnSubscribeToPodcast(this.podcastId);
//
//   @override
//   List<Object?> get props => [podcastId];
// }
//
//
// class CheckSubscriptionEvent extends SearchEvent{
//   final String feedUrl;
//   const CheckSubscriptionEvent(this.feedUrl);
//   @override
//   // TODO: implement props
//   List<Object?> get props => throw UnimplementedError();
//
// }