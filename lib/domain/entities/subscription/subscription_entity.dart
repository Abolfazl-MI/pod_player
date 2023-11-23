class SubscriptionEntity {
  int ?id;
  // store the track name
  String? trackName;
  // track artwork ulr
  String? artWorkUrl;
  // subscription link => feed link
  String? subscriptionUrl;
  // constructor
  SubscriptionEntity({
    this.id,
    this.artWorkUrl,
    this.subscriptionUrl,
    this.trackName,
  });
}
