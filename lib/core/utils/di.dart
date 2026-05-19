import 'package:get_it/get_it.dart';
import 'package:fit_flow/core/localization/locale_cubit.dart';
import 'package:fit_flow/config/app_config.dart';
import 'package:fit_flow/features/home/data/repositories/firebase_home_repository.dart';
import 'package:fit_flow/features/home/domain/repositories/home_repository.dart';
import 'package:fit_flow/features/home/presentation/cubit/home_cubit.dart';
import 'package:fit_flow/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:fit_flow/features/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:fit_flow/features/on_boarding/data/repositories/firebase_on_boarding_repository.dart';
import 'package:fit_flow/features/workout/domain/repositories/workout_repository.dart';
import 'package:fit_flow/features/workout/data/repositories/firestore_workout_repository.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt(EnvType envType) async {
  getIt.registerLazySingleton<AppConfig>(() => AppConfig.fromEnv(envType));

  // In-memory preferences map to replace Hive temporarily
  getIt.registerLazySingleton<Map<String, dynamic>>(
    () => <String, dynamic>{},
    instanceName: 'userPrefs',
  );

  // Firestore
  getIt.registerLazySingleton<WorkoutRepository>(
    () => FirestoreWorkoutRepository(),
  );

  // Repositories
  getIt.registerLazySingleton<HomeRepository>(
    () => FirebaseHomeRepository(
      workoutRepository: getIt<WorkoutRepository>(),
      prefsBox: getIt<Map<String, dynamic>>(instanceName: 'userPrefs'),
    ),
  );

  getIt.registerLazySingleton<OnBoardingRepository>(
    () => FirebaseOnBoardingRepository(
      prefsBox: getIt<Map<String, dynamic>>(instanceName: 'userPrefs'),
    ),
  );

  // Cubits
  getIt.registerFactory<LocaleCubit>(() =>
      LocaleCubit(getIt<Map<String, dynamic>>(instanceName: 'userPrefs')));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepository>()));
  getIt.registerFactory<OnBoardingCubit>(
      () => OnBoardingCubit(getIt<OnBoardingRepository>()));
}
