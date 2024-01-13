import 'dart:io';

import 'package:equatable/equatable.dart';

sealed class EpisodeState extends Equatable {}

final class LoadingEpisodeState extends EpisodeState {
  @override
  List<Object?> get props => [];
}

final class LoadedEpisodeState extends EpisodeState {
  final List<File> downloadedEpisodes;

  LoadedEpisodeState(this.downloadedEpisodes);
  @override
  // TODO: implement props
  List<Object?> get props => [downloadedEpisodes];
}

final class InitialEpisodeState extends EpisodeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class ErrorEpisodeState extends EpisodeState {
  final String error;

  ErrorEpisodeState({required this.error});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
