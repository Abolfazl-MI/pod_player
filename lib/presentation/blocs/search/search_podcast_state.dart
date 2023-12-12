part of 'search_podcast_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();
}

final class SubscriptionInitialState extends SearchState {
  @override
  List<Object?> get props => [];
}

final class SubscriptionLoadingState extends SearchState{
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}

final class SubscriptionLoadedState extends SearchState{
  final List<Item>data;

  const SubscriptionLoadedState(this.data);
  @override

  List<Object?> get props =>[data];

}

final class SubscriptionFailedState extends SearchState{
    final String error;

  const SubscriptionFailedState(this.error);

  @override
  List<Object?> get props => [error];
}

