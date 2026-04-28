import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/api_result.dart';
import '../../domain/entities/dashboard_data.dart';
import '../../domain/repositories/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;

  HomeCubit(this._homeRepository) : super(const HomeLoading());

  Future<void> loadDashboardData() async {
    emit(const HomeLoading());
    final result = await _homeRepository.getDashboardData();

    switch (result) {
      case ApiSuccess(:final data):
        emit(HomeLoaded(data));
      case ApiFailure(:final failure):
        emit(HomeError(failure.message));
    }
  }
}
