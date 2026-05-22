import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fit_flow/core/theme/styles.dart';
import 'package:fit_flow/generated/l10n.dart';
import 'package:fit_flow/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:fit_flow/features/on_boarding/ui/widgets/availability_selector.dart';

class OnBoardingAvailabilitySection extends StatelessWidget {
  final int displayDays;
  final bool isLoading;

  const OnBoardingAvailabilitySection({
    super.key,
    required this.displayDays,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).weeklyAvailability,
          style: Styles.textStyle18,
        ),
        SizedBox(height: 16.h),
        AvailabilitySelector(
          selectedDays: displayDays,
          onDaysSelected: (days) {
            if (!isLoading) {
              context.read<OnBoardingCubit>().selectDays(days);
            }
          },
        ),
        SizedBox(height: 8.h),
        if (displayDays == 3)
          Container(
            height: 150.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Background+Border.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            alignment: AlignmentDirectional.bottomStart,
            padding: EdgeInsets.all(16.w),
          ),
      ],
    );
  }
}
