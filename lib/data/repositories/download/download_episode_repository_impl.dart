import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pod_player/app/core/resources/data_state.dart';
import 'package:pod_player/data/models/downloaded_episode/downloaded_episode_model.dart';
import 'package:pod_player/data/providers/data_source/remote/downloade/downloader_service.dart';
import 'package:pod_player/domain/repositories/download/download_episode_repository.dart';

class DownloadEpisodeRepositoryImpl implements DownloadEpisodeRepository {
  final String _appDirPath = '/storage/emulated/0/podPlayer';

  final DownloaderService downloadService;
  Future<DataState<String>> _getPathForFile(
      String fileName, String episodeTitle) async {
    try {
      PermissionStatus storageStatus = await Permission.storage.status;
      PermissionStatus externalStorageStatus =
          await Permission.manageExternalStorage.status;
      // check if storage and external storage permissions has not granted to ask
      if (!storageStatus.isGranted && !externalStorageStatus.isGranted) {
        await Permission.storage.request();
        await Permission.manageExternalStorage.request();
      }
      Directory appDir = Directory('/storage/emulated/0/podPlayer');
      // check if folder not exists created it
      if (await appDir.exists() == false) {
        await appDir.create();
      }
      return DataSuccess('${appDir.path}/$fileName');
    } catch (e) {
      return const DataFailed('Something went wrong');
    }
  }

  DownloadEpisodeRepositoryImpl({required this.downloadService});

  @override
  Future<DataState<bool>> saveEpisode(
      {required DownloadEpisodeModel episodeData}) async {
    try {
      // try to download the episode from url and gets its bytes
      Response response =
          await downloadService.downloadEpisode(episodeData.downloadLink);
      // check if response ok
      if (response.statusCode == 200) {
        // get path of file for saving it
        DataState<String> fileName = await _getPathForFile(
            episodeData.fileName, episodeData.episodeTitle);
        if (fileName is DataFailed) {
          return const DataFailed('Failed to download episode');
        }
        File episode = File(fileName.data!);
        await episode.writeAsBytes(
          response.data,
        );
        return const DataSuccess(true);
      }
      // return unknown error
      return const DataFailed('Failed to download episode');
    } on DioException catch (e) {
      log('DioException=>${e.toString()}');
      return const DataFailed('NetWork error ');
    } catch (e) {
      return const DataFailed('SomeThing went wrong');
    }
  }

  @override
  DataState<List<File>> readAllSavedEpisodes() {
    try {
      Directory appDir = Directory(_appDirPath);
      var result = appDir.listSync();
      List<File> files = result.map((e) => File(e.path)).toList();
      return DataSuccess(files);
    } catch (e) {
      return DataFailed('something went wrong');
    }
  }

  @override
  void cancelDownload() {
    downloadService.cancelReq();
  }


  bool hasEpisodeDownloaded(String episodeTitle) {
    try {
      
      bool fileExists = Directory("$_appDirPath/$episodeTitle.mp3").existsSync();
      return fileExists;
    } catch (e) {
      return false;
    }
  }
}
/*  try {
      
    } on DioException catch (error) {
      return const DataFailed('Network Error');
    } catch (e) {
      return DataFailed('SomeThing went wrong');
    } */