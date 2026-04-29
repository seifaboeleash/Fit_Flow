import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreSeeder {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> seed() async {
    print('Starting seeder...');

    final List<String> goals = ['buildMuscle', 'getStrong', 'generalFitness'];
    final List<int> daysList = [2, 3, 4, 5];

    // Seed Exercises First
    final batch = _firestore.batch();
    
    final exercises = [
      {
        'id': 'ex_bench',
        'name': 'Bench Press',
        'muscleGroup': 'Chest',
        'equipment': 'Barbell',
        'difficulty': 'Intermediate',
        'gifUrl': '',
        'instructions': ['Lie on bench', 'Lower bar', 'Press bar up'],
        'category': 'Strength',
        'targetMuscles': ['Pectoralis Major', 'Triceps'],
      },
      {
        'id': 'ex_squat',
        'name': 'Barbell Squat',
        'muscleGroup': 'Legs',
        'equipment': 'Barbell',
        'difficulty': 'Intermediate',
        'gifUrl': '',
        'instructions': ['Stand with bar on back', 'Squat down', 'Stand up'],
        'category': 'Strength',
        'targetMuscles': ['Quadriceps', 'Glutes'],
      },
    ];

    for (var ex in exercises) {
      final docRef = _firestore.collection('exercises').doc(ex['id'] as String);
      batch.set(docRef, ex);
    }

    await batch.commit();

    // Now seed plans
    for (String goal in goals) {
      for (int days in daysList) {
        final String planId = '${goal}_${days}days';
        final planRef = _firestore.collection('workout_plans').doc(planId);

        final planData = {
          'name': '${goal.toUpperCase()} $days-Day Plan',
          'goal': goal,
          'daysPerWeek': days,
          'level': 'All Levels',
          'description': 'A $days-day program to achieve $goal.',
        };

        await planRef.set(planData);

        for (int day = 1; day <= days; day++) {
          final dayRef = planRef.collection('workout_days').doc('day_$day');
          await dayRef.set({
            'dayNumber': day,
            'name': 'Day $day - Full Body',
            'focus': 'Mixed',
          });

          // Add 2 exercises per day
          for (int ex = 1; ex <= 2; ex++) {
            final exRef = dayRef.collection('day_exercises').doc('ex_$ex');
            await exRef.set({
              'exerciseId': ex == 1 ? 'ex_bench' : 'ex_squat',
              'order': ex,
              'sets': 3,
              'reps': '8-12',
              'restSeconds': 90,
              'notes': 'Keep good form.',
            });
          }
        }
      }
    }

    print('Seeding completed!');
  }
}
