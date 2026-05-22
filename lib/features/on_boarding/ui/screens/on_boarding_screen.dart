import 'package:fit_flow/core/constants/strings.dart';
import 'package:fit_flow/features/workout/domain/entities/workout_plan.dart';
import 'package:fit_flow/core/shared/custom_snack_bar.dart';
import 'package:fit_flow/core/theme/app_colors.dart';
import 'package:fit_flow/core/utils/di.dart';
import 'package:fit_flow/core/localization/locale_cubit.dart';
import 'package:fit_flow/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:fit_flow/features/on_boarding/ui/widgets/on_boarding_header.dart';
import 'package:fit_flow/features/on_boarding/ui/widgets/on_boarding_title_section.dart';
import 'package:fit_flow/features/on_boarding/ui/widgets/on_boarding_goals_list.dart';
import 'package:fit_flow/features/on_boarding/ui/widgets/on_boarding_availability_section.dart';
import 'package:fit_flow/features/on_boarding/ui/widgets/on_boarding_bottom_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OnBoardingCubit>()..loadGoals(),
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
                          final lang =
                              context.read<LocaleCubit>().state.languageCode;

                          final bool isLoading =
                              state is OnBoardingLoadingGoals ||
                                  state is OnBoardingLoading;

                          final List<Goal> displayGoals = isLoading
                              ? [
                                  Goal(
                                      id: 'dummy1',
                                      titleEn: 'Loading goal title',
                                      titleAr: 'تحميل',
                                      subtitleEn: 'Loading subtitle...',
                                      subtitleAr: 'تحميل'),
                                  Goal(
                                      id: 'dummy2',
                                      titleEn: 'Loading goal title',
                                      titleAr: 'تحميل',
                                      subtitleEn: 'Loading subtitle...',
                                      subtitleAr: 'تحميل'),
                                  Goal(
                                      id: 'dummy3',
                                      titleEn: 'Loading goal title',
                                      titleAr: 'تحميل',
                                      subtitleEn: 'Loading subtitle...',
                                      subtitleAr: 'تحميل'),
                                ]
                              : (state is OnBoardingUpdated ? state.goals : []);

                          final int displayDays = state is OnBoardingUpdated
                              ? state.selectedDays
                              : 3;
                          final String? displaySelectedGoalId =
                              state is OnBoardingUpdated
                                  ? state.selectedGoal?.id
                                  : null;

                          if (!isLoading && state is! OnBoardingUpdated) {
                            return const SizedBox.shrink();
                          }

                          return Skeletonizer(
                            enabled: isLoading,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const OnBoardingTitleSection(),
                                SizedBox(height: 20.h),
                                OnBoardingGoalsList(
                                  displayGoals: displayGoals,
                                  displaySelectedGoalId: displaySelectedGoalId,
                                  isLoading: isLoading,
                                  lang: lang,
                                ),
                                SizedBox(height: 6.h),
                                OnBoardingAvailabilitySection(
                                  displayDays: displayDays,
                                  isLoading: isLoading,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const OnBoardingBottomActions(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
