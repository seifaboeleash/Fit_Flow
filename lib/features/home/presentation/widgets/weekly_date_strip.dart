import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/styles.dart';
import '../../domain/entities/week_day.dart';

class WeeklyDateStrip extends StatelessWidget {
  final List<WeekDay> weekDays;

  const WeeklyDateStrip({super.key, required this.weekDays});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: weekDays.asMap().entries.map((entry) {
          final index = entry.key;
          final day = entry.value;
          // Static days of activity (non-consecutive)
          final isStaticallyActive = index == 0 || index == 2 || index == 4;
          return _buildDayItem(day, isStaticallyActive);
        }).toList(),
      ),
    );
  }

  Widget _buildDayItem(WeekDay day, bool isActive) {
    return Column(
      children: [
        Text(
          day.name,
          style: Styles.textStyle12.copyWith(
            color: AppColors.grey,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryColor : Color(0xFFEEEEEE),
            shape: BoxShape.circle,
            border: isActive ? null : Border.all(color: AppColors.outlineGrey),
          ),
          alignment: Alignment.center,
          child: Text(
            day.date.toString(),
            style: Styles.textStyle14.copyWith(
              color: isActive ? AppColors.white : AppColors.grey,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
