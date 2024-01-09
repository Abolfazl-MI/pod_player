import 'package:bloc/bloc.dart';
import 'package:pod_player/app/core/resources/data_state.dart';
import 'package:pod_player/domain/entities/single_podcast/single_podcast_entity.dart';
import 'package:pod_player/domain/entities/subscription/subscription_entity.dart';
import 'package:pod_player/domain/repositories/subscription/subscription_repository.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final SubscriptionRepository subRepository;
  // final Podca
  SubscriptionCubit({required this.subRepository})
      : super(SubscriptionState.initial);

  subscribeToPodcast({required SinglePodcastEntity singlePodcastEntity})async{
    SubscriptionEntity subscriptionEntity=SubscriptionEntity(
      trackName: singlePodcastEntity.podcastName,
      artWorkUrl: singlePodcastEntity.image,
      subscriptionUrl: singlePodcastEntity.feedUrl
    );
    /// loading state
    emit(SubscriptionState.loading);
    await Future.delayed(const Duration(seconds: 2));

    /// try to add sub
    DataState result=await subRepository.createSub(entity: subscriptionEntity);
    /// check if subscription success to emit initial state
    if(result is DataSuccess){
      emit(SubscriptionState.subscribed);
    }else{
      emit(SubscriptionState.error);
      emit(SubscriptionState.unsibscribed);
    }
  }
  unSubscribeToPodcast({required String feedUrl})async{
    /// loading state
    emit(SubscriptionState.loading);
    await Future.delayed(const Duration(seconds: 2));

    /// try to add sub
    DataState result= subRepository.deleteSubWithUrl(feedUrl: feedUrl);
    /// check if subscription success to emit initial state
    if(result is DataSuccess){
      emit(SubscriptionState.unsibscribed);
    }else{
      emit(SubscriptionState.error);
      emit(SubscriptionState.unsibscribed);
    }
  }
  checkSubscription({required String urlFeed})async{
    emit(SubscriptionState.loading);
    await Future.delayed(const Duration(seconds: 3));
    DataState<bool> result= subRepository.checkSubscription(urlFeed: urlFeed);
    if(result is DataSuccess){
      if(result.data==true){
        emit(SubscriptionState.subscribed);
      }else{
        emit(SubscriptionState.unsibscribed);
      }
    }else{
      emit(SubscriptionState.error);
      emit(SubscriptionState.subscribed);
    }
  }
}
