import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class FirestoreSeeder {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ─── Entry point ────────────────────────────────────────────────────────────
  // Call this once from a temporary button in your app.
  // After seeding, remove the button — never call this in production.
  Future<void> seedAll() async {
    print('🚀 Starting Firestore seed...');

    // Step 1 — Load the JSON file from assets
    final String jsonString =
        await rootBundle.loadString('assets/data/data.json');
    final Map<String, dynamic> data = jsonDecode(jsonString);

    // Step 2 — Seed each collection in order
    await _seedGoals(data['goals']);
    await _seedExercises(data['exercises']);
    await _seedWorkoutPlans(data['workout_plans']);

    print('✅ Seeding complete! Check your Firestore console.');
  }

  Future<void> _seedGoals(List<dynamic> goals) async {
  print('\n📦 Seeding goals (${goals.length} documents)...');

  for (final goal in goals) {
    try {
      final String id = goal['id'];

      await _firestore
          .collection('goals')
          .doc(id)
          .set(Map<String, dynamic>.from(goal));

      print('  ✓ goals/$id');
    } catch (e) {
      print('  ❌ Failed to seed goal: $e');
    }
  }
}

  // ─── 2. Seed exercises collection ────────────────────────────────────────────
  // Each exercise becomes: exercises/ex_squat, exercises/ex_bench, etc.
  Future<void> _seedExercises(List<dynamic> exercises) async {
    print('\n📦 Seeding exercises (${exercises.length} documents)...');

    for (final exercise in exercises) {
      final String id = exercise['id']; // e.g. "ex_squat"

      await _firestore
          .collection('exercises')
          .doc(id)
          .set(Map<String, dynamic>.from(exercise));

      print('  ✓ exercises/$id');
    }
  }

  // ─── 3. Seed workout_plans collection ────────────────────────────────────────
  // Each plan becomes: workout_plans/get_strong_2_days, etc.
  // The workouts array is stored directly inside the document — no sub-collections.
  Future<void> _seedWorkoutPlans(List<dynamic> plans) async {
    print('\n📦 Seeding workout plans (${plans.length} documents)...');

    for (final plan in plans) {
      final String id = plan['id']; // e.g. "get_strong_2_days"

      // The full plan including the workouts array goes into one document
      await _firestore
          .collection('workout_plans')
          .doc(id)
          .set(Map<String, dynamic>.from(plan));

      final int dayCount = (plan['workouts'] as List).length;
      print('  ✓ workout_plans/$id ($dayCount days)');
    }
  }
}