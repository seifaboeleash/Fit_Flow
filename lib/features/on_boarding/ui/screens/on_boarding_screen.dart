import 'package:fit_flow/core/constants/strings.dart';
import 'package:fit_flow/core/shared/custom_snack_bar.dart';
import 'package:fit_flow/core/theme/app_colors.dart';
import 'package:fit_flow/core/theme/styles.dart';
import 'package:fit_flow/core/shared/custom_button.dart';
import 'package:fit_flow/core/utils/di.dart';
import 'package:fit_flow/features/on_boarding/domain/entities/workout_goal.dart';
import 'package:fit_flow/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:fit_flow/features/on_boarding/ui/widgets/availability_selector.dart';
import 'package:fit_flow/features/on_boarding/ui/widgets/goal_selection_card.dart';
import 'package:fit_flow/features/on_boarding/ui/widgets/on_boarding_header.dart';
import 'package:fit_flow/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OnBoardingCubit>(),
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                children: [
                  OnBoardingHeader(),
                  SizedBox(height: 32.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: BlocConsumer<OnBoardingCubit, OnBoardingState>(
                        listener: (context, state) {
                          if (state is OnBoardingSuccess) {
                            Navigator.pushReplacementNamed(
                              context,
                              mainLayoutScreen,
                            );
                          } else if (state is OnBoardingError) {
                            showCustomSnackBar(context, state.message);
                          }
                        },
                        builder: (context, state) {
                          if (state is OnBoardingLoading) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 100.h),
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            );
                          }
                          if (state is! OnBoardingUpdated) {
                            return const SizedBox.shrink();
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).onboardingTitle,
                                style: TextStyle(
                                  fontSize: 34.sp,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textDark,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                S.of(context).onboardingDesc,
                                style: Styles.textStyle14,
                              ),
                              SizedBox(height: 20.h),
                              ...WorkoutGoal.values.map(
                                (goal) => GoalSelectionCard(
                                  title: goal.title,
                                  subtitle: goal.subtitle,
                                  svgPath: goal.svgPath,
                                  isSelected: state.selectedGoal == goal,
                                  onTap: () => context
                                      .read<OnBoardingCubit>()
                                      .selectGoal(goal),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                S.of(context).weeklyAvailability,
                                style: Styles.textStyle18,
                              ),
                              SizedBox(height: 16.h),
                              AvailabilitySelector(
                                selectedDays: state.selectedDays,
                                onDaysSelected: (days) => context
                                    .read<OnBoardingCubit>()
                                    .selectDays(days),
                              ),
                              SizedBox(height: 16.h),
                              state.selectedDays == 3
                                  ? Container(
                                      height: 150.h,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/Background+Border.png',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                      ),
                                      alignment: Alignment.bottomLeft,
                                      padding: EdgeInsets.all(16.w),
                                    )
                                  : SizedBox.shrink(),
                              SizedBox(height: 16.h),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 16.h),
                      CustomButton(
                        text: S.of(context).continueButton,
                        color: AppColors.primaryColor,
                        textColor: AppColors.white,
                        sufix: Icon(
                          Icons.arrow_forward,
                          color: AppColors.white,
                        ),
                        onTap: () {
                          if (context.read<OnBoardingCubit>().canContinue()) {
                            context
                                .read<OnBoardingCubit>()
                                .completeOnboarding();
                          } else {
                            showCustomSnackBar(
                              context,
                              S.of(context).onboardingSubtitle,
                            );
                          }
                        },
                        radius: 1000.r,
                      ),
                      SizedBox(height: 16.h),
                      Center(
                        child: Text(
                          S.of(context).changeLaterProfile,
                          style: Styles.textStyle10.copyWith(
                            color: AppColors.grey,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

                        // //    Placeholder for Recommended static image
                        //     Container(
                        //       height: 120.h,
                        //       decoration: BoxDecoration(
                        //         color: AppColors.grey,
                        //         borderRadius: BorderRadius.circular(16.r),
                        //       ),
                        //       alignment: Alignment.bottomLeft,
                        //       padding: EdgeInsets.all(16.w),
                        //       child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text(
                        //             'RECOMMENDED',
                        //             style: Styles.textStyle10.copyWith(
                        //               color: AppColors.primaryColor,
                        //             ),
                        //           ),
                        //           Text(
                        //             'Optimal recovery cycle',
                        //             style: Styles.textStyle12.copyWith(
                        //               color: AppColors.white,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),