import '../entities/workout_plan.dart';

abstract class WorkoutRepository {
  Future<WorkoutPlan> getPlanById(String planId);
  Future<WorkoutPlan> getPlanByGoalAndDays(String goalId, int daysPerWeek);
}
