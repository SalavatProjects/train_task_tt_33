import 'dart:ui';

import 'package:train_task_tt_33/gen/assets.gen.dart';
import 'package:train_task_tt_33/ui_kit/colors.dart';

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
  static final moods = <(Color color, String iconPath, String name, int moodType)>[
    (AppColors.yellow, Assets.icons.happy, 'Happy', 0),
    (AppColors.violet, Assets.icons.unhappy, 'Sad', 1),
    (AppColors.red, Assets.icons.angryFace, 'Angry', 2),
    (AppColors.green, Assets.icons.confusedFace, 'Anxiety', 3),
  ];
}