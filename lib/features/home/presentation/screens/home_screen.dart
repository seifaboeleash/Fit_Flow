import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/styles.dart';
import '../../../../core/utils/di.dart';
import '../cubit/home_cubit.dart';
import '../widgets/active_plan_card.dart';
import '../widgets/dashboard_stat_card.dart';
import '../widgets/exercise_list_tile.dart';
import '../widgets/weekly_date_strip.dart';
import 'package:fit_flow/generated/l10n.dart';
import 'package:hive/hive.dart';
import '../../../../core/models/plan.dart';
import '../../domain/entities/active_plan.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..loadDashboardData(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is HomeError) {
                return Center(child: Text(state.message));
              }
              if (state is HomeLoaded) {
                final data = state.data;
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 24.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context),
                      SizedBox(height: 32.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(S.of(context).homeWeeklyBlueprint,
                              style: Styles.textStyle18),
                          Text(
                            S.of(context).homeWeek1,
                            style: Styles.textStyle14.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      WeeklyDateStrip(weekDays: data.weekDays),
                      SizedBox(height: 24.h),
                      Builder(
                        builder: (context) {
                          final Plan? hivePlan = Hive.box<Plan>('plan_box').get('active_plan');
                          final activePlanToDisplay = hivePlan != null
                              ? ActivePlan(
                                  title: hivePlan.name,
                                  durationMinutes: hivePlan.days.isNotEmpty && hivePlan.days.first.exercises.isNotEmpty
                                      ? hivePlan.days.first.exercises.map((e) => e.durationMinutes).fold(0, (a, b) => a + b)
                                      : 45,
                                  exerciseCount: hivePlan.days.isNotEmpty ? hivePlan.days.first.exercises.length : 0,
                                )
                              : data.activePlan;

                          return ActivePlanCard(plan: activePlanToDisplay);
                        },
                      ),
                      SizedBox(height: 32.h),
                      Text(S.of(context).homeTodaysExercises,
                          style: Styles.textStyle18),
                      SizedBox(height: 16.h),
                      ...data.todayExercises.map(
                        (e) => ExerciseListTile(exercise: e),
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        children: [
                          Expanded(
                            child: DashboardStatCard(
                              title: S.of(context).homeRecovery,
                              subtitle: S.of(context).homeRecoveryDesc,
                              value: '${data.stats.recoveryPercentage}%',
                              icon: Icons.battery_charging_full,
                              tintColor: AppColors.green,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: DashboardStatCard(
                              title: S.of(context).homeWeeklyBurn,
                              subtitle: S.of(context).homeWeeklyBurnDesc,
                              value: '${data.stats.weeklyBurn}',
                              icon: Icons.local_fire_department,
                              tintColor: AppColors.orange,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32.h),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).homeGoodMorning,
              style: Styles.textStyle20.copyWith(color: AppColors.primaryColor),
            ),
            SizedBox(height: 4.h),
            Text(S.of(context).homeLetsGetToWork, style: Styles.textStyle12),
          ],
        ),
        Icon(Icons.settings_outlined, color: AppColors.textDark),
      ],
    );
  }
}
