import 'package:equatable/equatable.dart';
import 'package:pod_player/domain/entities/downloaded_episode/downloaded_episode_entity.dart';

sealed class DownloaderState extends Equatable {}

final class DownloaderInitial extends DownloaderState {
  @override
  List<Object?> get props => [];
}

final class DownloaderLoading extends DownloaderState {
  final String id;

  DownloaderLoading(this.id);
  @override
  List<Object?> get props => [id];
}

final class DownloaderSuccess extends DownloaderState {
final  DownloadedEpisodeEntity data;

  DownloaderSuccess({required this.data});
  List<Object?> get props => [];
}

final class DownloaderFail extends DownloaderState {
  final String error;

  DownloaderFail(this.error);

  List<Object?> get props => [error];
}
