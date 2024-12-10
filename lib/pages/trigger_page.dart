import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:train_task_tt_33/bloc/moods_bloc.dart';
import 'package:train_task_tt_33/bloc/trigger_bloc.dart';
import 'package:train_task_tt_33/bloc/trigger_state.dart';
import 'package:train_task_tt_33/ui_kit/app_styles.dart';
import 'package:train_task_tt_33/ui_kit/colors.dart';

import '../gen/assets.gen.dart';

class TriggerPage extends StatefulWidget {
  const TriggerPage({super.key});

  @override
  State<TriggerPage> createState() => _TriggerPageState();
}

class _TriggerPageState extends State<TriggerPage> {

  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _triggerTextEditingController = TextEditingController();
  final TextEditingController _commentTextEditingController = TextEditingController();

  final List<String> _triggerSubjectsList = [];

  bool _isNameFilledAndTriggerAdded = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
    create: (context) => TriggerBloc(),
    child: GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
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
                        const Text('My trigger list', style: AppStyles.displayMedium,),
                        const SizedBox(width: 28,)
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.black,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Name of the list', style: AppStyles.displaySmall.copyWith(color: AppColors.white),),
                          const SizedBox(height: 8,),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.white
                            ),
                            child: BlocBuilder<TriggerBloc, TriggerState>(
                              builder: (context, state) {
                              return TextFormField(
                              controller: _nameTextEditingController,
                              onChanged: (String value) {
                                if(value.isNotEmpty) {
                                  if (_triggerSubjectsList.isNotEmpty) {
                                    _isNameFilledAndTriggerAdded = true;
                                  }
                                } else {
                                  _isNameFilledAndTriggerAdded = false;
                                }
                                context.read<TriggerBloc>().updateName(value);
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(40)
                              ],
                              style: AppStyles.bodySmall,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                isDense: true
                              ),
                            );
                            },
                          ),
                          ),
                          const SizedBox(height: 8,),
                          Text('Write down the triggers:', style: AppStyles.displaySmall.copyWith(color: AppColors.white),),
                          const SizedBox(height: 8,),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.white
                            ),
                            child: TextFormField(
                              controller: _triggerTextEditingController,
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
                                        if (_triggerTextEditingController.text.isNotEmpty) {
                                          _triggerSubjectsList.add(_triggerTextEditingController.text);
                                          context.read<TriggerBloc>().updateSubject(_triggerSubjectsList);
                                          _triggerTextEditingController.clear();
                                          if (_nameTextEditingController.text.isNotEmpty) {
                                            _isNameFilledAndTriggerAdded = true;
                                          }
                                        }
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
                          if (_triggerSubjectsList.isNotEmpty)
                            BlocBuilder<TriggerBloc, TriggerState>(
                            builder: (context, state) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                child: Wrap(
                                  spacing: 4,
                                  runSpacing: 4,
                                  children: List.generate(
                                      _triggerSubjectsList.length,
                                      (index) => _TriggerSubjectCard(
                                          text: _triggerSubjectsList[index],
                                          onTap: () {
                                            setState(() {
                                              _triggerSubjectsList.removeAt(index);
                                              context.read<TriggerBloc>().updateSubject(_triggerSubjectsList);
                                              if (_triggerSubjectsList.isNotEmpty){
                                                if (_nameTextEditingController.text.isNotEmpty) {
                                                  _isNameFilledAndTriggerAdded = true;
                                                }
                                              } else {
                                                _isNameFilledAndTriggerAdded = false;
                                              }
                                            });
                                          })),
                                ),
                            );
                            },
                          ),
                          const SizedBox(height: 8,),
                          Text('My comment:', style: AppStyles.displaySmall.copyWith(color: AppColors.white),),
                          const SizedBox(height: 8,),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            constraints: const BoxConstraints(
                              minHeight: 70
                            ),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.white,
                            ),
                            child: BlocBuilder<TriggerBloc, TriggerState>(
                              builder: (context, state) {
                                return TextFormField(
                              controller: _commentTextEditingController,
                              style: AppStyles.bodySmall,
                              maxLines: 3,
                              onChanged: (String value) {
                                context.read<TriggerBloc>().updateComment(value);
                              },
                              decoration: const InputDecoration(
                                  hintText: 'Start typing...',
                                  hintStyle: AppStyles.bodySmall,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true
                              ),
                            );
                            },
                          ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
                child: BlocBuilder<TriggerBloc, TriggerState>(
                builder: (context, state) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Opacity(
                    opacity: _isNameFilledAndTriggerAdded ? 1 : 0.65,
                    child: CupertinoButton(
                        color: AppColors.blue,
                        disabledColor: AppColors.blue,
                        borderRadius: BorderRadius.circular(10),
                        onPressed: _isNameFilledAndTriggerAdded ?
                            () async {
                              await context.read<MoodsBloc>().addTrigger(state);
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
            )),
      ),
    ),
);
  }
}

class _TriggerSubjectCard extends StatelessWidget {
  String text;
  void Function() onTap;

  _TriggerSubjectCard({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white
        ),
        child: Row(
          children: [
            Text(text, style: AppStyles.bodySmall,),
            GestureDetector(
              onTap: onTap,
              child: SizedBox(
                width: 16,
                height: 16,
                child: SvgPicture.asset(Assets.icons.close),
              ),
            )
          ],
        ),
      ),
    );
  }
}
