import 'package:bloc_test/bloc_test.dart';
import 'package:fit_flow/core/utils/api_result.dart';
import 'package:fit_flow/features/home/domain/entities/active_plan.dart';
import 'package:fit_flow/features/home/domain/entities/dashboard_data.dart';
import 'package:fit_flow/features/home/domain/entities/dashboard_stats.dart';
import 'package:fit_flow/features/home/domain/repositories/home_repository.dart';
import 'package:fit_flow/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late MockHomeRepository mockRepository;
  late HomeCubit cubit;

  final testDashboardData = DashboardData(
    activePlan: const ActivePlan(title: 'Test', durationMinutes: 30, exerciseCount: 5),
    stats: const DashboardStats(recoveryPercentage: 100, weeklyBurn: 0),
    weekDays: const [],
    todayExercises: const [],
  );

  setUp(() {
    mockRepository = MockHomeRepository();
    cubit = HomeCubit(mockRepository);
  });

  tearDown(() {
    cubit.close();
  });

  group('HomeCubit Tests', () {
    test('initial state should be HomeLoading', () {
      expect(cubit.state, isA<HomeLoading>());
    });

    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoading, HomeLoaded] when loadDashboardData is successful',
      build: () {
        when(() => mockRepository.getDashboardData())
            .thenAnswer((_) async => ApiSuccess(testDashboardData));
        return cubit;
      },
      act: (cubit) => cubit.loadDashboardData(),
      expect: () => [
        isA<HomeLoading>(),
        isA<HomeLoaded>().having((s) => s.data, 'data', testDashboardData),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoading, HomeError] when loadDashboardData fails',
      build: () {
        when(() => mockRepository.getDashboardData())
            .thenAnswer((_) async => ApiFailure(Failure('Failed to load dashboard data')));
        return cubit;
      },
      act: (cubit) => cubit.loadDashboardData(),
      expect: () => [
        isA<HomeLoading>(),
        isA<HomeError>().having((s) => s.message, 'message', 'Failed to load dashboard data'),
      ],
    );
  });
}
