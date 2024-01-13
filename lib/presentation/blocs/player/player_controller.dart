import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/app/core/services/getit.dart';
import 'package:pod_player/data/providers/data_source/local/audio_service/audio_service.dart';

class PlayerController {
  final AudioHandler _audioHandler;

  ValueNotifier<bool> playState = ValueNotifier(false);
  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );
  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);
  final currentSongDetailNotifier = ValueNotifier<MediaItem>(const MediaItem(
    id: '-1',
    title: '',
  ));
  final playlistNotifier = ValueNotifier<List<MediaItem>>([]);
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final repeatStateNotifier = RepeatStateNotifier();
  final volumeStateNotifier = ValueNotifier<double>(1);
  bool onBackPressed = false;

  PlayerController(this._audioHandler) {
    init();
  }

  void init() async {
    // await _loadPlaylist();
    _listenToChangeInPlaylist();
    _listenToPlaybackState();
    _listenToCurrentPosition();
    _listenToBufferedPosition();
    _listenToTotalDuration();
    _listenToChangesInSong();
  }

  // Future _loadPlaylist() async {
  //
  // }

  void _listenToChangeInPlaylist() {
    log('playlist changing....');
    _audioHandler.queue.listen((playlist) {
      // log(
      //   'playlist =>....${playlist.toString()}',
      //   name: 'playlist logger',
      // );
      log('playlist length=>${playlist.length}');
      if (playlist.isEmpty) return;
      final newList = playlist.map((item) => item).toList();
      playlistNotifier.value = newList;
    });
  }

  void _listenToPlaybackState() {
    _audioHandler.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;
      debugPrint('playback state is=>$processingState');
      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        buttonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        buttonNotifier.value = ButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        buttonNotifier.value = ButtonState.playing;
        playState.value = true;
      } else {
        _audioHandler.seek(Duration.zero);
        _audioHandler.pause();
      }
    });
  }

  void _listenToCurrentPosition() {
    AudioService.position.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenToBufferedPosition() {
    _audioHandler.playbackState.listen((playbackState) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: playbackState.bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenToTotalDuration() {
    _audioHandler.mediaItem.listen((mediaItem) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: mediaItem?.duration ?? Duration.zero,
      );
    });
  }

  void _listenToChangesInSong() {
    _audioHandler.mediaItem.listen((mediaItem) {
      currentSongDetailNotifier.value =
          mediaItem ?? const MediaItem(id: '-1', title: '');
      _updateSkipButtons();
    });
  }

  void _updateSkipButtons() {
    final mediaItem = _audioHandler.mediaItem.value;
    final playlist = _audioHandler.queue.value;
    if (playlist.length < 2 || mediaItem == null) {
      isFirstSongNotifier.value = true;
      isLastSongNotifier.value = true;
    } else {
      isFirstSongNotifier.value = playlist.first == mediaItem;
      isLastSongNotifier.value = playlist.last == mediaItem;
    }
  }

  void onVolumePressed() {
    if (volumeStateNotifier.value != 0) {
      _audioHandler.androidSetRemoteVolume(0);
      volumeStateNotifier.value = 0;
    } //
    else {
      _audioHandler.androidSetRemoteVolume(1);
      volumeStateNotifier.value = 1;
    }
  }

  void play() async {
    _audioHandler.play();
  }

  void pause() {
    _audioHandler.pause();
  }

  void seek(position) {
    _audioHandler.seek(position);
  }

  void playFromPlaylist(int index) {
    _audioHandler.skipToQueueItem(index);
  }

  void onPreviousPressed() {
    _audioHandler.skipToPrevious();
  }

  void onNextPressed() {
    _audioHandler.skipToNext();
  }

  void onRepeatPressed() {
    repeatStateNotifier.nextState();
    switch (repeatStateNotifier.value) {
      case repeatState.off:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
        break;
      case repeatState.one:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
        break;
      case repeatState.all:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
        break;
    }
  }

  void dispose() {
    _audioHandler.customAction('dispose');
  }

  void stop() {
    _audioHandler.stop();
  }
}

class ProgressBarState {
  final Duration current;
  final Duration buffered;
  final Duration total;

  ProgressBarState(
      {required this.current, required this.buffered, required this.total});
}

enum ButtonState { paused, playing, loading }

enum repeatState { off, one, all }

class RepeatStateNotifier extends ValueNotifier<repeatState> {
  RepeatStateNotifier() : super(_initialValue);
  static const _initialValue = repeatState.off;

  void nextState() {
    var next = (value.index + 1) % repeatState.values.length;
    value = repeatState.values[next];
  }
}
