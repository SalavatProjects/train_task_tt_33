import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:train_task_tt_33/bloc/moods_bloc.dart';
import 'package:train_task_tt_33/ui_kit/app_styles.dart';
import 'package:train_task_tt_33/ui_kit/colors.dart';
import 'package:train_task_tt_33/utils/constants.dart';
import 'main_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MoodsBloc, MoodsState, int>(
        selector: (state) => state.page,
        builder: (context, page) => Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                  child: IndexedStack(
                    index: page,
                    children: [
                      MainPage(),
                      const Placeholder(),
                      const Placeholder(),
                      const Placeholder(),
                    ],
                  )
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      height: 100,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                        color: AppColors.blue
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            AppConstants.pages.length,
                            (index) => _NavBarBtn(
                                text: AppConstants.pageNames[index],
                                iconPath: AppConstants.pages[index],
                                color: page == index ? AppColors.black : AppColors.white,
                                onTap: () => context.read<MoodsBloc>().updatePage(index))
                        ),
                      )
                  )
              )
            ],
          ),
        )
    );
  }
}


class _NavBarBtn extends StatelessWidget {
  String text;
  String iconPath;
  Color color;
  void Function() onTap;

  _NavBarBtn({
    super.key,
    required this.text,
    required this.iconPath,
    this.color = AppColors.white,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 58,
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            Text(text, style: AppStyles.displaySmall.copyWith(color: color),)
          ],
        ),
      ),
    );
  }
}
