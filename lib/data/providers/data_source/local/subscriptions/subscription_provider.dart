import 'package:isar/isar.dart';
import 'package:pod_player/data/models/subscriptions/subscription_model.dart';

class SubscriptionProvider {
  final Isar _isarInstance;

  SubscriptionProvider(this._isarInstance);

  /// create subscription model
  Future<void> create({required SubscriptionModel model}) async {
    await _isarInstance.writeTxn(() async {
      await _isarInstance.subscriptionModels.put(model);
    });
  }
// connectivity
  /// read all subscriptions
  Future<List<SubscriptionModel>> getAllSubs() async {
    return await _isarInstance.subscriptionModels.where().findAll();
  }

  /// read single subscription within id
  Future<SubscriptionModel?> getSingleSub({required int id}) async {
    return await _isarInstance.subscriptionModels.get(id);
  }

  /// delete subscription
  void deleteSub({required int id}) {
    _isarInstance.subscriptionModels.deleteSync(id);
  }
}
