import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gate_pass/localization/locales.dart';
import 'package:gate_pass/styles/palette.dart';
import 'package:gate_pass/utils/string-extensions.dart';

import '../data/cache/constants.dart';
import '../data/cache/palette.dart';
import '../utils/widget_extensions.dart';
import 'app-button.dart';
import 'apptexts.dart';

class ActionBottomSheet extends StatelessWidget {
  final String? title;
  final Widget? body;
  final String? subTitle;
  final String? cancelButtonText;
  final String? doItButtonText;
  final VoidCallback? otherOnTap;
  final Widget? prefixIcon1;
  final Widget? child;
  final Widget? prefixIcon2;
  final VoidCallback? onTap;
  const ActionBottomSheet({Key? key, required this.title, required this.onTap, this.subTitle, this.cancelButtonText, this.doItButtonText, this.prefixIcon1, this.prefixIcon2, this.otherOnTap, this.body, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (){},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16.sp)
                  ),
                  margin: 16.0.padA,
                  padding: 16.0.padA,
                  child: child?? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      10.sp.sbH,
                      AppText(title??"", isTitle: true,),
                      10.sp.sbH,
                      AppText(convertListString(LocaleData.areYouSureYouWantTo.convertString(), data: [(title??"").toLowerCase()]), color: stateColor10(isAppDark(context)), align: TextAlign.center,),
                      40.sp.sbH,
                      body??Row(
                        children: [
                          Expanded(
                              child: AppButton.transparent(
                                isLoading: false,
                                text: cancelButtonText?? LocaleData.no.convertString(),
                                textColor: primaryColor,
                                onTap: otherOnTap?? navigationService.goBack,
                              )
                          ),
                          29.0.sbW,
                          Expanded(
                              child: AppButton.fullWidth(
                                isLoading: false,
                                text: doItButtonText?? LocaleData.yes.convertString(),
                                onTap: ()async{
                                  navigationService.goBack();
                                  onTap ==null? null: onTap!();
                                },
                                textColor: Colors.white,
                              )
                          ),
                        ],
                      ),
                      10.sp.sbH,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}