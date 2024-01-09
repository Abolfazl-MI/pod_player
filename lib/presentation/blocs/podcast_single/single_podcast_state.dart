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
  final List<Item> similarItems;
  final List? downloadedEpisodes;
  SinglePodLoaded(this.singlePodcastEntity, this.similarItems,
      {this.downloadedEpisodes});

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

final class SinglePodDownloadLoading extends SinglePodcastState {
  final String id;

  SinglePodDownloadLoading(this.id);
  @override
  List<Object?> get props => [id];
}

final class SinglePodDownloadSucceed extends SinglePodcastState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class SinglePodDownloadFailed extends SinglePodcastState {
  final String error;

  SinglePodDownloadFailed(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
