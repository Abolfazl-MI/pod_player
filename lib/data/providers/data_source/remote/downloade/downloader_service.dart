import 'package:dio/dio.dart';

class DownloaderService {
  final Dio dio;

  DownloaderService(this.dio);
  CancelToken _cancelToken = CancelToken();
  // download everything given url
  Future<Response> downloadEpisode(String url) async {
    dio.options.responseType = ResponseType.bytes;
    return dio.get(url);
  }

   cancelReq() {
    _cancelToken.cancel();
  }
}
