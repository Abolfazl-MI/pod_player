import 'package:pod_player/domain/entities/downloaded_episode/downloaded_episode_entity.dart';

class DownloadEpisodeModel {
  final String id;
  // file name
  final String fileName;
  // file download link
  final String downloadLink;
  // episode title
  final String episodeTitle;
  // file dir where saved
  String? fileDir;
  DownloadEpisodeModel(
      {required this.id,
      required this.downloadLink,
      required this.fileName,
      this.fileDir,
      required this.episodeTitle});

  factory DownloadEpisodeModel.fromEntity(DownloadedEpisodeEntity entity) =>
      DownloadEpisodeModel(
          id: entity.id,
          downloadLink: entity.downloadLink,
          fileName: entity.fileName,
          fileDir: entity.fileDir,
          episodeTitle: entity.episodeTitle);
  DownloadedEpisodeEntity toEntity() => DownloadedEpisodeEntity(
      downloadLink: downloadLink,
      fileName: fileName,
      fileDir: fileDir,
      id: id,
      episodeTitle: episodeTitle);

  @override
  String toString() {
    // TODO: implement toString
    return 'DownloadEpisodeModel(id:$id,fileName:$fileName,downloadLink:$downloadLink,episodeTitle:$episodeTitle)';
  }
}
