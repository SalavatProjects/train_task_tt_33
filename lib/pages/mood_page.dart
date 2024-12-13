import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:train_task_tt_33/ui_kit/app_styles.dart';
import 'package:train_task_tt_33/ui_kit/colors.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:train_task_tt_33/utils/constants.dart';

import '../bloc/mood_bloc.dart';
import '../bloc/mood_state.dart';
import '../bloc/moods_bloc.dart';
import '../bloc/trigger_bloc.dart';
import '../bloc/trigger_state.dart';
import '../gen/assets.gen.dart';

class MoodPage extends StatelessWidget {
  MoodPage({
    super.key,
    // required this.mood,
  });

  // MoodState mood;

  final TextEditingController _reasonTextEditingController = TextEditingController();
  final TextEditingController _commentTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /*context.read<MoodBloc>().updateDate(DateUtils.dateOnly(DateTime.now()));
    context.read<MoodBloc>().updateType(context.read<MoodsBloc>().state.moodType!);*/
    return Scaffold(
      body: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: Navigator.of(context).pop,
                              child: SvgPicture.asset(Assets.icons.arrowBack, width: 28,),
                            ),
                            Text(DateFormat('EEEE, d MMMM').format(DateTime.now()), style: AppStyles.displayMedium,),
                            const SizedBox(width: 14,)
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.black
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text('Today I have', style: AppStyles.displaySmall.copyWith(color: AppColors.white),),
                                  BlocSelector<MoodBloc, MoodState, int?>(
                                    selector: (state) => state.type,
                                    builder: (context, moodType) {
                                        return GestureDetector(
                                        onTap: () async {
                                          const double top = 120;
                                          const double left = 100;
                                          final menuMoodsList = List.from(AppConstants.moods);
                                          (Color color, String iconPath, String name, int moodType) currentMood = menuMoodsList.removeAt(moodType);
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
                                                    onTap: () => context.read<MoodBloc>().updateType(menuMoodsList[index].$4),
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
                                              color: AppConstants.moods[moodType!].$1
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                SvgPicture.asset(AppConstants.moods[moodType].$2, width: 16,),
                                                Text(AppConstants.moods[moodType].$3, style: AppStyles.displaySmall,),
                                                SvgPicture.asset(Assets.icons.arrowDown)
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Text('mood.', style: AppStyles.displaySmall.copyWith(color: AppColors.white),)
                                ],
                              ),
                              const SizedBox(height: 8,),
                              Text('Because:', style: AppStyles.displaySmall.copyWith(color: AppColors.white),),
                              const SizedBox(height: 8,),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.white
                                ),
                                child: TextFormField(
                                  controller: _reasonTextEditingController,
                                  style: AppStyles.bodySmall,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(30)
                                  ],
                                  decoration: InputDecoration(
                                    hintText: 'Start typing reasons why your mood is so...',
                                    hintStyle: AppStyles.bodySmall,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true,
                                    suffixIconConstraints: const BoxConstraints(
                                      maxWidth: 18,
                                      maxHeight: 18,
                                    ),
                                      suffixIcon: GestureDetector(
                                            onTap: () {
                                              if (_reasonTextEditingController.text.isNotEmpty) {
                                                context.read<MoodBloc>().addReason(_reasonTextEditingController.text);
                                                _reasonTextEditingController.clear();
                                              }

                                            },
                                            child: Container(
                                              width: 18,
                                              height: 18,
                                              padding: const EdgeInsets.all(1),
                                              decoration: BoxDecoration(
                                                  color: AppColors.black,
                                                  borderRadius: BorderRadius.circular(4)
                                              ),
                                              child: SvgPicture.asset(Assets.icons.plus),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              BlocSelector<MoodBloc, MoodState, List<String>>(
                                selector: (state) => state.reasons,
                                builder: (context, reasons) {
                                  if (reasons.isNotEmpty) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                      child: Wrap(
                                        runSpacing: 4,
                                        spacing: 4,
                                        children: List.generate(
                                            reasons.length,
                                                (index) => IntrinsicWidth(
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: AppColors.white
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Text(reasons[index], style: AppStyles.bodySmall,),
                                                    const SizedBox(width: 4,),
                                                    SizedBox(
                                                      width: 16,
                                                      height: 16,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          context.read<MoodBloc>().deleteReason(index);
                                                        },
                                                        child: SvgPicture.asset(Assets.icons.close, width: 4,),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const SizedBox(height: 8,);
                                  }
                                },
                              ),
                              Text('My comment:', style: AppStyles.displaySmall.copyWith(color: AppColors.white)),
                              const SizedBox(height: 8,),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.white,
                                ),
                                child: TextFormField(
                                  controller: _commentTextEditingController,
                                  style: AppStyles.bodySmall,
                                  maxLines: 3,
                                  onChanged: (String value) {
                                    context.read<MoodBloc>().updateComment(value);
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Start typing...',
                                    hintStyle: AppStyles.bodySmall,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true,
                                    suffixIconConstraints: BoxConstraints(
                                      maxWidth: 18,
                                      maxHeight: 18,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.black
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Choose trigger list:', style: AppStyles.displaySmall.copyWith(color: AppColors.white),),
                              const SizedBox(height: 8,),
                              BlocBuilder<MoodsBloc, MoodsState>(
                                  builder: (context, state) {
                                    if (state.triggers.isNotEmpty) {
                                      TriggerState trigger = state.triggers[0];
                                      return PullDownButton(
                                        routeTheme: const PullDownMenuRouteTheme(
                                          backgroundColor: AppColors.white
                                        ),
                                          itemBuilder: (context) => List.generate(
                                              state.triggers.length, (index) =>
                                              PullDownMenuItem(
                                                  onTap: () {
                                                    trigger = state.triggers[index];
                                                  },
                                                  title: state.triggers[index].name!)
                                          ),
                                          buttonBuilder: (context, showMenu) =>
                                              GestureDetector(
                                                onTap: showMenu,
                                                child: Container(
                                                  padding: const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: AppColors.white
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text(trigger.name!, style: AppStyles.displaySmall,),
                                                      SizedBox(
                                                        width: 18,
                                                        height: 18,
                                                        child: SvgPicture.asset(
                                                          Assets.icons.arrowDown,
                                                          width: 10,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                      );

                                    } else {
                                      return Container(
                                        width: MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: AppColors.white,
                                        ),
                                        child: const Text('You don`t have any trigger list. You can create it on the main page', style: AppStyles.bodySmall,),
                                      );
                                    }


                                  },
                                )
                            ],
                          ),
                        ),

                      ],
                    ),

                ),
            ),
    bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
          child: BlocBuilder<MoodBloc, MoodState>(
            builder: (context, state) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Opacity(
                  opacity: true ? 1 : 0.65,
                  child: CupertinoButton(
                      color: AppColors.blue,
                      disabledColor: AppColors.blue,
                      borderRadius: BorderRadius.circular(10),
                      onPressed: true ?
                          () async {
                        await context.read<MoodsBloc>().addMood(state);
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      }
                          :
                      null,
                      child: Text('Save', style: AppStyles.displayMedium.copyWith(color: AppColors.white),)),
                ),
              );
            },
          ),
        )
    ),
    );
  }
}
