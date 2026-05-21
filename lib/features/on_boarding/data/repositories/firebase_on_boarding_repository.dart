import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repositories/on_boarding_repository.dart';
import '../../../workout/domain/entities/workout_plan.dart';
import 'package:hive/hive.dart';

class FirebaseOnBoardingRepository implements OnBoardingRepository {
  final FirebaseFirestore _firestore;

  FirebaseOnBoardingRepository({
    FirebaseFirestore? firestore,
  })  : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> savePreferences({
    required String goal,
    required int daysPerWeek,
  }) async {
    await Hive.box('prefs_box').put('isOnboardingDone', true);
  }

  @override
  Future<bool> hasCompletedOnboarding() async {
    return Hive.box('prefs_box').get('isOnboardingDone', defaultValue: false);
  }

  @override
  Future<Map<String, dynamic>?> getPreferences() async {
    return null;
  }

  @override
  Future<List<Goal>> getGoals() async {
    try {
      final snapshot = await _firestore.collection('goals').get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Goal.fromJson(data);
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch goals: $e');
    }
  }
}
