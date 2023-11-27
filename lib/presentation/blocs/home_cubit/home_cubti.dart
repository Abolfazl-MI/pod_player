import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_player/app/core/resources/connectivity_status.dart';
import 'package:pod_player/app/core/resources/data_state.dart';
import 'package:pod_player/data/providers/data_source/local/connectivity/connectivity_provider.dart';
import 'package:pod_player/domain/entities/subscription/subscription_entity.dart';
import 'package:pod_player/domain/repositories/subscription/subscription_repository.dart';
import 'package:pod_player/presentation/blocs/home_cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ConnectivityProvider connectivityProvider;
  final SubscriptionRepository subRepository;
  HomeCubit({required this.connectivityProvider, required this.subRepository})
      : super(HomeInitialState());

  loadHomeFeed() async {
    // loading state
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 4));
    // check internet connection
    DataState<AppConnectivityStatus> internetConnectivity =
        await connectivityProvider.checkInternet();
    // when checking go right
    if (internetConnectivity is DataSuccess) {
      // if no connection
      if (internetConnectivity.data == AppConnectivityStatus.disconnected) {
        emit(NoInternetConnection());
        return;
      }
      // here we have internet so we could load our feeds from db
      var result = await subRepository.getAllSubs();

      // if we face error
      if (result is DataFailed) {
        emit(HomeErrorState(result.error!));
      }
      // here we have internet and no error so feed loaded from db
      emit(HomeLoadedState(
        result.data!,
      ));
    } else {
      // error in checking internet connection
      emit(HomeErrorState(internetConnectivity.error!));
    }
  }
}
