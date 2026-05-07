import 'package:fit_flow/features/workout/domain/entities/workout_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WorkoutPlan and DayExercise JSON Parsing', () {
    final Map<String, dynamic> dummyJson = {
      'id': 'buildMuscle_3days',
      'name': 'Test Plan',
      'goal': 'buildMuscle',
      'daysPerWeek': 3,
      'level': 'Beginner',
      'description': 'Test Description',
      'days': [
        {
          'dayNumber': 1,
          'name': 'Day 1',
          'focus': 'Upper Body',
          'exercises': [
            {
              'exerciseId': 'ex_bench',
              'order': 1,
              'sets': 3,
              'reps': '10',
              'restSeconds': 60,
              'notes': 'Keep form',
              'exerciseDetails': {
                'id': 'ex_bench',
                'name': 'Bench Press',
                'muscleGroup': 'Chest',
                'equipment': 'Barbell',
                'difficulty': 'Intermediate',
                'gifUrl': '',
                'instructions': ['Push'],
                'category': 'Strength',
                'targetMuscles': ['Chest']
              }
            }
          ]
        }
      ]
    };

    test('WorkoutPlan.fromJson correctly parses full nested JSON without type cast errors', () {
      final plan = WorkoutPlan.fromJson(dummyJson);

      expect(plan.id, 'buildMuscle_3days');
      expect(plan.goal, 'buildMuscle');
      expect(plan.daysPerWeek, 3);
      expect(plan.days.length, 1);
      
      final day = plan.days.first;
      expect(day.dayNumber, 1);
      expect(day.focus, 'Upper Body');
      expect(day.exercises.length, 1);

      final exercise = day.exercises.first;
      expect(exercise.exerciseId, 'ex_bench');
      expect(exercise.sets, 3);
      expect(exercise.restSeconds, 60);
      expect(exercise.exerciseDetails, isNotNull);
      expect(exercise.exerciseDetails!.name, 'Bench Press');
      expect(exercise.exerciseDetails!.targetMuscles.first, 'Chest');
    });

    test('WorkoutPlan.toJson produces a correct Map structure', () {
      final plan = WorkoutPlan.fromJson(dummyJson);
      final jsonMap = plan.toJson();

      expect(jsonMap['id'], 'buildMuscle_3days');
      expect(jsonMap['days'], isA<List>());
      expect((jsonMap['days'] as List).first['exercises'], isA<List>());
      expect(((jsonMap['days'] as List).first['exercises'] as List).first['exerciseDetails'], isA<Map>());
    });
  });
}
