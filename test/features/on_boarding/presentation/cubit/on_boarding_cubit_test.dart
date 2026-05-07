import 'package:fit_flow/features/on_boarding/domain/entities/workout_goal.dart';
import 'package:fit_flow/features/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:fit_flow/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnBoardingRepository extends Mock implements OnBoardingRepository {}

void main() {
  late MockOnBoardingRepository mockRepository;
  late OnBoardingCubit cubit;

  setUp(() {
    mockRepository = MockOnBoardingRepository();
    cubit = OnBoardingCubit(mockRepository);
  });

  tearDown(() {
    cubit.close();
  });

  group('OnBoardingCubit Tests', () {
    test('initial state should be OnBoardingUpdated with no goal and 3 days', () {
      final state = cubit.state;
      expect(state, isA<OnBoardingUpdated>());
      if (state is OnBoardingUpdated) {
        expect(state.selectedGoal, isNull);
        expect(state.selectedDays, 3);
      }
    });

    blocTest<OnBoardingCubit, OnBoardingState>(
      'emits [OnBoardingUpdated] when selectGoal is called',
      build: () => cubit,
      act: (cubit) => cubit.selectGoal(WorkoutGoal.buildMuscle),
      expect: () => [
        isA<OnBoardingUpdated>()
            .having((s) => s.selectedGoal, 'selectedGoal', WorkoutGoal.buildMuscle)
            .having((s) => s.selectedDays, 'selectedDays', 3),
      ],
    );

    blocTest<OnBoardingCubit, OnBoardingState>(
      'emits [OnBoardingUpdated] when selectDays is called',
      build: () => cubit,
      act: (cubit) => cubit.selectDays(5),
      expect: () => [
        isA<OnBoardingUpdated>()
            .having((s) => s.selectedGoal, 'selectedGoal', isNull)
            .having((s) => s.selectedDays, 'selectedDays', 5),
      ],
    );

    blocTest<OnBoardingCubit, OnBoardingState>(
      'emits [OnBoardingLoading, OnBoardingSuccess] when completeOnboarding is successful',
      build: () {
        when(() => mockRepository.savePreferences(
              goal: any(named: 'goal'),
              daysPerWeek: any(named: 'daysPerWeek'),
            )).thenAnswer((_) async => Future.value());
        return cubit;
      },
      act: (cubit) async {
        cubit.selectGoal(WorkoutGoal.getStrong);
        await cubit.completeOnboarding();
      },
      expect: () => [
        isA<OnBoardingUpdated>(), // from selectGoal
        isA<OnBoardingLoading>(),
        isA<OnBoardingSuccess>(),
      ],
      verify: (_) {
        verify(() => mockRepository.savePreferences(
              goal: 'getStrong',
              daysPerWeek: 3,
            )).called(1);
      },
    );

    blocTest<OnBoardingCubit, OnBoardingState>(
      'emits [OnBoardingLoading, OnBoardingError] when completeOnboarding fails',
      build: () {
        when(() => mockRepository.savePreferences(
              goal: any(named: 'goal'),
              daysPerWeek: any(named: 'daysPerWeek'),
            )).thenThrow(Exception('Failed to save'));
        return cubit;
      },
      act: (cubit) async {
        cubit.selectGoal(WorkoutGoal.generalFitness);
        await cubit.completeOnboarding();
      },
      expect: () => [
        isA<OnBoardingUpdated>(),
        isA<OnBoardingLoading>(),
        isA<OnBoardingError>().having((s) => s.message, 'message', 'Exception: Failed to save'),
      ],
    );
  });
}
