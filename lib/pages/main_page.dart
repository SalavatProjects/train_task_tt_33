import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:train_task_tt_33/navigation/routes.dart';
import 'package:train_task_tt_33/ui_kit/app_styles.dart';
import 'package:train_task_tt_33/ui_kit/colors.dart';
import 'package:train_task_tt_33/bloc/moods_bloc.dart';
import 'package:train_task_tt_33/gen/assets.gen.dart';
import 'package:intl/intl.dart';
import 'package:train_task_tt_33/utils/constants.dart';

import '../bloc/mood_state.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    DateTime today = DateUtils.dateOnly(DateTime.now());
    DateTime start = today.subtract(const Duration(days: 3));
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 32,),
          BlocSelector<MoodsBloc, MoodsState, List<MoodState>>(
          selector: (state) => state.moods,
          builder: (context, moods) {
            return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              final d = start.add(Duration(days: index));
              final mood = moods.where((e) => e.date == d).firstOrNull;
                  return Container(
                    width: 43,
                    decoration: BoxDecoration(
                      border: d == today ? Border
                          .all(width: 1, color: AppColors.black) : null,
                      borderRadius: d == today
                          ? BorderRadius.circular(10)
                          : null,
                      color: mood != null ? AppConstants.moods[index].$1 : Colors.transparent,
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
                              child: SvgPicture.asset(AppConstants.moods[index].$2),
                            ),
                        ],
                      ),
                    ),
                  );
                }
            ),
          );
  },
),
          const SizedBox(height: 30,),
          const Text('Today, I am', style: AppStyles.displayMedium,
            textAlign: TextAlign.start,),
          const SizedBox(height: 15,),
          BlocSelector<MoodsBloc, MoodsState, int?>(
            selector: (state) => state.moodType,
            builder: (context, moodType) {
              return Column(
                children: [
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _MoodCard(
                          color: AppConstants.moods[0].$1,
                          iconPath: AppConstants.moods[0].$2,
                          text: AppConstants.moods[0].$3,
                          opacity: moodType != null && moodType != 0 ? 0.65 : 1,
                          onPressed: () {
                            context.read<MoodsBloc>().updateMoodType(0);
                          },
                      ),
                      _MoodCard(
                        color: AppConstants.moods[1].$1,
                        iconPath: AppConstants.moods[1].$2,
                        text: AppConstants.moods[1].$3,
                        opacity: moodType != null && moodType != 1 ? 0.65 : 1,
                        onPressed: () {
                          context.read<MoodsBloc>().updateMoodType(1);
                        },
                      ),
                      _MoodCard(
                        color: AppConstants.moods[2].$1,
                        iconPath: AppConstants.moods[2].$2,
                        text: AppConstants.moods[2].$3,
                        opacity: moodType != null && moodType != 2 ? 0.65 : 1,
                        onPressed: () {
                          context.read<MoodsBloc>().updateMoodType(2);
                        },
                      ),
                      _MoodCard(
                        color: AppConstants.moods[3].$1,
                        iconPath: AppConstants.moods[3].$2,
                        text: AppConstants.moods[3].$3,
                        opacity: moodType != null && moodType != 3 ? 0.65 : 1,
                        onPressed: () {
                          context.read<MoodsBloc>().updateMoodType(3);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  _GoNextBtn(
                      opacity: moodType == null ? 0.65 : 1,
                      onPressed: moodType == null ? null : () {
                        Navigator.of(context).pushNamed(AppRoutes.mood);
                      })
                ],
              );
            },
          ),
          const SizedBox(height: 30,),
          _MyTriggerListCard(onPressed: () => Navigator.of(context).pushNamed(AppRoutes.trigger))
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
