import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pod_player/app/core/params/subscribe_param.dart';
import 'package:pod_player/app/core/resources/data_state.dart';
import 'package:pod_player/domain/entities/subscription/single_podcast_entity.dart';
import 'package:pod_player/domain/repositories/podcst/podcast_repository.dart';
import 'package:pod_player/domain/repositories/subscription/subscription_repository.dart';
import 'package:podcast_search/podcast_search.dart';

part 'single_podcast_event.dart';

part 'single_podcast_state.dart';

class SinglePodcastBloc extends Bloc<SinglePodcastEvent, SinglePodcastState> {
  final SubscriptionRepository subscriptionRepository;
  final PodcastRepository podcastRepository;

  SinglePodcastBloc({
    required this.subscriptionRepository,
    required this.podcastRepository,
  }) : super(SinglePodInitialState()) {
    on<LoadPodcastDetial>(_loadDetails);
    on<CheckSubscription>(_checkSubscription);
  }

  void _loadDetails(LoadPodcastDetial event,
      Emitter<SinglePodcastState> emit) async {
    emit(SinglePodLoadingState());
    DataState<SinglePodcastEntity> result =
    await podcastRepository.loadPodcastFromItem(item: event.item);
    if (result is DataSuccess) {
      DataState<List<Item>> simillarItems =
      await podcastRepository.loadSimilarPodcasts(
          genre: event.item.primaryGenreName ??
              result.data?.genres?.first.name ??
              'podcast');

      emit(
        SinglePodLoaded(
          result.data!,
          simillarItems is DataSuccess ? simillarItems.data! : [],
        ),
      );
    } else {
      emit(SinglePodError('Something went wrong'));
    }
  }

//   // loading
//   emit(SinglePodLoadingState());
//   // try to load data form item
//   DataState<SinglePodcastEntity> dataResult =
//       await podcastRepository.loadPodcastFromItem(item: event.item);
//   // check if failed or succed
//   if ( dataResult is DataSuccess) {
//     //emit loaded body
//
//     emit(SinglePodLoaded(dataResult.data!));
//
//     await Future.delayed(Duration(seconds: 1);
//
//     // chcek for subscriptioin
//     /// emit sub loading
//     emit(SinglePodSubLoading());
//     // check the subs state
//     DataState<bool> subResult = subscriptionRepository.checkSubscription(
//         urlFeed: event.item.feedUrl!);
//     // if result was data succeed
//     if (subResult is DataSuccess) {
//       /// if result was true mean subscribed else not
//       if (subResult.data == true) {
//         emit(SinglePodSubscribed());
//       } else {
//         emit(SinglePodUnSubscribed());
//       }
//     } else {
//       // show failed snackbar and then show unsubscrbed
//       emit(SinglePodSubFailed('Something went wrong try again later'));
//       emit(SinglePodUnSubscribed());
//     }
//     // start loading for similar podcast
//     emit(SinglePodSimilarPodLoading());
//     // try to get simillar podcasts
//     DataState<List<Item>> similarResult =
//         await podcastRepository.loadSimilarPodcasts(
//             genre: event.item.primaryGenreName ??
//                 dataResult.data!.genres!.first.name);
//     // check if simillar has loaded
//     if (similarResult is DataSuccess) {
//       // emit loaded simillar podcast
//       emit(SinglePodSimilarPodLoaded(similarResult.data!));
//     } else {
//       //  emit failed state to show snak bar at UI
//       emit(SinglePodSimilarPodFailed('SomeThing went wrong'));
//       // emit loaded state with empty list to avoid ui loading freezing
//       emit(SinglePodSimilarPodLoaded([]));
//     }
//   } else {
//     // emit something went wrong
//     emit(SinglePodSimilarPodFailed('Some thing went wrong'));
//   }
// }

  _checkSubscription(CheckSubscription event,
      Emitter<SinglePodcastState> emit) async {
    emit(SinglePodSubLoading());
    // delay for sec
    await Future.delayed(const Duration(seconds: 2));
    //check sub
    DataState<bool>subResult = subscriptionRepository.checkSubscription(
        urlFeed: event.urlFeed);
    // if there is no error
    if (subResult is DataSuccess) {
      // check if subscribed or not
      bool hasSubscribed = subResult.data ?? false;
      if (hasSubscribed) {
        emit(SinglePodSubscribed());
      } else {
        emit(SinglePodUnSubscribed());
      }
    }else{
      emit(SinglePodSubFailed('something went wrong'));
      await Future.delayed(const Duration(seconds: 1));
      emit(SinglePodUnSubscribed());

    }
  }
}
