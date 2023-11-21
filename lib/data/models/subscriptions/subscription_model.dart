import 'package:isar/isar.dart';

part 'subscription_model.g.dart';

@collection
class SubscriptionModel {
  Id id = Isar.autoIncrement;
  // store the track name
  String? trackName;
  // track artwork ulr
  String? artWorkUrl;
  // subscription link => feed link
  String? subscriptionUrl;
  SubscriptionModel({
    this.artWorkUrl,
    this.subscriptionUrl,
    this.trackName,
  });
}
