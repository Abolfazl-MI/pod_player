part of 'single_podcast_bloc.dart';

sealed class SinglePodcastState extends Equatable {}

final class SinglePodInitialState extends SinglePodcastState {
  @override
  List<Object?> get props => [];
}

/// loading of whole screen
final class SinglePodLoadingState extends SinglePodcastState {
  @override
  List<Object?> get props => [];
}

/// loaded data for all over screen
final class SinglePodLoaded extends SinglePodcastState {
  final SinglePodcastEntity singlePodcastEntity;
  final List<Item>similarItems;
  SinglePodLoaded(this.singlePodcastEntity, this.similarItems);

  @override
  // TODO: implement props
  List<Object?> get props => [singlePodcastEntity];
}

/// error state
final class SinglePodError extends SinglePodcastState {
  final String error;

  SinglePodError(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

final class SinglePodSimilarPodLoading extends SinglePodcastState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class SinglePodSimilarPodLoaded extends SinglePodcastState {
  final List<Item> data;

  SinglePodSimilarPodLoaded(this.data);

  @override
  // TODO: implement props
  List<Object?> get props => [data];
}

final class SinglePodSimilarPodFailed extends SinglePodcastState {
  final String error;

  SinglePodSimilarPodFailed(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class SinglePodSubLoading extends SinglePodcastState {
  @override
// TODO: implement props
  List<Object?> get props => [];
}

final class SinglePodSubscribed extends SinglePodcastState {
  @override
// TODO: implement props
  List<Object?> get props => [];
}

final class SinglePodUnSubscribed extends SinglePodcastState {
  @override
// TODO: implement props
  List<Object?> get props => [];
}

final class SinglePodSubFailed extends SinglePodcastState {
  final String error;

  SinglePodSubFailed(this.error);

  @override
// TODO: implement props
  List<Object?> get props => [];
}
