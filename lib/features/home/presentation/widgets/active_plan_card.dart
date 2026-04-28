import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/styles.dart';
import '../../../../core/shared/custom_button.dart';
import '../../domain/entities/active_plan.dart';

class ActivePlanCard extends StatelessWidget {
  final ActivePlan plan;

  const ActivePlanCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        // image: DecorationImage(
        //   image: AssetImage('assets/images/active_plan_card.png'),
        //   colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.darken),
        //   fit: BoxFit.cover,
        // ),
        color: AppColors.outlineGrey.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.fitness_center,
                color: AppColors.primaryColor,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'ACTIVE PLAN',
                style: Styles.textStyle12.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(plan.title, style: Styles.textStyle24),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.schedule, color: AppColors.grey, size: 16.sp),
              SizedBox(width: 4.w),
              Text(
                '${plan.durationMinutes} Minutes',
                style: Styles.textStyle14,
              ),
              SizedBox(width: 16.w),
              Icon(
                Icons.format_list_bulleted,
                color: AppColors.grey,
                size: 16.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                '${plan.exerciseCount} Exercises',
                style: Styles.textStyle14,
              ),
            ],
          ),
          SizedBox(height: 20.h),
          CustomButton(
            text: 'Start Workout',
            sufix: Icon(Icons.play_arrow, color: AppColors.white),
            color: AppColors.primaryColor,
            textColor: AppColors.white,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
