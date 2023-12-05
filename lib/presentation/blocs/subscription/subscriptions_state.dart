part of 'subscriptions_bloc.dart';

sealed class SubscriptionState extends Equatable {
  SubscriptionState();
}

final class SubscriptionInitialState extends SubscriptionState {
  @override
  List<Object?> get props => [];
}

final class SubscriptionLoadingState extends SubscriptionState{
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}

final class SubscriptionLoadedState extends SubscriptionState{
  final List<Item>data;

  SubscriptionLoadedState(this.data);
  @override

  List<Object?> get props =>[data];

}

final class SubscriptionFailedState extends SubscriptionState{
    final String error;

  SubscriptionFailedState(this.error);

  @override
  List<Object?> get props => [error];
}

