import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:podcast_search/podcast_search.dart';

class CreateAudiSourceParams {
  final List<Episode> episodes;
  final String genre;

  CreateAudiSourceParams({required this.episodes, required this.genre});
}

FutureOr<List<MediaItem>> createAudioSource( CreateAudiSourceParams createAudiSourceParams) {
  List<MediaItem> mediaItems = [];
  for (Episode episode in createAudiSourceParams.episodes) {
    MediaItem mediaItem = MediaItem(
        id: episode.guid,
        title: episode.title,
        duration: episode.duration,
        artist: episode.author,
        artUri: Uri.parse(episode.imageUrl ?? ''),
        genre: createAudiSourceParams.genre,
        displayDescription: episode.description,
        extras: {
          'url': episode.contentUrl,
          'link': episode.contentUrl,
          'imageUrl': episode.imageUrl
        });
    mediaItems.add(mediaItem);
  }
  return mediaItems;
}
