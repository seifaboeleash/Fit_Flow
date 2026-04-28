import '../../domain/entities/active_plan.dart';
import '../../domain/entities/dashboard_stats.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/entities/week_day.dart';

class DashboardData {
  final ActivePlan activePlan;
  final List<Exercise> todayExercises;
  final DashboardStats stats;
  final List<WeekDay> weekDays;

  const DashboardData({
    required this.activePlan,
    required this.todayExercises,
    required this.stats,
    required this.weekDays,
  });
}
