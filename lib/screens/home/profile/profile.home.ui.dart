import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gate_pass/data/cache/constants.dart';
import 'package:gate_pass/screens/base-ui.dart';
import 'package:gate_pass/styles/palette.dart';
import 'package:gate_pass/utils/widget_extensions.dart';
import 'package:gate_pass/widget/app-button.dart';
import 'package:gate_pass/widget/apptexts.dart';
import 'package:gate_pass/widget/default-profile-pic.dart';

import '../../../gen/assets.gen.dart';
import '../../../widget/svg_builder.dart';
import 'profile.home.vm.dart';

class ProfileHomeScreen extends StatelessWidget {
  const ProfileHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileHomeViewModel>(
      onModelReady: (m)=> m.init(),
      builder: (model, theme) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
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
          body: StreamBuilder(
            stream: model.getUserInfo(),
            builder: (context, snapshot) {
              return SingleChildScrollView(
                padding: 16.sp.padH,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProfilePic(
                      user: model.user,
                      size: 80.sp,
                    ),
                    10.sp.sbH,
                    AppText(
                      "${model.user.firstName??""} ${model.user.lastName??""}",
                      weight: FontWeight.w700,
                      size: 20.sp,
                      color: white(isAppDark(context)),
                    ),
                    5.sp.sbH,
                    AppText(
                      model.user.email??"",
                      size: 12.sp,
                      color: white(isAppDark(context)),
                    ),
                    16.sp.sbH,
                    AppButton.outline(
                      text: "Edit Profile",
                      borderColor: Colors.white54,
                      textColor: Colors.white,
                      onTap: model.goToEditProfile,
                    ),
                    ProfileOptions(
                      title: "Email Address",
                      value: model.user.email??"",
                    ),
                    ProfileOptions(
                      title: "Phone Number",
                      value: model.user.phone??"",
                    ),
                    ProfileOptions(
                      title: "Address",
                      value: model.user.address??"",
                    ),
                    ProfileOptions(
                      title: "Password",
                      value: "Reset Password",
                      otherText: "Last Reset on 17/11/24",
                      valueColor: black(isAppDark(context)),
                    ),
                    40.sp.sbH,
                    AppButton.transparent(
                      text: "Logout",
                      textColor: red11(false),
                      onTap: (){
                        model.popDialog(context: context, title: "Logout", onTap: authService.signOut);
                      },
                    )

                  ],
                ),
              );
            }
          ),
        );
      }
    );
  }
}


class ProfileOptions extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;
  final String? otherText;
  const ProfileOptions({super.key, required this.title, required this.value, this.otherText, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      padding: 15.sp.padV,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(title, isLabel: true, size: 14.sp,),
          5.sp.sbH,
          AppText(value, weight: FontWeight.w500, size: 16.sp, color: valueColor,),
          if(otherText != null)...[
            5.sp.sbH,
            AppText(otherText??"", weight: FontWeight.w500, size: 14.sp,),
          ]
        ],
      ),
    );
  }
}
