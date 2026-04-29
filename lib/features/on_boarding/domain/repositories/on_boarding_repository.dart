abstract class OnBoardingRepository {
  Future<void> savePreferences({
    required String goal,
    required int daysPerWeek,
  });

  Future<bool> hasCompletedOnboarding();

  Future<Map<String, dynamic>?> getPreferences();
}
