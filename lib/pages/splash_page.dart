import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:train_task_tt_33/navigation/routes.dart';
import 'package:train_task_tt_33/remote_config.dart';

class SplashPage extends StatefulWidget {
  final bool isFirstRun;

  const SplashPage({super.key, required this.isFirstRun});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _navigate());
  }

  void _navigate() {
    if (widget.isFirstRun) {
      InAppReview.instance.requestReview();
    }
    if (RemoteConfigService.usePrivacy) {
      if (widget.isFirstRun) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.onBoarding);
      } else {
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      }
    } else {
      Navigator.of(context).pushReplacementNamed(AppRoutes.privacy);
    }
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
