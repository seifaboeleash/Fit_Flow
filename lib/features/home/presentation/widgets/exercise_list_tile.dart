import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/styles.dart';
import '../../../workout/domain/entities/workout_plan.dart';
import '../screens/exercise_details_screen.dart';

class ExerciseListTile extends StatelessWidget {
  final DayExercise exercise;

  const ExerciseListTile({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    final details = exercise.exerciseDetails;
    
    return GestureDetector(
      onTap: () {
        if (details != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ExerciseDetailsScreen(
                exercise: details,
                dayExercise: exercise,
              ),
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.outlineGrey),
        ),
        child: Row(
          children: [
            Hero(
              tag: 'exercise_${details?.id ?? exercise.exerciseId}',
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Icons.layers, color: AppColors.primaryColor),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    details?.name ?? 'Unknown Exercise',
                    style: Styles.textStyle16.copyWith(color: AppColors.textDark),
                  ),
                  SizedBox(height: 4.h),
                  Text(details?.muscleGroup ?? 'N/A', style: Styles.textStyle14),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${exercise.sets} × ${exercise.reps}',
                  style: Styles.textStyle16.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'REPS',
                  style: Styles.textStyle10.copyWith(color: AppColors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
