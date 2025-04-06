import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gate_pass/utils/string-extensions.dart';
import 'package:gate_pass/utils/widget_extensions.dart';
import 'package:gate_pass/widget/svg_builder.dart';

import '../../../gen/assets.gen.dart';
import '../../../styles/palette.dart';
import '../../../widget/app-button.dart';
import '../../../widget/app-card.dart';
import '../../../widget/apptexts.dart';
import '../../../widget/text_field.dart';
import '../../base-ui.dart';
import 'communities.vm.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<CommunityViewModel>(
      useFullScreenLoader: true,
      onModelReady: (m)=> m.init(),
      builder: (model, theme) {
        return StreamBuilder(
          stream: model.getUserInfo(),
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Communities"),
              ),
              body:SingleChildScrollView(
                padding: 16.sp.padH,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    20.sp.sbH,
                    AppCard(
                      backgroundColor: const Color(0xFF9F9F9F),
                      padding: 0.0.padA,
                      child: Column(
                        children: [
                          Container(
                            padding: 16.sp.padA,
                            width: width(context),
                            color: black(isAppDark(context)),
                            child: AppText("Communities of ${model.userInfo.firstName??""} ${model.userInfo.lastName??""}."),
                          ),
                          // 16.sp.sbH,
                          Column(
                            children: List.generate(
                                model.userInfo.locations?.length?? 0,
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
                                              AppText(model.userInfo.locations?[index].name??"", isTitle: true, size: 14.sp,),
                                              AppText("${model.userInfo.locations?[index].memberRefs?.length??0} residence", color: stateColor3(isAppDark(context)),)
                                            ],
                                          ),
                                        ),
                                        if(model.userInfo.locations?[index].id != model.userInfo.activeLocation?.id)
                                          AppButton.small(
                                            text: "OPEN",
                                            padding: 5.sp.padH,
                                            height: 25.sp,
                                            onTap: ()=> model.joinLocation(model.userInfo.locations?[index].id??""),
                                          ),
                                        10.sp.sbW,
                                        AppButton.small(
                                          text: "Leave",
                                          color: red9(isAppDark(context)),
                                          height: 25.sp,
                                          padding: 5.sp.padH,
                                          onTap: ()=> model.leaveChannel(model.userInfo.locations?[index].id??""),
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
                    AppCard(
                      backgroundColor: const Color(0xFF9F9F9F),
                      padding: 0.0.padA,
                      child: Column(
                        children: [
                          Container(
                            padding: 16.sp.padA,
                            width: width(context),
                            color: black(isAppDark(context)),
                            child: const AppText("Find your community?"),
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
                              prefix: SvgBuilder(
                                Assets.svg.search,
                                color: stateColor10(isAppDark(context)),
                                size: 24.sp,
                              ),
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
                                        if((model.filteredLocation[index].members??[]).any((test)=> test.id == model.userInfo.id) != true)
                                          AppButton.small(
                                            text: "JOIN",
                                            height: 25.sp,
                                            onTap: ()=> model.join(model.filteredLocation[index].id??""),
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
