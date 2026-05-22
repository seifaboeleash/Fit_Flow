import '../../../workout/domain/entities/workout_plan.dart';

class ActivePlan {
  final WorkoutPlan plan;
  final int durationMinutes;
  final int exerciseCount;

  const ActivePlan({
    required this.plan,
    required this.durationMinutes,
    required this.exerciseCount,
  });
}
