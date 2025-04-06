import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gate_pass/data/cache/constants.dart';
import 'package:gate_pass/data/model/vistor_pass_model.dart';
import 'package:gate_pass/screens/base-ui.dart';
import 'package:gate_pass/styles/palette.dart';
import 'package:gate_pass/utils/string-extensions.dart';
import 'package:gate_pass/utils/utils.dart';
import 'package:gate_pass/utils/widget_extensions.dart';
import 'package:gate_pass/widget/app-card.dart';
import 'package:gate_pass/widget/apptexts.dart';
import 'package:gate_pass/widget/svg_builder.dart';
import 'package:gate_pass/widget/text_field.dart';

import '../../../gen/assets.gen.dart';
import '../bottom_nav/bottom_nav.ui.dart';
import 'home_screen.vm.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeScreenViewModel>(
      builder: (model, theme)=> Scaffold(
        appBar: AppBar(
          title: Text(("Hi, ${userService.user.firstName??""}").toTitleCase()),
          actions: [
            InkWell(
              onTap: model.goToNotification,
              child: Padding(
                padding: 8.sp.padA,
                child: SvgBuilder(
                  Assets.svg.notification,
                  size: 25.sp,
                ),
              ),
            ),
            8.sp.sbW,
          ],
        ),
        body: SingleChildScrollView(
          padding: 16.sp.padH,
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: AppTextField(
                      hint: "Search visitors",
                    ),
                  ),
                  Container(
                    color: black(isAppDark(context)),
                    padding: 11.sp.padA,
                    child: SvgBuilder(
                      Assets.svg.search,
                      size: 25.sp,
                    ),
                  ),
                ],
              ),
              30.sp.sbH,
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing:16.sp,
                  mainAxisSpacing: 16.sp,
                  childAspectRatio: 1.5,
                  // mainAxisExtent: MediaQuery.of(context).size.width/ 2,
                  mainAxisExtent: 88.h,
                ),
                children: [
                  HomeCard(
                    title: "Visitors weekly",
                    value: "0",
                  ),
                  HomeCard(
                    title: "Most Frequent Visitor",
                    value: "None",
                  ),
                  HomeCard(
                    title: "Longest Stay",
                    value: "None",
                  ),
                  HomeCard(
                    title: "Communities",
                    value: "${userService.user.locationRefs?.length??0}",
                  ),
                ],
              ),
              30.sp.sbH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    "Recent",
                    isTitle: true,
                    size: 16.sp,
                  ),
                  InkWell(
                    onTap: ()=> navigationService.navigateToAndRemoveUntilWidget(const BottomNavigationScreen(initialIndex: 1,)),
                    child: AppText(
                      "View All",
                      size: 16.sp,
                      weight: FontWeight.w500,
                      color: black(isAppDark(context)),
                    ),
                  ),
                ],
              ),
              16.sp.sbH,
              if(model.myPass.isEmpty)...[
                SizedBox(
                  height: 300.sp,
                  width: width(context),
                  child: const Center(
                    child: AppText("No pass given out yet"),
                  ),
                )
              ] else
              Column(
                children: List.generate(
                  model.myPass.length,
                  (index){
                    return ContainerViewPass(pass: model.myPass[index], onTap: model.goToPassCodeScreen,);
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final String title;
  final String value;
  const HomeCard({
    super.key, required this.title, required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: Colors.white,
      radius: 0.sp,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AppText(title, isLabel: true, size: 14.sp,),
          AppText(value, isTitle: true, size: 16.sp, color: black(isAppDark(context)),),
        ],
      ),
    );
  }
}

class ContainerViewPass extends StatelessWidget {
  final VisitorPass pass;
  final Function(VisitorPass) onTap;
  const ContainerViewPass({super.key, required this.pass, required this.onTap});

  @override
  Widget build(BuildContext context) {
    String joinWithDash(List<String> items) {
      return items.join('\n');
    }
    return InkWell(
      onTap: ()=> onTap(pass),
      child: Container(
        padding: 16.sp.padV,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: black(isAppDark(context)).withValues(alpha: 0.5), width: 1.sp)
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 14.sp,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  "${(Utils.formatDateTime(pass.startTime)).split(", ").last} - ${(Utils.formatDateTime(pass.endTime)).split(", ").last}",
                ),
                AppText(
                  "${(Utils.formatDateTime(pass.startTime)).split(", ").first} - ${(Utils.formatDateTime(pass.endTime)).split(", ").first}",
                ),

                // AppText(value, color: black(isAppDark(context)), size: size?? 18.sp, weight: FontWeight.w700,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  joinWithDash(pass.visitors.map((t)=> t.fullName).toList()),
                ),
                Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 4.sp, horizontal: 16.sp
                    ),
                    color: black(isAppDark(context)),
                    child: AppText(
                      Utils.getPassStatus(pass.startTime, pass.endTime),
                      color: white(isAppDark(context)),
                      size: 10.sp,
                    )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}