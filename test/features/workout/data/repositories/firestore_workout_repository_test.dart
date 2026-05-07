import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_flow/features/workout/data/repositories/firestore_workout_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mocks for Firebase Firestore
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
// ignore: subtype_of_sealed_class
class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
// ignore: subtype_of_sealed_class
class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {}
// ignore: subtype_of_sealed_class
class MockDocumentSnapshot extends Mock implements DocumentSnapshot<Map<String, dynamic>> {}
// ignore: subtype_of_sealed_class
class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot<Map<String, dynamic>> {}
class MockQuerySnapshot extends Mock implements QuerySnapshot<Map<String, dynamic>> {}

void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockPlansCollection;
  late MockDocumentReference mockPlanDocRef;
  late MockDocumentSnapshot mockPlanSnapshot;
  late FirestoreWorkoutRepository repository;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockPlansCollection = MockCollectionReference();
    mockPlanDocRef = MockDocumentReference();
    mockPlanSnapshot = MockDocumentSnapshot();

    // Base setup for getting a document from the plans collection
    when(() => mockFirestore.collection('workout_plans')).thenReturn(mockPlansCollection);
    when(() => mockPlansCollection.doc('test_plan')).thenReturn(mockPlanDocRef);

    repository = FirestoreWorkoutRepository(firestore: mockFirestore);
  });

  group('FirestoreWorkoutRepository Tests', () {
    test('throws Exception if planDoc does not exist', () async {
      when(() => mockPlanDocRef.get()).thenAnswer((_) async => mockPlanSnapshot);
      when(() => mockPlanSnapshot.exists).thenReturn(false);

      expect(
        () => repository.getPlanById('test_plan'),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('Workout plan not found for ID: "test_plan"'))),
      );
    });

    test('correctly fetches nested Plan -> Days -> Exercises', () async {
      // 1. Mock the Plan Document
      when(() => mockPlanDocRef.get()).thenAnswer((_) async => mockPlanSnapshot);
      when(() => mockPlanSnapshot.exists).thenReturn(true);
      when(() => mockPlanSnapshot.id).thenReturn('test_plan');
      when(() => mockPlanSnapshot.data()).thenReturn({
        'name': 'Test Plan',
        'goal': 'buildMuscle',
        'daysPerWeek': 3,
        'level': 'Beginner',
        'description': 'Desc',
      });
      when(() => mockPlanSnapshot.reference).thenReturn(mockPlanDocRef);

      // 2. Mock the Days Subcollection
      final mockDaysCollection = MockCollectionReference();
      final mockDaysSnapshot = MockQuerySnapshot();
      final mockDayDoc = MockQueryDocumentSnapshot();

      when(() => mockPlanDocRef.collection('workout_days')).thenReturn(mockDaysCollection);
      when(() => mockDaysCollection.orderBy('dayNumber')).thenReturn(mockDaysCollection); // Simplification for test
      when(() => mockDaysCollection.get()).thenAnswer((_) async => mockDaysSnapshot);
      
      when(() => mockDaysSnapshot.docs).thenReturn([mockDayDoc]);
      when(() => mockDayDoc.data()).thenReturn({
        'dayNumber': 1,
        'name': 'Day 1',
        'focus': 'Full Body',
      });
      when(() => mockDayDoc.reference).thenReturn(mockPlanDocRef); // Reusing ref for simplicity

      // 3. Mock the Exercises Subcollection
      final mockDayExercisesCollection = MockCollectionReference();
      final mockExercisesSnapshot = MockQuerySnapshot();
      final mockExerciseDoc = MockQueryDocumentSnapshot();

      when(() => mockPlanDocRef.collection('day_exercises')).thenReturn(mockDayExercisesCollection);
      when(() => mockDayExercisesCollection.orderBy('order')).thenReturn(mockDayExercisesCollection);
      when(() => mockDayExercisesCollection.get()).thenAnswer((_) async => mockExercisesSnapshot);

      when(() => mockExercisesSnapshot.docs).thenReturn([mockExerciseDoc]);
      when(() => mockExerciseDoc.data()).thenReturn({
        'exerciseId': 'ex_bench',
        'order': 1,
        'sets': 3,
        'reps': '10',
        'restSeconds': 60,
      });

      // 4. Mock the Global Exercise Details fetch
      final mockGlobalExercisesCollection = MockCollectionReference();
      final mockGlobalExerciseDocRef = MockDocumentReference();
      final mockGlobalExerciseSnapshot = MockDocumentSnapshot();

      when(() => mockFirestore.collection('exercises')).thenReturn(mockGlobalExercisesCollection);
      when(() => mockGlobalExercisesCollection.doc('ex_bench')).thenReturn(mockGlobalExerciseDocRef);
      when(() => mockGlobalExerciseDocRef.get()).thenAnswer((_) async => mockGlobalExerciseSnapshot);
      
      when(() => mockGlobalExerciseSnapshot.exists).thenReturn(true);
      when(() => mockGlobalExerciseSnapshot.id).thenReturn('ex_bench');
      when(() => mockGlobalExerciseSnapshot.data()).thenReturn({
        'name': 'Bench Press',
        'muscleGroup': 'Chest',
        'equipment': 'Barbell',
        'difficulty': 'Int',
        'gifUrl': '',
        'instructions': [],
        'category': 'Str',
        'targetMuscles': []
      });

      // Execute
      final plan = await repository.getPlanById('test_plan');

      // Assertions
      expect(plan.id, 'test_plan');
      expect(plan.days.length, 1);
      expect(plan.days.first.dayNumber, 1);
      expect(plan.days.first.exercises.length, 1);
      expect(plan.days.first.exercises.first.exerciseId, 'ex_bench');
      expect(plan.days.first.exercises.first.exerciseDetails!.name, 'Bench Press');

      // Verifications
      verify(() => mockPlanDocRef.get()).called(1);
      verify(() => mockDaysCollection.get()).called(1);
      verify(() => mockDayExercisesCollection.get()).called(1);
      verify(() => mockGlobalExerciseDocRef.get()).called(1);
    });
  });
}
