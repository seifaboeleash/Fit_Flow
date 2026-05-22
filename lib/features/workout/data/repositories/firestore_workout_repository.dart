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

      // Parse the plan to extract the embedded workouts
      final plan = WorkoutPlan.fromJson(planData);

      List<WorkoutDay> populatedDays = [];

      for (var day in plan.days) {
        List<DayExercise> populatedExercises = [];

        for (var ex in day.exercises) {
          final exerciseId = ex.exerciseId;
          final exerciseDetailsDoc =
              await _firestore.collection('exercises').doc(exerciseId).get();
          
          Exercise? exerciseDetails;
          if (exerciseDetailsDoc.exists) {
            final detailsData = exerciseDetailsDoc.data()!;
            detailsData['id'] = exerciseDetailsDoc.id;
            exerciseDetails = Exercise.fromJson(detailsData);
          }

          populatedExercises.add(ex.copyWith(exerciseDetails: exerciseDetails));
        }

        populatedDays.add(WorkoutDay(
          dayNumber: day.dayNumber,
          focusEn: day.focusEn,
          focusAr: day.focusAr,
          exercises: populatedExercises,
        ));
      }

      return WorkoutPlan(
        id: plan.id,
        goalId: plan.goalId,
        daysPerWeek: plan.daysPerWeek,
        planNameEn: plan.planNameEn,
        planNameAr: plan.planNameAr,
        descriptionEn: plan.descriptionEn,
        descriptionAr: plan.descriptionAr,
        days: populatedDays,
      );
    } catch (e) {
      throw Exception('Failed to fetch workout plan: $e');
    }
  }

  @override
  Future<WorkoutPlan> getPlanByGoalAndDays(String goalId, int daysPerWeek) async {
    try {
      final querySnapshot = await _firestore
          .collection('workout_plans')
          .where('goal_id', isEqualTo: goalId)
          .where('days_per_week', isEqualTo: daysPerWeek)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception('Workout plan not found for goal: "$goalId" and days: "$daysPerWeek"');
      }

      return await getPlanById(querySnapshot.docs.first.id);
    } catch (e) {
      throw Exception('Failed to fetch workout plan by goal and days: $e');
    }
  }
}
