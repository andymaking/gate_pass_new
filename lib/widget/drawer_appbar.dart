import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gate_pass/utils/widget_extensions.dart';

import '../gen/assets.gen.dart';
import '../styles/palette.dart';
import 'apptexts.dart';
import 'svg_builder.dart';

class DrawerAppBar extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final bool centerTitle;
  const DrawerAppBar({
    super.key,
    this.title,
    this.subTitle,
    required this.centerTitle
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if(centerTitle)...[
          30.sp.sbW,
        ],
        Expanded(
            child: Column(
              crossAxisAlignment: centerTitle? CrossAxisAlignment.center: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(title!=null)...[
                  AppText(title??"", isTitle: true, isBold: true, size: 16.sp,)
                ],
                if(subTitle!=null)...[
                  AppText(subTitle??"", size: 14.sp,)
                ]
              ],
            )
        ),
        10.sp.sbW,
        InkWell(
          onTap: Navigator.of(context).pop,
          child: Container(
            height: 24.sp,
            alignment: Alignment.center,
            width: 24.sp,
            decoration: BoxDecoration(
                color: stateColor11(isAppDark(context)),
                shape: BoxShape.circle
            ),
            child: SvgBuilder(
              Assets.svg.close,
              size: 16.sp,
              color: stateColor11(isAppDark(context)),
            ),
          ),
        )
      ],
    );
  }
}