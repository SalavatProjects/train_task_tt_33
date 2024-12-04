import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:train_task_tt_33/bloc/moods_bloc.dart';
import 'package:train_task_tt_33/navigation/routes.dart';
import 'package:train_task_tt_33/pages/home_page.dart';
import 'package:train_task_tt_33/pages/onboarding_page.dart';
import 'package:train_task_tt_33/pages/privacy_page.dart';
import 'package:train_task_tt_33/pages/splash_page.dart';
import 'package:train_task_tt_33/pages/trigger_page.dart';
import 'package:train_task_tt_33/remote_config.dart';
import 'package:train_task_tt_33/storages/isar.dart';
import 'package:train_task_tt_33/storages/shared_preferences.dart';
import 'package:train_task_tt_33/ui_kit/colors.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await RemoteConfigService.init();
  await AppSharedPreferences.init();
  await AppIsarDatabase.init();

  final isFirstRun = AppSharedPreferences.getIsFirstRun() ?? true;
  if (isFirstRun) await AppSharedPreferences.setNotFirstRun();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
      AppInfo(
        data: await AppInfoData.get(),
        child: MyApp(isFirstRun: isFirstRun)
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isFirstRun});

  final bool isFirstRun;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoodsBloc(),
      child: _AppWidget(isFirstRun: isFirstRun),
    );
  }
}

class _AppWidget extends StatelessWidget {
  final bool isFirstRun;

  const _AppWidget({required this.isFirstRun});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<MoodsBloc>().getMoods(),
      builder: (context, snapshot) {
        return MaterialApp(
          title: '',
          themeMode: ThemeMode.light,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            scaffoldBackgroundColor: AppColors.white,
          ),
          onUnknownRoute: (settings) => CupertinoPageRoute(
              builder: (context) => const HomePage()
          ),
          onGenerateRoute: (settings) => switch (settings.name) {
            AppRoutes.onBoarding => CupertinoPageRoute(
              settings: settings,
              builder: (context) => const OnBoardingPage()
            ),
            AppRoutes.home => CupertinoPageRoute(
              settings: settings,
              builder: (context) => const HomePage(),
            ),
            AppRoutes.privacy => CupertinoPageRoute(
              settings: settings,
              builder: (context) => const PrivacyPage(),
            ),
            AppRoutes.trigger => CupertinoPageRoute(
              settings: settings,
              builder: (context) => const TriggerPage(),
            ),
          _ => null,
          },
          home: SplashPage(isFirstRun: !isFirstRun),
        );
      }
    );
  }
}
