import 'package:hive/hive.dart';
import '../../domain/repositories/on_boarding_repository.dart';

class HiveOnBoardingRepository implements OnBoardingRepository {
  final Box _prefsBox;

  HiveOnBoardingRepository({required Box prefsBox}) : _prefsBox = prefsBox;

  @override
  Future<void> savePreferences({
    required String goal,
    required int daysPerWeek,
  }) async {
    final String activePlanId = '${goal}_${daysPerWeek}days';
    
    await _prefsBox.put('goal', goal);
    await _prefsBox.put('daysPerWeek', daysPerWeek);
    await _prefsBox.put('activePlanId', activePlanId);
    await _prefsBox.put('currentWeek', 1);
    await _prefsBox.put('currentDay', 1);
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
    
    return {
      for (var key in _prefsBox.keys) key.toString(): _prefsBox.get(key),
    };
  }
}
