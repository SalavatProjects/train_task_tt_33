import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:train_task_tt_33/ui_kit/app_styles.dart';
import 'package:train_task_tt_33/ui_kit/colors.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../bloc/moods_bloc.dart';
import '../bloc/trigger_bloc.dart';
import '../bloc/trigger_state.dart';
import '../gen/assets.gen.dart';

class MoodPage extends StatefulWidget {
  const MoodPage({super.key});

  @override
  State<MoodPage> createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {

  final List<List<dynamic>> _moodsList = [
    [AppColors.yellow, 'Happy', Assets.icons.happy, 0],
    [AppColors.violet, 'Sad', Assets.icons.unhappy, 1],
    [AppColors.red, 'Angry', Assets.icons.angryFace, 2,],
    [AppColors.green, 'Anxiety', Assets.icons.confusedFace, 3],
  ];

  final TextEditingController _reasonTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                            BlocSelector<MoodsBloc, MoodsState, int?>(
                              selector: (state) => state.moodType,
                              builder: (context, moodType) {
                                  return GestureDetector(
                                  onTap: () async {
                                    const double top = 120;
                                    const double left = 100;
                                    List<List<dynamic>> menuMoodsList = List.from(_moodsList);
                                    List<dynamic> currentMood = menuMoodsList.removeAt(moodType);
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
                                              onTap: () => context.read<MoodsBloc>().updateMoodType(currentMood[3]),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  SvgPicture.asset(currentMood[2], width: 16,),
                                                  Text(currentMood[1], style: AppStyles.displaySmall,),
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
                                              onTap: () => context.read<MoodsBloc>().updateMoodType(menuMoodsList[index][3]),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  SvgPicture.asset(menuMoodsList[index][2], width: 16,),
                                                  const SizedBox(width: 4,),
                                                  Text(menuMoodsList[index][1], style: AppStyles.displaySmall,)
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
                                        color: _moodsList[moodType!][0]
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SvgPicture.asset(_moodsList[moodType][2], width: 16,),
                                          Text(_moodsList[moodType][1], style: AppStyles.displaySmall,),
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
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                isDense: true,
                                suffixIconConstraints: const BoxConstraints(
                                  maxWidth: 18,
                                  maxHeight: 18,
                                ),
                                suffixIcon: BlocBuilder<TriggerBloc, TriggerState>(
                                  builder: (context, state) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {

                                        });
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
                                    );
                                  },
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

          ),
      ),
    );
  }
}
