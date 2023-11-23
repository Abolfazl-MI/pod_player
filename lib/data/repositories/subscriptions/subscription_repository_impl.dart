import 'package:flutter/foundation.dart';
import 'package:pod_player/app/core/resources/data_state.dart';
import 'package:pod_player/data/models/subscriptions/subscription_model.dart';
import 'package:pod_player/data/providers/data_source/local/subscriptions/subscription_provider.dart';
import 'package:pod_player/domain/entities/subscription/subscription_entity.dart';
import 'package:pod_player/domain/repositories/subscription/subscription_repository.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SubscriptionProvider _subscriptionProvider;

  SubscriptionRepositoryImpl(this._subscriptionProvider);

  @override
  Future<DataState> createSub({required SubscriptionEntity entity}) async {
    try {
      await _subscriptionProvider.create(
          model: SubscriptionModel.fromEntity(entity));
      return DataSuccess(true);
    } catch (e) {
      debugPrint(e.toString());
      return DataFailed('در دنبال کردن این پادکست مشکلی پیش آمده است');
    }
  }

  @override
  DataState deleteSub({required int id}) {
    try {
      _subscriptionProvider.deleteSub(id: id);
      return DataSuccess(true);
    } catch (e) {
      debugPrint(e.toString());

      return DataFailed('مشکلی پیش امده بعدا تلاش کنید');
    }
  }

  @override
  Future<DataState<List<SubscriptionEntity>>> getAllSubs() async {
    try {
      List<SubscriptionModel> result = await _subscriptionProvider.getAllSubs();
      List<SubscriptionEntity> subscription =
          List.from(result.map((e) => e.toEntity()));
      return DataSuccess(subscription);
    } catch (e) {
      debugPrint(e.toString());

      return DataFailed('مشکلی پیش آمده دوباره تلاش کنید');
    }
  }

  @override
  Future<DataState<SubscriptionEntity>> getSingleSub({required int id}) async {
    try {
      SubscriptionModel? dataModel =
          await _subscriptionProvider.getSingleSub(id: id);
      if (dataModel != null) {
        return DataSuccess(dataModel.toEntity());
      } else {
        return DataFailed('پادکست مورد نظر یافت نشد');
      }
    } catch (e) {
      debugPrint(e.toString());
      return DataFailed('مشکلی پیش آمده دوباره تلاش کنید');
    }
  }
}
