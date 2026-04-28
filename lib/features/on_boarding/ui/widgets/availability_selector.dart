import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/styles.dart';

class AvailabilitySelector extends StatelessWidget {
  final int selectedDays;
  final ValueChanged<int> onDaysSelected;

  const AvailabilitySelector({
    super.key,
    required this.selectedDays,
    required this.onDaysSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.outlineGrey),
      ),
      padding: EdgeInsets.all(4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildOption(context, 2, '2 Days'),
          _buildOption(context, 3, '3 Days'),
          _buildOption(context, 4, '4 Days'),
          _buildOption(context, 5, '5+ Days'),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, int value, String label) {
    final isSelected =
        selectedDays == value || (value == 5 && selectedDays >= 5);
    return Expanded(
      child: GestureDetector(
        onTap: () => onDaysSelected(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 8.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            label,
            style: Styles.textStyle14.copyWith(
              color: isSelected ? AppColors.white : AppColors.grey,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 12.sp,
            ),
          ),
        ),
      ),
    );
  }
}
