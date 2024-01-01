import 'dart:io';

import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pod_player/app/core/resources/data_state.dart';
import 'package:pod_player/data/models/downloaded_episode/downloaded_episode_model.dart';
import 'package:pod_player/data/providers/data_source/local/downloade/downloader_service.dart';
import 'package:pod_player/domain/repositories/download/episode_save_repository.dart';

class SaveEpisodeRepositoryImpl implements SaveEpisodeRepository {
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

      /// directory strategy is like this
      /// we assume that episode title is `life of ceo`
      /// and the episode which is going to download called `how become ceo.mp3`
      /// the folder would be this
      ///  storage/emulated/0/podPlayer/life of ceo/how become ceo.mp3

      // application root dir
      Directory appDir = Directory('/storage/emulated/0/podPlayer');
      Directory subDir = Directory('${appDir.path}/$episodeTitle');
      // check if folder not exists created it
      if (await appDir.exists() == false) {
        await appDir.create();
        // sub folder with the episode title
        // check if episode title folder not exists to create
        if (await subDir.exists() == false) {
          await subDir.create();
        }
      }
      return DataSuccess('${subDir.path}/$fileName');
    } catch (e) {
      return const DataFailed('Something went wrong');
    }
  }

  SaveEpisodeRepositoryImpl({required this.downloadService});

  @override
  Future<DataState<bool>> saveEpisode(
      {required DownloadedEpisodeModel episodeData}) async {
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
    } on DioException {
      return const DataFailed('NetWork error ');
    } catch (e) {
      return const DataFailed('SomeThing went wrong');
    }
  }
}
/*  try {
      
    } on DioException catch (error) {
      return const DataFailed('Network Error');
    } catch (e) {
      return DataFailed('SomeThing went wrong');
    } */