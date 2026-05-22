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
      final box = Hive.box('prefs_box');
      final bool isOnboardingDone = box.get('isOnboardingDone', defaultValue: false);
      if (!isOnboardingDone) {
        throw OnboardingIncompleteException();
      }

      final String goalId = box.get('goalId', defaultValue: '');
      final int daysPerWeek = box.get('daysPerWeek', defaultValue: 3);

      final workoutPlan = await _workoutRepository.getPlanByGoalAndDays(goalId, daysPerWeek);

      List<DayExercise> todayExercises = [];
      if (workoutPlan.days.isNotEmpty) {
        todayExercises = workoutPlan.days.first.exercises;
      }

      int totalMinutes = 0;
      for (var ex in todayExercises) {
        totalMinutes += (ex.sets * 2); // basic estimation
      }
      if (totalMinutes == 0) totalMinutes = 45;

      final now = DateTime.now();
      List<WeekDay> weekDays = [];
      for (int i = 0; i < 7; i++) {
        final d = now.add(Duration(days: i));
        weekDays.add(
          WeekDay(
            name: _getWeekDayName(d.weekday),
            date: d.day,
            isActive: i == 0,
          ),
        );
      }

      final data = DashboardData(
        activePlan: ActivePlan(
          plan: workoutPlan,
          durationMinutes: totalMinutes,
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
