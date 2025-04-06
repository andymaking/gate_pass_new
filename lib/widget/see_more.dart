import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gate_pass/utils/string-extensions.dart';

import '../localization/locales.dart';
import '../styles/palette.dart';
import '../utils/widget_extensions.dart';

class SeeMoreText extends StatefulWidget {
  final String text;
  final int maxLength;
  final double? fontSize;
  final FontWeight? weight;
  final TextAlign? align;
  final Color? color;

  SeeMoreText(this.text, {this.maxLength = 19,  this.fontSize, this.weight, this.align, this.color});

  @override
  _SeeMoreTextState createState() => _SeeMoreTextState();
}

class _SeeMoreTextState extends State<SeeMoreText> {
  bool _showFullText = false;

  @override
  Widget build(BuildContext context) {
    final String displayedText = _showFullText || widget.maxLength >= widget.text.length ? widget.text : widget.text.substring(0, widget.maxLength);

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$displayedText${_showFullText == false? "...":" "}",
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: widget.fontSize?? 14.sp,
              fontWeight: widget.weight,
              color: widget.color,
            ),
          ),
          TextSpan(
              text: _showFullText ? LocaleData.seeLess.convertString() : LocaleData.seeMore.convertString(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  color: blue9(isAppDark(context)),
                  fontWeight: FontWeight.w400
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = (){
                  setState(() {
                    _showFullText = !_showFullText;
                  });
                }
          ),
        ],
      ),
      textAlign: TextAlign.start,
    );
  }
}