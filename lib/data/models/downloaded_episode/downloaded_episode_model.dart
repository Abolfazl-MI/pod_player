import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:pod_player/domain/entities/downloaded_episode/downloaded_episode_entity.dart';

part 'downloaded_episode_model.g.dart';

@collection
class DownloadedEpisodeModel {
  Id? id = Isar.autoIncrement;
  // file name
  final String fileName;
  // file download link
  final String downloadLink;
  // episode title
  final String episodeTitle;
  // file dir where saved
  String? fileDir;
  DownloadedEpisodeModel(
      {required this.downloadLink,
      required this.fileName,
      this.fileDir,
      required this.episodeTitle});

  factory DownloadedEpisodeModel.fromEntity(DownloadedEpisodeEntity entity) =>
      DownloadedEpisodeModel(
          downloadLink: entity.downloadLink,
          fileName: entity.fileName,
          fileDir: entity.fileDir,
          episodeTitle: entity.episodeTitle);
  DownloadedEpisodeEntity toEntity() => DownloadedEpisodeEntity(
      downloadLink: downloadLink,
      fileName: fileName,
      fileDir: fileDir,
      episodeTitle: episodeTitle);
}
