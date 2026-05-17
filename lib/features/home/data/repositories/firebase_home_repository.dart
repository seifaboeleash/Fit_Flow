import '../../../../core/utils/api_result.dart';
import '../../../workout/domain/entities/workout_plan.dart';
import '../../../workout/domain/repositories/workout_repository.dart';
import '../../domain/entities/active_plan.dart';
import '../../domain/entities/dashboard_data.dart';
import '../../domain/entities/dashboard_stats.dart';
import '../../domain/entities/week_day.dart';
import '../../domain/repositories/home_repository.dart';

class OnboardingIncompleteException implements Exception {
  final String message;
  OnboardingIncompleteException([this.message = 'Onboarding not completed']);

  @override
  String toString() => message;
}

class FirebaseHomeRepository implements HomeRepository {
  final WorkoutRepository _workoutRepository;
  final Map<String, dynamic> _prefsBox;

  FirebaseHomeRepository({
    required WorkoutRepository workoutRepository,
    required Map<String, dynamic> prefsBox,
  }) : _workoutRepository = workoutRepository,
       _prefsBox = prefsBox;
  
  @override
  Future<ApiResult<DashboardData>> getDashboardData() async {
    try {
      final String? planId = _prefsBox['activePlanId'];
      if (planId == null) {
        throw OnboardingIncompleteException();
      }

      int currentDayIndex = _prefsBox['currentDay'] ?? 1;

      WorkoutPlan plan = await _workoutRepository.getPlanById(planId);

      // Map to DashboardData
      // Find today's workout
      WorkoutDay? todayWorkout;
      try {
        todayWorkout = plan.days.firstWhere(
          (d) => d.dayNumber == currentDayIndex,
        );
      } catch (_) {
        if (plan.days.isNotEmpty) {
          todayWorkout = plan.days.first;
        }
      }

      List<DayExercise> todayExercises = [];
      if (todayWorkout != null) {
        todayExercises = todayWorkout.exercises;
      }

      // Generate WeekDays starting from today or standard Sun-Sat?
      // Since it's dynamic, let's just create 7 days based on current date
      final now = DateTime.now();
      List<WeekDay> weekDays = [];
      for (int i = 0; i < 7; i++) {
        final d = now.add(Duration(days: i));
        weekDays.add(
          WeekDay(
            name: _getWeekDayName(d.weekday),
            date: d.day,
            isActive: i == 0, // Mark today as active
          ),
        );
      }

      final data = DashboardData(
        activePlan: ActivePlan(
          title: plan.name,
          durationMinutes: todayWorkout != null
              ? todayWorkout.exercises.length * 10
              : 45, // Rough estimate
          exerciseCount: todayExercises.length,
        ),
        stats: const DashboardStats(recoveryPercentage: 100, weeklyBurn: 0),
        weekDays: weekDays,
        todayExercises: todayExercises,
      );

      return ApiSuccess(data);
    } catch (e) {
      if (e is OnboardingIncompleteException) {
        return ApiFailure(Failure(e.toString()));
      }
      return ApiFailure(Failure('Failed to load dashboard data: $e'));
    }
  }

  String _getWeekDayName(int weekday) {
    switch (weekday) {
      case DateTime.saturday:
        return 'S';
      case DateTime.sunday:
        return 'S';
      case DateTime.monday:
        return 'M';
      case DateTime.tuesday:
        return 'T';
      case DateTime.wednesday:
        return 'W';
      case DateTime.thursday:
        return 'T';
      case DateTime.friday:
        return 'F';
      default:
        return '';
    }
  }
}
