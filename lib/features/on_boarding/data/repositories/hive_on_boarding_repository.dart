import '../../domain/repositories/on_boarding_repository.dart';

class InMemoryOnBoardingRepository implements OnBoardingRepository {
  final Map<String, dynamic> _prefsBox;

  InMemoryOnBoardingRepository({required Map<String, dynamic> prefsBox})
      : _prefsBox = prefsBox;

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
}
