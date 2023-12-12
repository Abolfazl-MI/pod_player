import 'package:pod_player/app/core/resources/data_state.dart';
import 'package:pod_player/domain/entities/subscription/subscription_entity.dart';

abstract interface class SubscriptionRepository {
  Future<DataState<List<SubscriptionEntity>>> getAllSubs();
  Future<DataState<SubscriptionEntity>> getSingleSub({required int id});
  Future<DataState> createSub({required SubscriptionEntity entity});
  DataState deleteSub({required int id});
  DataState<bool>checkSubscription({required String urlFeed});
}
