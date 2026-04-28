import 'package:firebase_core/firebase_core.dart';
import 'package:fit_flow/core/constants/strings.dart';
import 'package:fit_flow/core/routing/app_router.dart';
import 'package:fit_flow/core/utils/di.dart';
import 'package:fit_flow/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupGetIt();

  runApp(const MyApp());
}

AppRouter appRouter = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'PlusJakartaSans'),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.generateRoutes,
        initialRoute: splashScreen,
      ),
    );
  }
}
