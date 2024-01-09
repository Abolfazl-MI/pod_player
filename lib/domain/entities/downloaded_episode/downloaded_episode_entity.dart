import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class DownloadedEpisodeEntity extends Equatable {
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

  @override
  // TODO: implement props
  List<Object?> get props =>
      [fileName, downloadLink, id, fileDir, episodeTitle];
}
