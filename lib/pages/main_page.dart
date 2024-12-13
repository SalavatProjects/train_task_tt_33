import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:train_task_tt_33/bloc/mood_bloc.dart';
import 'package:train_task_tt_33/navigation/routes.dart';
import 'package:train_task_tt_33/pages/mood_page.dart';
import 'package:train_task_tt_33/ui_kit/app_styles.dart';
import 'package:train_task_tt_33/ui_kit/colors.dart';
import 'package:train_task_tt_33/bloc/moods_bloc.dart';
import 'package:train_task_tt_33/gen/assets.gen.dart';
import 'package:intl/intl.dart';
import 'package:train_task_tt_33/utils/constants.dart';

import '../bloc/mood_state.dart';


class MainPage extends StatelessWidget {
  MainPage({super.key});

  final DateTime _today = DateUtils.dateOnly(DateTime.now());

  @override
  Widget build(BuildContext context) {
    DateTime start = _today.subtract(const Duration(days: 3));
    context.read<MoodsBloc>().updateDate(_today);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 32,),
          BlocBuilder<MoodsBloc, MoodsState>(
          builder: (context, state) {
            return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              final d = start.add(Duration(days: index));
              final mood = state.moods.where((e) => e.date == d).firstOrNull;
                  return GestureDetector(
                    onTap: () {
                      context.read<MoodsBloc>().updateDate(d);
                    },
                    child: Container(
                      width: 43,
                      decoration: BoxDecoration(
                        border: d == _today ? Border
                            .all(width: 1, color: AppColors.black) : null,
                        borderRadius: BorderRadius.circular(10),

                        color: mood != null ? AppConstants.moods[mood.type!].$1 : Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: <Widget>[
                            Text(DateFormat('d').format(d),
                              style: AppStyles.displaySmall,),
                            const SizedBox(height: 4,),
                            Text(DateFormat('EEEE')
                                .format(d)
                                .substring(0, 3),
                              style: AppStyles.displaySmall,),
                            if (mood != null)
                              SizedBox(
                                height: 22,
                                width: 13,
                                child: SvgPicture.asset(AppConstants.moods[mood.type!].$2),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            ),
          );
  },
),
          BlocBuilder<MoodsBloc, MoodsState>(
            builder: (context, state) {
              MoodState? mood = state.moods.where((e) => e.date == state.date).firstOrNull;
              if (mood == null) {
                return BlocProvider(
                create: (context) => MoodBloc(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30,),
                    const Text('Today, I am', style: AppStyles.displayMedium,
                      textAlign: TextAlign.start,),
                    const SizedBox(height: 15,),
                    BlocSelector<MoodBloc, MoodState, int?>(
                    selector: (state) => state.type,
                    builder: (context, type) {
                      return Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _MoodCard(
                          color: AppConstants.moods[0].$1,
                          iconPath: AppConstants.moods[0].$2,
                          text: AppConstants.moods[0].$3,
                          opacity: type != null && type != 0 ? 0.65 : 1,
                          onPressed: () {
                            context.read<MoodBloc>().updateType(0);
                          },
                        ),
                        _MoodCard(
                          color: AppConstants.moods[1].$1,
                          iconPath: AppConstants.moods[1].$2,
                          text: AppConstants.moods[1].$3,
                          opacity: type != null && type != 1 ? 0.65 : 1,
                          onPressed: () {
                            context.read<MoodBloc>().updateType(1);
                          },
                        ),
                        _MoodCard(
                          color: AppConstants.moods[2].$1,
                          iconPath: AppConstants.moods[2].$2,
                          text: AppConstants.moods[2].$3,
                          opacity: type != null && type != 2 ? 0.65 : 1,
                          onPressed: () {
                            context.read<MoodBloc>().updateType(2);
                          },
                        ),
                        _MoodCard(
                          color: AppConstants.moods[3].$1,
                          iconPath: AppConstants.moods[3].$2,
                          text: AppConstants.moods[3].$3,
                          opacity: type != null && type != 3 ? 0.65 : 1,
                          onPressed: () {
                            context.read<MoodBloc>().updateType(3);
                          },
                        ),
                      ],
                    );
                    },
                                      ),
                    const SizedBox(height: 20,),
                    BlocBuilder<MoodBloc, MoodState>(
                        builder: (context, state) {
                          return _GoNextBtn(
                        opacity: state.type == null ? 0.65 : 1,
                        onPressed: state.type == null ? null : () {
                          Navigator.of(context).pushNamed(AppRoutes.mood, arguments: state);
                        });
                        },
                      ),
                    const SizedBox(height: 30,),
                    _MyTriggerListCard(onPressed: () => Navigator.of(context).pushNamed(AppRoutes.trigger))
                  ],
                ),
);
              } else {
                return Column(
                  children: [
                    const SizedBox(height: 30,),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.black
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Today I have', style: AppStyles.displaySmall.copyWith(color: AppColors.white),),
                               GestureDetector(
                                    onTap: () async {
                                      const double top = 120;
                                      const double left = 100;
                                      final menuMoodsList = List.from(AppConstants.moods);
                                      (Color color, String iconPath, String name, int moodType) currentMood = menuMoodsList.removeAt(mood.type!);
                                      await showMenu(
                                          context: context,
                                          position: RelativeRect.fromLTRB(
                                              top,
                                              left,
                                              MediaQuery.of(context).size.width - left,
                                              MediaQuery.of(context).size.height - top),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          menuPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                          constraints: const BoxConstraints(
                                              maxWidth: 104
                                          ),
                                          color: AppColors.white,
                                          items: <PopupMenuItem<int>>[
                                            PopupMenuItem<int>(
                                                height: 0,
                                                padding: EdgeInsets.zero,
                                                // onTap: () => context.read<MoodsBloc>().updateMoodType(currentMood.$4),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    SvgPicture.asset(currentMood.$2, width: 16,),
                                                    Text(currentMood.$3, style: AppStyles.displaySmall,),
                                                    SvgPicture.asset(Assets.icons.arrowForward)
                                                  ],
                                                )
                                            ),
                                            const PopupMenuItem(
                                                height: 0,
                                                padding: EdgeInsets.zero,
                                                enabled: false,
                                                child: Divider(color: AppColors.black,)),
                                            ...List.generate(menuMoodsList.length, (index)
                                            => PopupMenuItem(
                                                height: 0,
                                                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                                onTap: () {
                                                  final newMood = mood.copyWith(type: menuMoodsList[index].$4);
                                                  context.read<MoodsBloc>().updateMood(newMood.id!, newMood);
                                                      // context.read<MoodBloc>().updateType(menuMoodsList[index].$4);
                                                },
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    SvgPicture.asset(menuMoodsList[index].$2, width: 16,),
                                                    const SizedBox(width: 4,),
                                                    Text(menuMoodsList[index].$3, style: AppStyles.displaySmall,)
                                                  ],
                                                )
                                            )
                                            )
                                          ]);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                                      child: Container(
                                        width: 104,
                                        height: 32,
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: AppConstants.moods[mood.type!].$1
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SvgPicture.asset(AppConstants.moods[mood.type!].$2, width: 16,),
                                            Text(AppConstants.moods[mood.type!].$3, style: AppStyles.displaySmall,),
                                            SvgPicture.asset(Assets.icons.arrowDown)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              Text('mood.', style: AppStyles.displaySmall.copyWith(color: AppColors.white),)
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                );
              }

            },
          ),
        ],
      ),
    );
  }
}

class _MoodCard extends StatelessWidget {
  Color color;
  String iconPath;
  String text;
  void Function()? onPressed;
  double opacity;

  _MoodCard({
    super.key,
    required this.color,
    required this.iconPath,
    required this.text,
    required this.onPressed,
    this.opacity = 1,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: AppConstants.duration200,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 178,
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20,),
              SizedBox(
                width: 40,
                height: 40,
                child: SvgPicture.asset(iconPath),
              ),
              const SizedBox(height: 16,),
              Text(text, style: AppStyles.displayLarge,)
            ],
          ),
        ),
      ),
    );
  }
}

class _GoNextBtn extends StatelessWidget {
  void Function()? onPressed;
  double opacity;
  _GoNextBtn({
    super.key,
    this.opacity = 0.65,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Opacity(
        opacity: opacity,
        child: CupertinoButton(
            onPressed: onPressed,
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(10),
            color: AppColors.blue,
            disabledColor: AppColors.blue,
            child: Text('Go next', style: AppStyles.displayMedium.copyWith(color: AppColors.white),)),
      ),
    );
  }
}

class _MyTriggerListCard extends StatelessWidget {
  void Function() onPressed;

  _MyTriggerListCard({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 94,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('My trigger list', style: AppStyles.displayMedium.copyWith(color: AppColors.white),),
              GestureDetector(
                onTap: onPressed,
                child: SvgPicture.asset(Assets.icons.plus),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.white
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: RichText(text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(text: 'You don`t have any trigger list. ', style: AppStyles.bodyMedium),
                  TextSpan(
                      text: 'Let`s create it!',
                      style: AppStyles.bodyMedium.copyWith(color: AppColors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = onPressed
                  )
                ]
              )),
            ),
          )
        ],
      ),
    );
  }
}
