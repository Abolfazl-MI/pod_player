part of 'subscriptions_bloc.dart';

abstract class SubscriptionsEvent extends Equatable {
  const SubscriptionsEvent();
}

class LoadFeedEvent extends SubscriptionsEvent {
  @override
  List<Object?> get props => [];
}

class SearchPodcastEvent extends SubscriptionsEvent {
  final String query;

  const SearchPodcastEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class SubscribeToPodcast extends SubscriptionsEvent {
  final SubscriptionEntity subscriptionEntity;

  const SubscribeToPodcast(this.subscriptionEntity);

  @override
  List<Object?> get props => [subscriptionEntity];
}

class UnSubscribeToPodcast extends SubscriptionsEvent {
  final int podcastId;

  const UnSubscribeToPodcast(this.podcastId);

  @override
  List<Object?> get props => [podcastId];
}


class CheckSubscriptionEvent extends SubscriptionsEvent{
  final String feedUrl;
  const CheckSubscriptionEvent(this.feedUrl);
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}