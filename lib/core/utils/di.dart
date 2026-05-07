import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:fit_flow/config/app_config.dart';
import 'package:fit_flow/features/home/data/repositories/firebase_home_repository.dart';
import 'package:fit_flow/features/home/domain/repositories/home_repository.dart';
import 'package:fit_flow/features/home/presentation/cubit/home_cubit.dart';
import 'package:fit_flow/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:fit_flow/features/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:fit_flow/features/on_boarding/data/repositories/hive_on_boarding_repository.dart';
import 'package:fit_flow/features/workout/domain/repositories/workout_repository.dart';
import 'package:fit_flow/features/workout/data/repositories/firestore_workout_repository.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt(EnvType envType) async {
  getIt.registerLazySingleton<AppConfig>(() => AppConfig.fromEnv(envType));

  // Hive box (open before registering)
  final userPrefsBox = await Hive.openBox('user_preferences');
  getIt.registerLazySingleton<Box>(
    () => userPrefsBox,
    instanceName: 'userPrefs',
  );

  final planCacheBox = await Hive.openBox('plan_cache');
  getIt.registerLazySingleton<Box>(
    () => planCacheBox,
    instanceName: 'planCache',
  );

  // Firestore
  getIt.registerLazySingleton<WorkoutRepository>(
    () => FirestoreWorkoutRepository(),
  );

  // Repositories
  getIt.registerLazySingleton<HomeRepository>(
    () => FirebaseHomeRepository(
      workoutRepository: getIt<WorkoutRepository>(),
      prefsBox: getIt<Box>(instanceName: 'userPrefs'),
      planCacheBox: getIt<Box>(instanceName: 'planCache'),
    ),
  );

  getIt.registerLazySingleton<OnBoardingRepository>(
    () => HiveOnBoardingRepository(
      prefsBox: getIt<Box>(instanceName: 'userPrefs'),
    ),
  );

  // Cubits
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepository>()));
  getIt.registerFactory<OnBoardingCubit>(() => OnBoardingCubit(getIt<OnBoardingRepository>()));  
}
