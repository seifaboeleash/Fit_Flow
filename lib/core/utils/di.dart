import 'package:get_it/get_it.dart';
import 'package:fit_flow/features/home/data/repositories/mock_home_repository.dart';
import 'package:fit_flow/features/home/domain/repositories/home_repository.dart';
import 'package:fit_flow/features/home/presentation/cubit/home_cubit.dart';
import 'package:fit_flow/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // Repositories
  getIt.registerLazySingleton<HomeRepository>(() => MockHomeRepository());

  // Cubits
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepository>()));
  getIt.registerFactory<OnBoardingCubit>(() => OnBoardingCubit());  
}
