import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repositories/on_boarding_repository.dart';
import '../../../workout/domain/entities/workout_plan.dart';

class FirebaseOnBoardingRepository implements OnBoardingRepository {
  final FirebaseFirestore _firestore;
  final Map<String, dynamic> _prefsBox;

  FirebaseOnBoardingRepository({
    FirebaseFirestore? firestore,
    required Map<String, dynamic> prefsBox,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _prefsBox = prefsBox;

  @override
  Future<void> savePreferences({
    required String goal,
    required int daysPerWeek,
  }) async {
    final String activePlanId = '${goal}_${daysPerWeek}days';

    _prefsBox['goal'] = goal;
    _prefsBox['daysPerWeek'] = daysPerWeek;
    _prefsBox['activePlanId'] = activePlanId;
    _prefsBox['currentWeek'] = 1;
    _prefsBox['currentDay'] = 1;
  }

  @override
  Future<bool> hasCompletedOnboarding() async {
    return _prefsBox.containsKey('activePlanId');
  }

  @override
  Future<Map<String, dynamic>?> getPreferences() async {
    if (_prefsBox.isEmpty) {
      return null;
    }

    return Map.from(_prefsBox);
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
