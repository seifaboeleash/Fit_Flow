import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/styles.dart';
import '../../../workout/domain/entities/workout_plan.dart';
import 'package:fit_flow/generated/l10n.dart';

class ExerciseDetailsScreen extends StatelessWidget {
  final Exercise exercise;
  final DayExercise dayExercise;

  const ExerciseDetailsScreen({
    super.key,
    required this.exercise,
    required this.dayExercise,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: AppColors.textDark),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'exercise_${exercise.id}',
              child: Container(
                width: double.infinity,
                height: 250.h,
                color: AppColors.grey,
                child: exercise.gifUrl.isNotEmpty
                    ? Image.network(exercise.gifUrl, fit: BoxFit.cover, errorBuilder: (c, e, s) => Center(child: Icon(Icons.image, size: 50.r, color: AppColors.white)))
                    : Center(child: Icon(Icons.image, size: 50.r, color: AppColors.white)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.name,
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      _buildChip(exercise.muscleGroup),
                      _buildChip(exercise.equipment),
                      _buildChip(exercise.difficulty),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(child: _buildStatCard('SETS', '${dayExercise.sets}')),
                      SizedBox(width: 12.w),
                      Expanded(child: _buildStatCard('REPS', dayExercise.reps)),
                      SizedBox(width: 12.w),
                      Expanded(child: _buildStatCard('REST', dayExercise.restTime)),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    S.of(context).exerciseInstructions,
                    style: Styles.textStyle18.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.h),
                  ...exercise.instructions.asMap().entries.map((entry) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24.w,
                            height: 24.w,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${entry.key + 1}',
                              style: TextStyle(color: AppColors.white, fontSize: 12.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              entry.value,
                              style: Styles.textStyle14.copyWith(height: 1.5),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    if (label.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.outlineGrey,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: Styles.textStyle12.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.outlineGrey),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            style: Styles.textStyle10.copyWith(color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}
