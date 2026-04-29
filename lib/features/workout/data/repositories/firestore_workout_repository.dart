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

      // 2. Fetch .collection('workout_days').orderBy('dayNumber') -> list of days
      final daysSnapshot = await planDoc.reference
          .collection('workout_days')
          .orderBy('dayNumber')
          .get();

      List<WorkoutDay> workoutDays = [];

      for (var dayDoc in daysSnapshot.docs) {
        final dayData = dayDoc.data();

        // 3. For each day: .collection('day_exercises').orderBy('order') -> exercises
        final exercisesSnapshot = await dayDoc.reference
            .collection('day_exercises')
            .orderBy('order')
            .get();

        List<DayExercise> dayExercises = [];

        for (var exerciseDoc in exercisesSnapshot.docs) {
          final exData = exerciseDoc.data();
          final exerciseId = exData['exerciseId'] as String;

          // 4. For each exercise: exercises/{exerciseId} -> exercise details
          final exerciseDetailsDoc = await _firestore.collection('exercises').doc(exerciseId).get();
          Exercise? exerciseDetails;

          if (exerciseDetailsDoc.exists) {
            final detailsData = exerciseDetailsDoc.data()!;
            exerciseDetails = Exercise(
              id: exerciseDetailsDoc.id,
              name: detailsData['name'] ?? '',
              muscleGroup: detailsData['muscleGroup'] ?? '',
              equipment: detailsData['equipment'] ?? '',
              difficulty: detailsData['difficulty'] ?? '',
              gifUrl: detailsData['gifUrl'] ?? '',
              instructions: List<String>.from(detailsData['instructions'] ?? []),
              category: detailsData['category'] ?? '',
              targetMuscles: List<String>.from(detailsData['targetMuscles'] ?? []),
            );
          }

          dayExercises.add(DayExercise(
            exerciseId: exerciseId,
            order: exData['order'] as int? ?? 0,
            sets: exData['sets'] as int? ?? 0,
            reps: exData['reps'] as String? ?? '',
            restSeconds: exData['restSeconds'] as int? ?? 0,
            notes: exData['notes'] as String?,
            exerciseDetails: exerciseDetails,
          ));
        }

        workoutDays.add(WorkoutDay(
          dayNumber: dayData['dayNumber'] as int? ?? 0,
          name: dayData['name'] as String? ?? '',
          focus: dayData['focus'] as String? ?? '',
          exercises: dayExercises,
        ));
      }

      // 5. Assemble and return WorkoutPlan
      return WorkoutPlan(
        id: planDoc.id,
        name: planData['name'] as String? ?? '',
        goal: planData['goal'] as String? ?? '',
        daysPerWeek: planData['daysPerWeek'] as int? ?? 0,
        level: planData['level'] as String? ?? '',
        description: planData['description'] as String? ?? '',
        days: workoutDays,
      );
    } catch (e) {
      throw Exception('Failed to fetch workout plan: $e');
    }
  }
}
