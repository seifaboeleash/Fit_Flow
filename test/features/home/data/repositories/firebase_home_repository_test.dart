import 'dart:convert';
import 'package:fit_flow/core/utils/api_result.dart';
import 'package:fit_flow/features/home/data/repositories/firebase_home_repository.dart';
import 'package:fit_flow/features/home/domain/entities/dashboard_data.dart';
import 'package:fit_flow/features/workout/domain/entities/workout_plan.dart';
import 'package:fit_flow/features/workout/domain/repositories/workout_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

class MockWorkoutRepository extends Mock implements WorkoutRepository {}
class MockBox extends Mock implements Box {}

void main() {
  late MockWorkoutRepository mockWorkoutRepo;
  late MockBox mockPrefsBox;
  late MockBox mockPlanCacheBox;
  late FirebaseHomeRepository repository;

  final testPlanId = 'buildMuscle_3days';
  final  testPlan = WorkoutPlan(
    id: testPlanId,
    name: 'Test Plan',
    goal: 'buildMuscle',
    daysPerWeek: 3,
    level: 'Beginner',
    description: 'Test',
    days: [
      WorkoutDay(
        dayNumber: 1,
        name: 'Day 1',
        focus: 'Full Body',
        exercises: [],
      )
    ],
  );

  setUp(() {
    mockWorkoutRepo = MockWorkoutRepository();
    mockPrefsBox = MockBox();
    mockPlanCacheBox = MockBox();

    // Setup basic prefs
    when(() => mockPrefsBox.get('activePlanId')).thenReturn(testPlanId);
    when(() => mockPrefsBox.get('currentDay', defaultValue: 1)).thenReturn(1);
    
    // We must mock put() so tests don't crash when it tries to save cache
    when(() => mockPlanCacheBox.put(any(), any())).thenAnswer((_) async => Future.value());

    repository = FirebaseHomeRepository(
      workoutRepository: mockWorkoutRepo,
      prefsBox: mockPrefsBox,
      planCacheBox: mockPlanCacheBox,
    );
  });

  group('FirebaseHomeRepository Caching Logic', () {
    test('returns ApiFailure when no planId is found in user preferences', () async {
      when(() => mockPrefsBox.get('activePlanId')).thenReturn(null);

      final result = await repository.getDashboardData();

      expect(result, isA<ApiFailure<DashboardData>>());
      final failure = (result as ApiFailure).failure;
      expect(failure.message, contains('Onboarding not completed'));
    });

    test('uses Hive cache and DOES NOT call Firestore if data is < 24 hours old', () async {
      // Setup mock cache < 24 hours old
      final recentTimestamp = DateTime.now().millisecondsSinceEpoch - (1000 * 60 * 60 * 12); // 12 hours old
      
      when(() => mockPlanCacheBox.get('cached_plan_$testPlanId'))
          .thenReturn(jsonEncode(testPlan.toJson()));
      when(() => mockPlanCacheBox.get('cache_timestamp_$testPlanId'))
          .thenReturn(recentTimestamp);

      final result = await repository.getDashboardData();

      // Verify success
      expect(result, isA<ApiSuccess<DashboardData>>());
      
      // Verify Firestore was NOT called
      verifyNever(() => mockWorkoutRepo.getPlanById(any()));
    });

    test('calls Firestore if Hive cache is empty', () async {
      // Empty cache
      when(() => mockPlanCacheBox.get(any())).thenReturn(null);
      
      // Setup Firestore mock
      when(() => mockWorkoutRepo.getPlanById(testPlanId))
          .thenAnswer((_) async => testPlan);

      final result = await repository.getDashboardData();

      // Verify success
      expect(result, isA<ApiSuccess<DashboardData>>());
      
      // Verify Firestore WAS called exactly once
      verify(() => mockWorkoutRepo.getPlanById(testPlanId)).called(1);
      
      // Verify the new data was saved to the cache
      verify(() => mockPlanCacheBox.put('cached_plan_$testPlanId', jsonEncode(testPlan.toJson()))).called(1);
      verify(() => mockPlanCacheBox.put('cache_timestamp_$testPlanId', any())).called(1);
    });

    test('calls Firestore if Hive cache is > 24 hours old (expired)', () async {
      // Setup expired cache
      final oldTimestamp = DateTime.now().millisecondsSinceEpoch - (1000 * 60 * 60 * 25); // 25 hours old
      
      when(() => mockPlanCacheBox.get('cached_plan_$testPlanId'))
          .thenReturn(jsonEncode(testPlan.toJson()));
      when(() => mockPlanCacheBox.get('cache_timestamp_$testPlanId'))
          .thenReturn(oldTimestamp);
          
      // Setup Firestore mock
      when(() => mockWorkoutRepo.getPlanById(testPlanId))
          .thenAnswer((_) async => testPlan);

      final result = await repository.getDashboardData();

      // Verify success
      expect(result, isA<ApiSuccess<DashboardData>>());
      
      // Verify Firestore WAS called because cache expired
      verify(() => mockWorkoutRepo.getPlanById(testPlanId)).called(1);
    });
  });
}
