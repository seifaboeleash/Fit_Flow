import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreSeeder {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> seed() async {
    print('Starting high-quality seeder...');

    final List<String> goals = ['buildMuscle', 'getStrong', 'generalFitness'];
    final List<int> daysList = [2, 3, 4, 5];

    // 1. Define a robust list of global exercises
    final exercises = [
      _createExercise('ex_bench', 'Bench Press', 'Chest', 'Barbell', 'Intermediate', ['Pectoralis Major', 'Triceps'], 'Strength', ['Lie on flat bench.', 'Lower bar to chest.', 'Press bar up.']),
      _createExercise('ex_squat', 'Barbell Squat', 'Legs', 'Barbell', 'Intermediate', ['Quadriceps', 'Glutes'], 'Strength', ['Rest bar on upper back.', 'Squat down keeping back straight.', 'Stand back up.']),
      _createExercise('ex_deadlift', 'Deadlift', 'Back', 'Barbell', 'Advanced', ['Hamstrings', 'Lower Back'], 'Strength', ['Stand with bar over mid-foot.', 'Bend and grip bar.', 'Lift by extending hips and knees.']),
      _createExercise('ex_pullup', 'Pull-ups', 'Back', 'Bodyweight', 'Intermediate', ['Lats', 'Biceps'], 'Hypertrophy', ['Hang from bar.', 'Pull chin over bar.', 'Lower with control.']),
      _createExercise('ex_row', 'Barbell Row', 'Back', 'Barbell', 'Intermediate', ['Lats', 'Rhomboids'], 'Hypertrophy', ['Bend over with slight knee bend.', 'Pull bar to stomach.', 'Lower bar.']),
      _createExercise('ex_ohp', 'Overhead Press', 'Shoulders', 'Barbell', 'Intermediate', ['Deltoids', 'Triceps'], 'Strength', ['Stand with bar at shoulders.', 'Press bar overhead.', 'Lower to shoulders.']),
      _createExercise('ex_lunge', 'Walking Lunges', 'Legs', 'Dumbbell', 'Beginner', ['Quadriceps', 'Glutes'], 'Hypertrophy', ['Step forward and drop back knee.', 'Push off front foot.', 'Repeat with other leg.']),
      _createExercise('ex_curl', 'Bicep Curls', 'Arms', 'Dumbbell', 'Beginner', ['Biceps'], 'Hypertrophy', ['Hold dumbbells at side.', 'Curl weight up.', 'Lower with control.']),
      _createExercise('ex_tri_ext', 'Tricep Extensions', 'Arms', 'Cable', 'Beginner', ['Triceps'], 'Hypertrophy', ['Hold rope attachment.', 'Extend arms straight down.', 'Return slowly.']),
      _createExercise('ex_plank', 'Plank', 'Core', 'Bodyweight', 'Beginner', ['Abs', 'Core'], 'Endurance', ['Rest on forearms and toes.', 'Keep body in straight line.', 'Hold position.']),
      _createExercise('ex_pushup', 'Push-ups', 'Chest', 'Bodyweight', 'Beginner', ['Chest', 'Triceps'], 'Endurance', ['Start in plank position.', 'Lower chest to floor.', 'Push back up.']),
      _createExercise('ex_burpee', 'Burpees', 'Full Body', 'Bodyweight', 'Intermediate', ['Full Body'], 'Cardio', ['Drop to squat.', 'Kick legs back to plank.', 'Do a pushup.', 'Jump up.']),
      _createExercise('ex_treadmill', 'Treadmill Run', 'Cardio', 'Machine', 'Beginner', ['Cardiovascular'], 'Cardio', ['Start treadmill.', 'Run at steady pace.', 'Cool down.']),
    ];

    // Seed global exercises
    final batch = _firestore.batch();
    for (var ex in exercises) {
      final docRef = _firestore.collection('exercises').doc(ex['id'] as String);
      batch.set(docRef, ex);
    }
    await batch.commit();
    print('Global exercises seeded.');

    // 2. Seed Goal-Specific Plans
    for (String goal in goals) {
      for (int days in daysList) {
        final String planId = '${goal}_${days}days';
        final planRef = _firestore.collection('workout_plans').doc(planId);

        // Plan metadata
        await planRef.set({
          'name': _getPlanName(goal, days),
          'goal': goal,
          'daysPerWeek': days,
          'level': goal == 'getStrong' ? 'Intermediate/Advanced' : 'All Levels',
          'description': _getPlanDescription(goal, days),
        });

        // 3. Generate daily workouts based on goal and total days
        for (int day = 1; day <= days; day++) {
          final dayRef = planRef.collection('workout_days').doc('day_$day');
          
          final focus = _getDayFocus(days, day);
          await dayRef.set({
            'dayNumber': day,
            'name': 'Day $day - $focus',
            'focus': focus,
          });

          // Get specific exercises for this goal and day
          final dayExercisesList = _getExercisesForDay(goal, focus);

          // Write exercises to subcollection
          for (int exIndex = 0; exIndex < dayExercisesList.length; exIndex++) {
            final exData = dayExercisesList[exIndex];
            final exRef = dayRef.collection('day_exercises').doc('ex_${exIndex + 1}');
            
            await exRef.set({
              'exerciseId': exData['id'],
              'order': exIndex + 1,
              'sets': exData['sets'],
              'reps': exData['reps'],
              'restSeconds': exData['restSeconds'],
              'notes': exData['notes'] ?? '',
            });
          }
        }
      }
    }

    print('Seeding completely finished! You can now remove the seeder from main.dart.');
  }

  // --- Helper Methods to Generate High-Quality Data ---

  Map<String, dynamic> _createExercise(String id, String name, String muscleGroup, String equipment, String difficulty, List<String> targetMuscles, String category, List<String> instructions) {
    return {
      'id': id,
      'name': name,
      'muscleGroup': muscleGroup,
      'equipment': equipment,
      'difficulty': difficulty,
      'gifUrl': '', // Add URLs later if needed
      'instructions': instructions,
      'category': category,
      'targetMuscles': targetMuscles,
    };
  }

  String _getPlanName(String goal, int days) {
    if (goal == 'buildMuscle') return 'Hypertrophy Max ($days Days)';
    if (goal == 'getStrong') return 'Raw Strength ($days Days)';
    return 'Total Fitness ($days Days)';
  }

  String _getPlanDescription(String goal, int days) {
    if (goal == 'buildMuscle') return 'A volume-heavy $days-day split designed to maximize muscle growth and aesthetics.';
    if (goal == 'getStrong') return 'A heavy $days-day compound lifting program to drastically increase your 1-rep maxes.';
    return 'A balanced $days-day routine combining light resistance and cardio for overall health and endurance.';
  }

  String _getDayFocus(int totalDays, int currentDay) {
    if (totalDays == 2) return currentDay == 1 ? 'Upper Body' : 'Lower Body';
    if (totalDays == 3) {
      if (currentDay == 1) return 'Push';
      if (currentDay == 2) return 'Pull';
      return 'Legs';
    }
    if (totalDays == 4) {
      if (currentDay == 1) return 'Upper Heavy';
      if (currentDay == 2) return 'Lower Heavy';
      if (currentDay == 3) return 'Upper Volume';
      return 'Lower Volume';
    }
    // 5 days
    if (currentDay == 1) return 'Push';
    if (currentDay == 2) return 'Pull';
    if (currentDay == 3) return 'Legs';
    if (currentDay == 4) return 'Upper Body';
    return 'Lower Body';
  }

  List<Map<String, dynamic>> _getExercisesForDay(String goal, String focus) {
    if (goal == 'getStrong') {
      // Heavy compounds, low reps, long rest
      if (focus.contains('Upper') || focus == 'Push') {
        return [
          {'id': 'ex_bench', 'sets': 5, 'reps': '3-5', 'restSeconds': 180, 'notes': 'Lift heavy, keep strict form.'},
          {'id': 'ex_ohp', 'sets': 4, 'reps': '4-6', 'restSeconds': 180},
          {'id': 'ex_row', 'sets': 4, 'reps': '5-8', 'restSeconds': 120},
        ];
      } else if (focus.contains('Lower') || focus == 'Legs') {
        return [
          {'id': 'ex_squat', 'sets': 5, 'reps': '3-5', 'restSeconds': 180, 'notes': 'Go deep.'},
          {'id': 'ex_deadlift', 'sets': 3, 'reps': '3-5', 'restSeconds': 240, 'notes': 'Protect your lower back.'},
          {'id': 'ex_plank', 'sets': 3, 'reps': '60s', 'restSeconds': 90},
        ];
      } else { // Pull
        return [
          {'id': 'ex_deadlift', 'sets': 5, 'reps': '3-5', 'restSeconds': 240},
          {'id': 'ex_pullup', 'sets': 4, 'reps': 'Failure', 'restSeconds': 120},
          {'id': 'ex_row', 'sets': 4, 'reps': '5-8', 'restSeconds': 120},
        ];
      }
    } else if (goal == 'buildMuscle') {
      // Hypertrophy, medium reps, medium rest
      if (focus == 'Push' || focus.contains('Upper')) {
        return [
          {'id': 'ex_bench', 'sets': 4, 'reps': '8-12', 'restSeconds': 90},
          {'id': 'ex_ohp', 'sets': 3, 'reps': '10-12', 'restSeconds': 90},
          {'id': 'ex_pushup', 'sets': 3, 'reps': '15-20', 'restSeconds': 60, 'notes': 'Burnout set.'},
          {'id': 'ex_tri_ext', 'sets': 3, 'reps': '12-15', 'restSeconds': 60},
        ];
      } else if (focus == 'Pull') {
        return [
          {'id': 'ex_pullup', 'sets': 4, 'reps': '8-12', 'restSeconds': 90},
          {'id': 'ex_row', 'sets': 4, 'reps': '10-12', 'restSeconds': 90},
          {'id': 'ex_curl', 'sets': 4, 'reps': '12-15', 'restSeconds': 60, 'notes': 'Squeeze at the top.'},
        ];
      } else { // Legs / Lower
        return [
          {'id': 'ex_squat', 'sets': 4, 'reps': '8-12', 'restSeconds': 120},
          {'id': 'ex_lunge', 'sets': 3, 'reps': '12 per leg', 'restSeconds': 90},
          {'id': 'ex_curl', 'sets': 3, 'reps': '12-15', 'restSeconds': 60}, // Some arms mixed in
        ];
      }
    } else {
      // General Fitness: Endurance, cardio, light compounds
      if (focus.contains('Upper') || focus == 'Push' || focus == 'Pull') {
        return [
          {'id': 'ex_pushup', 'sets': 3, 'reps': '10-15', 'restSeconds': 60},
          {'id': 'ex_pullup', 'sets': 3, 'reps': 'Max', 'restSeconds': 60},
          {'id': 'ex_burpee', 'sets': 3, 'reps': '15', 'restSeconds': 60, 'notes': 'Keep heart rate up.'},
          {'id': 'ex_plank', 'sets': 3, 'reps': '60s', 'restSeconds': 60},
        ];
      } else { // Legs / Lower
        return [
          {'id': 'ex_lunge', 'sets': 3, 'reps': '15 per leg', 'restSeconds': 60},
          {'id': 'ex_squat', 'sets': 3, 'reps': '15-20', 'restSeconds': 60},
          {'id': 'ex_treadmill', 'sets': 1, 'reps': '20 mins', 'restSeconds': 0, 'notes': 'Steady state cardio.'},
        ];
      }
    }
  }
}
