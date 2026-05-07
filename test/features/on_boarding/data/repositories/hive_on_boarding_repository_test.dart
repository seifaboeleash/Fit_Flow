import 'package:fit_flow/features/on_boarding/data/repositories/hive_on_boarding_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

class MockBox extends Mock implements Box {}

void main() {
  late MockBox mockPrefsBox;
  late HiveOnBoardingRepository repository;

  setUp(() {
    mockPrefsBox = MockBox();
    repository = HiveOnBoardingRepository(prefsBox: mockPrefsBox);
  });

  group('HiveOnBoardingRepository Tests', () {
    test('hasCompletedOnboarding returns true when activePlanId exists', () async {
      when(() => mockPrefsBox.containsKey('activePlanId')).thenReturn(true);

      final result = await repository.hasCompletedOnboarding();

      expect(result, isTrue);
      verify(() => mockPrefsBox.containsKey('activePlanId')).called(1);
    });

    test('hasCompletedOnboarding returns false when activePlanId is missing', () async {
      when(() => mockPrefsBox.containsKey('activePlanId')).thenReturn(false);

      final result = await repository.hasCompletedOnboarding();

      expect(result, isFalse);
    });

    test('savePreferences correctly saves multiple keys to Hive', () async {
      when(() => mockPrefsBox.put(any(), any())).thenAnswer((_) async => Future.value());

      await repository.savePreferences(goal: 'buildMuscle', daysPerWeek: 4);

      verify(() => mockPrefsBox.put('goal', 'buildMuscle')).called(1);
      verify(() => mockPrefsBox.put('daysPerWeek', 4)).called(1);
      verify(() => mockPrefsBox.put('activePlanId', 'buildMuscle_4days')).called(1);
      verify(() => mockPrefsBox.put('currentWeek', 1)).called(1);
      verify(() => mockPrefsBox.put('currentDay', 1)).called(1);
    });
  });
}
