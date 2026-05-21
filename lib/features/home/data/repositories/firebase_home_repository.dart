import 'package:fit_flow/core/utils/api_result.dart';
import 'package:fit_flow/features/home/domain/entities/dashboard_data.dart';
import 'package:fit_flow/features/home/domain/repositories/home_repository.dart';
import 'package:fit_flow/features/workout/domain/entities/workout_plan.dart';
import 'package:fit_flow/features/workout/domain/repositories/workout_repository.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/active_plan.dart';
import '../../domain/entities/dashboard_stats.dart';
import '../../domain/entities/week_day.dart';

class OnboardingIncompleteException implements Exception {
  final String message;
  OnboardingIncompleteException([this.message = 'Onboarding not completed']);

  @override
  String toString() => message;
}

class FirebaseHomeRepository implements HomeRepository {
  final WorkoutRepository _workoutRepository;

  FirebaseHomeRepository({
    required WorkoutRepository workoutRepository,
  }) : _workoutRepository = workoutRepository;
  
  @override
  Future<ApiResult<DashboardData>> getDashboardData() async {
    try {
      final bool isOnboardingDone = Hive.box('prefs_box').get('isOnboardingDone', defaultValue: false);
      if (!isOnboardingDone) {
        throw OnboardingIncompleteException();
      }

      // User requested keeping DashboardData fetch for stats and weekdays for the next task
      List<DayExercise> todayExercises = [];

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
        activePlan: const ActivePlan(
          title: 'Your Plan',
          durationMinutes: 45,
          exerciseCount: 0,
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
