import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gate_pass/data/model/user_model.dart';
import 'package:gate_pass/screens/base-ui.dart';
import 'package:gate_pass/styles/palette.dart';
import 'package:gate_pass/utils/string-extensions.dart';
import 'package:gate_pass/utils/widget_extensions.dart';
import 'package:gate_pass/widget/app-button.dart';
import 'package:gate_pass/widget/app-card.dart';
import 'package:gate_pass/widget/apptexts.dart';
import 'package:gate_pass/widget/text_field.dart';

import 'home.vm.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      builder: (model, theme) {
        return StreamBuilder<AppUser?>(
          stream: model.getUserInfo(),
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                padding: 16.sp.padH,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppText("Welcome Back ${model.userInfo?.firstName??""}".toTitleCase(), isTitle: true, size: 32.sp,),
                    20.sp.sbH,
                    if(model.userInfo?.activeLocationRef != null)...[
                      AppCard(
                        backgroundColor: const Color(0xFF9F9F9F),
                        padding: 0.0.padA,
                        child: Column(
                          children: [
                            Container(
                              padding: 16.sp.padA,
                              width: width(context),
                              color: black(isAppDark(context)),
                              child: AppText("Communities of ${model.userInfo?.firstName??""} ${model.userInfo?.lastName??""}."),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.sp,
                                  vertical: 16.sp
                              ),
                              child: AppTextField(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.sp),
                                  borderSide: BorderSide(width: 1.sp, color: stateColor5(isAppDark(context))),
                                ),
                                onChanged: model.onChanged,
                                controller: model.controller,
                              ),
                            ),
                            Column(
                              children: List.generate(
                                  model.userInfo?.locations?.length?? 0,
                                      (index){
                                    return Container(
                                      width: width(context),
                                      padding: 16.sp.padA,
                                      margin: 5.sp.padB,
                                      decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: stateColor9(isAppDark(context))
                                            )
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                AppText(model.userInfo?.locations?[index].name??"", isTitle: true, size: 14.sp,),
                                                AppText("${model.userInfo?.locations?[index].memberRefs?.length??0} residence", color: stateColor3(isAppDark(context)),)
                                              ],
                                            ),
                                          ),
                                          // if((model.userInfo?.locations?n[index].members??[]).any((test)=> test.id == model.userInfo?.id) != true)
                                          AppButton.small(
                                            text: "OPEN",
                                            height: 25.sp,
                                            // onTap: ()=> model.joinLocation(model.filteredLocation[index].id??""),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                              ),
                            )
                          ],
                        ),
                      ),
                      20.sp.sbH,
                    ],
                    AppCard(
                      backgroundColor: const Color(0xFF9F9F9F),
                      padding: 0.0.padA,
                      child: Column(
                        children: [
                          Container(
                            padding: 16.sp.padA,
                            width: width(context),
                            color: black(isAppDark(context)),
                            child: AppText("Find your community?"),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.sp,
                              vertical: 16.sp
                            ),
                            child: AppTextField(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.sp),
                                borderSide: BorderSide(width: 1.sp, color: stateColor5(isAppDark(context))),
                              ),
                              onChanged: model.onChanged,
                              controller: model.controller,
                            ),
                          ),
                          Column(
                            children: List.generate(
                              model.filteredLocation.length,
                              (index){
                                return Container(
                                  width: width(context),
                                  padding: 16.sp.padA,
                                  margin: 5.sp.padB,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: stateColor9(isAppDark(context))
                                      )
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            AppText(model.filteredLocation[index].name??"", isTitle: true, size: 14.sp,),
                                            AppText("${model.filteredLocation[index].memberRefs?.length??0} residence", color: stateColor3(isAppDark(context)),)
                                          ],
                                        ),
                                      ),
                                      if((model.filteredLocation[index].members??[]).any((test)=> test.id == model.userInfo?.id) != true)
                                      AppButton.small(
                                        text: "JOIN",
                                        height: 25.sp,
                                        onTap: ()=> model.joinLocation(model.filteredLocation[index].id??""),
                                      )
                                    ],
                                  ),
                                );
                              }
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }
}
