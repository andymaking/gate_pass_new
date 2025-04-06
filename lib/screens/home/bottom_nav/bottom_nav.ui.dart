import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gate_pass/screens/base-ui.dart';
import 'package:gate_pass/screens/home/bottom_nav/bottom_nav.vm.dart';
import 'package:gate_pass/styles/palette.dart';
import 'package:gate_pass/utils/widget_extensions.dart';
import 'package:gate_pass/widget/app-card.dart';
import 'package:gate_pass/widget/apptexts.dart';
import 'package:gate_pass/widget/svg_builder.dart';

class BottomNavigationScreen extends StatelessWidget {
  final int initialIndex;
  const BottomNavigationScreen({super.key, this.initialIndex =0});

  @override
  Widget build(BuildContext context) {
    return BaseView<BottomNavigationViewModel>(
      onModelReady: (m)=> m.init(initialIndex),
      builder: (model, theme)=> Scaffold(
        body: model.screens[model.index],
        bottomNavigationBar: IntrinsicHeight(
          child: AppCard(
            radius: 0,
            padding: 0.0.padA,
            backgroundColor: const Color(0xFFC5C5C5),
            child: Row(
              children: List.generate(
                model.navs.length,
                (index){
                  return Expanded(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: ()=> model.changeIndex(index),
                      child: Padding(
                        padding: 8.sp.padA,
                        child: Column(
                          children: [
                            SvgBuilder(model.navs[index].activeIcon, size: 24.sp, color: index == model.index? black(isAppDark(context)): stateColor11(isAppDark(context)),),
                            8.sp.sbH,
                            AppText(model.navs[index].name, size: 8.sp, color: index == model.index? black(isAppDark(context)): stateColor11(isAppDark(context)),)
                          ],
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
          ),
        ),
    ));
  }
}
