import 'package:flutter/foundation.dart';

class DownloadedEpisodeEntity {
  // file name
  final String fileName;
  // file download link
  final String downloadLink;
  final String id;
  // file dir where saved
  String? fileDir;
  final String episodeTitle;
  DownloadedEpisodeEntity(
      {required this.id,
      required this.fileName,
      required this.downloadLink,
      this.fileDir,
      required this.episodeTitle});
}
