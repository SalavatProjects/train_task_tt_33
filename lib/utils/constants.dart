import 'package:train_task_tt_33/gen/assets.gen.dart';

abstract class AppConstants {
  static const isFirstRun = 'isFirstRun';
  static const duration200 = Duration(milliseconds: 200);
  static const pageNames = ['Home', 'Statistics', 'Practice', 'Settings'];
  static final pages = [
    Assets.icons.home,
    Assets.icons.chart,
    Assets.icons.book,
    Assets.icons.settings,
  ];
}