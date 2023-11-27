import 'package:equatable/equatable.dart';
import 'package:pod_player/domain/entities/subscription/subscription_entity.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

final class NoInternetConnection extends HomeState {
  @override
  List<Object?> get props => [];
  const NoInternetConnection();
}

final class HomeLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
  const HomeLoadingState();
}

final class HomeLoadedState extends HomeState {
  final List<SubscriptionEntity> subs;
  const HomeLoadedState(this.subs);
  @override
  List<Object?> get props => [subs];
}

final class HomeErrorState extends HomeState {
  final String error;
  const HomeErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

final class HomeInitialState extends HomeState {
  @override
  List<Object?> get props => [];
  const HomeInitialState();
}
