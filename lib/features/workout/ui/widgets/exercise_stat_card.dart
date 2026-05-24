import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/styles.dart';

class ExerciseStatCard extends StatelessWidget {
  final String title;
  final String value;

  const ExerciseStatCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
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
