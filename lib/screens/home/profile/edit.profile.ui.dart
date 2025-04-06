import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gate_pass/data/cache/constants.dart';
import 'package:gate_pass/screens/base-ui.dart';
import 'package:gate_pass/styles/palette.dart';
import 'package:gate_pass/utils/widget_extensions.dart';
import 'package:gate_pass/widget/app-button.dart';
import 'package:gate_pass/widget/app-card.dart';
import 'package:gate_pass/widget/apptexts.dart';
import 'package:gate_pass/widget/default-profile-pic.dart';

import '../../../gen/assets.gen.dart';
import '../../../utils/validator.dart';
import '../../../widget/svg_builder.dart';
import '../../../widget/text_field.dart';
import 'profile.home.vm.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileHomeViewModel>(
      useFullScreenLoader: true,
      onModelReady: (m)=> m.init(),
      builder: (model, theme) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Edit Profile"),
          ),
          body: Form(
            key: model.formKey,
            child: SingleChildScrollView(
              padding: 16.sp.padH,
              child: SizedBox(
                width: width(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.sp.sbH,
                    AppText("Update your profile!" , size: 18.sp, weight: FontWeight.w500,),
                    16.sp.sbH,
                    AppCard(
                      bordered: true,
                      borderColor: white(isAppDark(context)),
                      backgroundColor: Colors.transparent,
                      child: Row(
                        spacing: 16.sp,
                        children: [
                          ProfilePic(
                            user: model.user,
                            size: 56.sp,
                            picture: model.image?.path,
                            onTap: model.showIosBottomPopup,
                          ),
                          AppCard(
                            expandable: true,
                            onTap: model.showIosBottomPopup,
                            heights: 44.sp,
                            backgroundColor: white(isAppDark(context)),
                            widths: 144.sp,
                            padding: 0.0.padA,
                            child: Center(
                              child: AppText(
                                "Change Photo",
                                color: black(isAppDark(context)),
                                weight: FontWeight.w700,
                                size: 16.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    10.sp.sbH,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        16.sp.sbH,
                        AppTextField(
                          controller: model.firstName,
                          hint: "Enter first name",
                          validator: emptyValidator,
                          onChanged: model.onChanged,
                        ),
                        16.sp.sbH,
                        AppTextField(
                          controller: model.lastName,
                          hint: "Enter last name",
                          validator: emptyValidator,
                          onChanged: model.onChanged,
                        ),
                        16.sp.sbH,
                        AppTextField(
                          controller: model.email,
                          readonly: true,
                          enabled: false,
                          keyboardType: TextInputType.emailAddress,
                          hint: "Enter email address",
                          validator: emailValidator,
                          onChanged: model.onChanged,
                        ),
                        16.sp.sbH,
                        AppTextField(
                          controller: model.phoneNumber,
                          keyboardType: TextInputType.emailAddress,
                          hint: "Enter phone number",
                          validator: emptyValidator,
                          onChanged: model.onChanged,
                        ),
                        16.sp.sbH,
                        AppTextField(
                          controller: model.address,
                          keyboardType: TextInputType.emailAddress,
                          hint: "Enter resident address",
                          validator: emptyValidator,
                          onChanged: model.onChanged,
                        ),
                        24.sp.sbH,
                        AppButton.fullWidth(
                          isLoading: model.isLoading,
                          text: "UPDATE PROFILE",
                          onTap: model.formKey.currentState?.validate() == true? model.updates : null,
                        ),
                        30.sp.sbH,
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
