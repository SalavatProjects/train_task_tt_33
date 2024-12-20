import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:train_task_tt_33/navigation/routes.dart';
import 'package:train_task_tt_33/ui_kit/app_styles.dart';
import 'package:train_task_tt_33/ui_kit/colors.dart';
import 'package:train_task_tt_33/utils/constants.dart';

import '../gen/assets.gen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final _controller = PageController();
  int _currentPage = 0;
  String _btnText = 'Next';

  Future<void> _nextPage() async {
    if (_currentPage == 2) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    } else {
      setState(() {
        _currentPage++;
        if (_currentPage == 2) {
          _btnText = 'Get started';
        }
      });
      await _controller.nextPage(
          duration: AppConstants.duration200,
          curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.edgeToEdge,
        overlays: [SystemUiOverlay.top]
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark
      )
    );
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.images.onboarding.path),
              fit: BoxFit.fill
          )
        ),
        child: Stack(
          children: [
            PageView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('mood'.toUpperCase(), style: AppStyles.displayLarge.copyWith(fontSize: 40),),
                      Text('monitor'.toUpperCase(), style: AppStyles.displayMedium,),
                      Text('app'.toUpperCase(), style: AppStyles.displayLarge.copyWith(fontSize: 64),),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Monitor your mood and improve your quality of life with MoodMonitor, your personal assistant in managing emotions.',
                        style: AppStyles.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Start controlling your mood and work on improving your emotional state today!',
                        style: AppStyles.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _ThreeDots(currentPage: _currentPage),
                  const SizedBox(height: 13,),
                  _NextBtn(onTap: _nextPage, text: _btnText,),
                  const SizedBox(height: 48,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NextBtn extends StatelessWidget {
  void Function() onTap;
  String text;
  _NextBtn({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        width: 172,
        height: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white
        ),
        child: Center(
          child: Text(text, style: AppStyles.displayMedium,),
        ),
      ),
    );
  }
}

class _ThreeDots extends StatelessWidget {
  int currentPage;

  _ThreeDots({
    super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 6,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i <= 2; i++)
            AnimatedContainer(
                duration: AppConstants.duration200,
                curve: Curves.easeInOut,
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.black, width: 1),
                  color: i == currentPage ? AppColors.black : Colors.transparent
                ),
            )
        ],
      ),
    );
  }
}
