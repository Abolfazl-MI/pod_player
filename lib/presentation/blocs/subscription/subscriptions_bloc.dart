

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pod_player/app/core/resources/data_state.dart';
import 'package:pod_player/domain/entities/subscription/subscription_entity.dart';
import 'package:pod_player/domain/repositories/podcst/podcast_repository.dart';
import 'package:pod_player/domain/repositories/subscription/subscription_repository.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:rxdart/transformers.dart';

part 'subscriptions_event.dart';

part 'subscriptions_state.dart';

class SubscriptionsBloc extends Bloc<SubscriptionsEvent, SubscriptionState> {
  final SubscriptionRepository subscriptionRepository;
  final PodcastRepository podcastRepository;

  SubscriptionsBloc(
      {required this.podcastRepository, required this.subscriptionRepository})
      : super(SubscriptionInitialState()) {
    on<LoadFeedEvent>(_loadFeedEvent);
    on<SearchPodcastEvent>(_searchEvent);
    on<SubscribeToPodcast>(_subscribeToPodcast);
    on<UnSubscribeToPodcast>(_unSubscribe);
    on<CheckSubscriptionEvent>(_checkSub);
  }

  _loadFeedEvent(LoadFeedEvent event, Emitter<SubscriptionState> emit) async {
    // emit loading state
    emit(SubscriptionLoadingState());
    // get data from repository
    DataState<List<Item>> podcast = await podcastRepository.loadChartFeed();
    // check if datastate was succsfully to emi success state
    if (podcast is DataSuccess) {
      //  emit success state
      emit(SubscriptionLoadedState(podcast.data!));
    } else {
      //  here we have error so we emit error state
      emit(SubscriptionFailedState(podcast.error!));
    }
  }

  _searchEvent(SearchPodcastEvent event,
      Emitter<SubscriptionState> emit) async {
    // emit loading state
    emit(SubscriptionLoadingState());
    // search podcast from list of item
    DataState<List<Item>> podcasts =
    await podcastRepository.searchPodcast(query: event.query);
    // if data state is succ
    if (podcasts is DataSuccess) {
      List<Item> data = podcasts.data!;
      //  emit succss state
      emit(SubscriptionLoadedState(data));
    } else {
      // emit error state
      emit(SubscriptionFailedState(podcasts.error!));
    }
  }

  _subscribeToPodcast(SubscribeToPodcast event,
      Emitter<SubscriptionState> emit) {}

  _unSubscribe(UnSubscribeToPodcast event, Emitter<SubscriptionState> emit) {

  }

  _checkSub(CheckSubscriptionEvent event, Emitter<SubscriptionState> emit) {
  }
}
