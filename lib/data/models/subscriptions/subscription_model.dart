import 'package:isar/isar.dart';
import 'package:pod_player/domain/entities/subscription/subscription_entity.dart';

part 'subscription_model.g.dart';

@collection
class SubscriptionModel {
  Id? id = Isar.autoIncrement;
  // store the track name
  String? trackName;
  // track artwork ulr
  String? artWorkUrl;
  // subscription link => feed link
  String? subscriptionUrl;
  // constructor
  SubscriptionModel(
      {this.artWorkUrl, this.subscriptionUrl, this.trackName, this.id});

  /// to entity
  SubscriptionEntity toEntity() => SubscriptionEntity(
      id: id,
      artWorkUrl: artWorkUrl,
      subscriptionUrl: subscriptionUrl,
      trackName: trackName);

  /// from Entity
  factory SubscriptionModel.fromEntity(SubscriptionEntity entity) =>
      SubscriptionModel(
          id: entity.id,
          artWorkUrl: entity.artWorkUrl,
          subscriptionUrl: entity.subscriptionUrl,
          trackName: entity.trackName);
}
