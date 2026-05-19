import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/workout_plan.dart';
import '../../domain/repositories/workout_repository.dart';

class FirestoreWorkoutRepository implements WorkoutRepository {
  final FirebaseFirestore _firestore;

  FirestoreWorkoutRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<WorkoutPlan> getPlanById(String planId) async {
    try {
      // 1. Fetch workout_plans/{planId} -> plan fields
      final planDoc = await _firestore
          .collection('workout_plans')
          .doc(planId)
          .get();

      if (!planDoc.exists) {
        throw Exception('Workout plan not found for ID: "$planId"');
      }

      final planData = planDoc.data()!;
      planData['id'] = planDoc.id;

      // 2. Fetch .collection('workout_days')
      final daysSnapshot = await planDoc.reference
          .collection('workout_days')
          .orderBy('day_number')
          .get()
          .catchError((_) => planDoc.reference.collection('workout_days').get());

      List<WorkoutDay> workoutDays = [];

      for (var dayDoc in daysSnapshot.docs) {
        final dayData = dayDoc.data();

        // 3. For each day: .collection('day_exercises')
        final exercisesSnapshot = await dayDoc.reference
            .collection('day_exercises')
            .get();

        List<DayExercise> dayExercises = [];

        for (var exerciseDoc in exercisesSnapshot.docs) {
          final exData = exerciseDoc.data();
          final exerciseId = exData['exercise_id'] ?? exData['exerciseId'] as String;

          // 4. For each exercise: exercises/{exerciseId} -> exercise details
          final exerciseDetailsDoc =
           await _firestore.collection('exercises').doc(exerciseId).get();
          Exercise? exerciseDetails;

          if (exerciseDetailsDoc.exists) {
            final detailsData = exerciseDetailsDoc.data()!;
            detailsData['id'] = exerciseDetailsDoc.id;
            exerciseDetails = Exercise.fromJson(detailsData);
          }

          dayExercises.add(DayExercise.fromJson(exData, exerciseDetails: exerciseDetails));
        }

        workoutDays.add(WorkoutDay.fromJson(dayData, exercises: dayExercises));
      }

      // 5. Assemble and return WorkoutPlan
      return WorkoutPlan.fromJson(planData, days: workoutDays);
    } catch (e) {
      throw Exception('Failed to fetch workout plan: $e');
    }
  }
}
