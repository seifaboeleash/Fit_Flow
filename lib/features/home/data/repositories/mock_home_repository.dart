import '../../../../core/utils/api_result.dart';
import '../../domain/entities/active_plan.dart';
import '../../domain/entities/dashboard_data.dart';
import '../../domain/entities/dashboard_stats.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/entities/week_day.dart';
import '../../domain/repositories/home_repository.dart';

class MockHomeRepository implements HomeRepository {
  @override
  Future<ApiResult<DashboardData>> getDashboardData() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    try {
      final data = DashboardData(
        activePlan: const ActivePlan(
          title: 'Upper Body Basics',
          durationMinutes: 45,
          exerciseCount: 4,
        ),
        stats: const DashboardStats(recoveryPercentage: 94, weeklyBurn: 2450),
        weekDays: const [
          WeekDay(name: 'S', date: 12, isActive: true),
          WeekDay(name: 'S', date: 13),
          WeekDay(name: 'M', date: 14, isActive: true),
          WeekDay(name: 'T', date: 15),
          WeekDay(name: 'W', date: 16, isActive: true),
          WeekDay(name: 'T', date: 17),
          WeekDay(name: 'F', date: 18),
        ],
        todayExercises: const [
          Exercise(
            id: '1',
            name: 'Dumbbell Bench Press',
            targetMuscle: 'Chest & Triceps',
            sets: 3,
            reps: '8-10',
          ),
          Exercise(
            id: '2',
            name: 'Seated Cable Row',
            targetMuscle: 'Upper Back & Lats',
            sets: 3,
            reps: '10-12',
          ),
          Exercise(
            id: '3',
            name: 'Overhead Press',
            targetMuscle: 'Shoulders',
            sets: 3,
            reps: '8-10',
          ),
          Exercise(
            id: '4',
            name: 'Lateral Raises',
            targetMuscle: 'Deltoids',
            sets: 3,
            reps: '12-15',
          ),
        ],
      );

      return ApiSuccess(data);
    } catch (e) {
      return ApiFailure(Failure(e.toString()));
    }
  }
}
