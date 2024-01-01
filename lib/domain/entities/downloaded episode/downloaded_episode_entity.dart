import 'package:flutter/foundation.dart';

class DownloadedEpisodeEntity {
  // file name
  final String fileName;
  // file download link
  final String downloadLink;

  // file dir where saved
  String? fileDir;
 final String episodeTitle;
  DownloadedEpisodeEntity({
    required this.fileName,
    required this.downloadLink,
    this.fileDir,
    required this.episodeTitle
  });
}
