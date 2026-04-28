import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/styles.dart';

class GoalSelectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String svgPath;
  final bool isSelected;
  final VoidCallback onTap;

  const GoalSelectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.svgPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : AppColors.outlineGrey,
            width: isSelected ? 2.w : 1.w,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: Color(0xffF8FAFC),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: SvgPicture.asset(svgPath),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Styles.textStyle16.copyWith(
                      color: isSelected
                          ? AppColors.textDark
                          : AppColors.textDark.withOpacity(0.8),
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(subtitle, style: Styles.textStyle12),
                ],
              ),
            ),
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.outlineGrey,
                  width: isSelected ? 6.w : 2.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
