import 'package:firebase_core/firebase_core.dart';
import 'package:fit_flow/config/app_config.dart';
import 'package:fit_flow/core/constants/strings.dart';
import 'package:fit_flow/core/routing/app_router.dart';
import 'package:fit_flow/core/utils/di.dart';
import 'package:fit_flow/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fit_flow/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_flow/core/localization/locale_cubit.dart';

Future<void> runMain(EnvType envType) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  await setupGetIt(envType);
  // await FirestoreSeeder().seed();
  runApp(const MyApp());
}

AppRouter appRouter = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LocaleCubit>(),
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            child: MaterialApp(
              locale: locale,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: ThemeData(fontFamily: 'PlusJakartaSans'),
              debugShowCheckedModeBanner: false,
              onGenerateRoute: appRouter.generateRoutes,
              initialRoute: splashScreen,
            ),
          );
        },
      ),
    );
  }
}
