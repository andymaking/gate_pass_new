import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:gate_pass/data/services/local/locale.service.dart';
import 'package:gate_pass/utils/string-extensions.dart';
import 'package:gate_pass/widget/svg_builder.dart';

import '../gen/assets.gen.dart';
import '../localization/locales.dart';
import '../locator.dart';
import '../styles/palette.dart';
import '/utils/widget_extensions.dart';
import 'apptexts.dart';

class AppTextField extends StatefulWidget {
  final String? hintText;
  final String? Function(String?)? validator;
  final String? hint;
  final String? labelText;
  final bool readonly;
  final double? percentage;
  final bool useBorder;
  final bool isPassword;
  final InputBorder? border;
  final bool showError;
  final Widget? suffixIcon;
  final Widget? errorWidget;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? label;
  final Widget? prefix;
  final Widget? prefixIcon;
  final double? textSize;
  final double? borderRadius;
  final TextAlign textAlign ;
  final Color? hintColor;
  final Color? bodyTextColor;
  final Color? fillColor;
  final Color? textColor;
  final bool? enabled;
  final bool? overrideIconColor;
  final VoidCallback? onTap;
  final AutovalidateMode? autoValidateMode;
  final InputBorder? enabledBorder;
  final int? maxLength;
  final int? minLines;
  final int? maxHeight;
  final TextStyle? style;
  final bool? haveText;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  const AppTextField(
      {super.key,
        this.readonly = false,
        this.useBorder = true,
        this.isPassword = false,
        this.showError = true,
        this.percentage,
        this.hintText,
        this.hint,
        this.onChanged,
        this.controller,
        this.keyboardType = TextInputType.text,
        this.textAlign = TextAlign.start,
        this.onTap,
        this.onEditingComplete,
        this.onFieldSubmitted,
        this.validator,
        this.autofillHints,
        this.suffixIcon,
        this.textSize,
        this.haveText,
        this.maxLength,
        this.labelText,
        this.label,
        this.contentPadding,
        this.prefix,
        this.maxHeight = 1,
        this.hintColor,
        this.textColor,
        this.inputFormatters,
        this.errorWidget,
        this.enabled,
        this.fillColor,
        this.overrideIconColor,
        this.enabledBorder,
        this.autoValidateMode,
        this.borderRadius,
        this.bodyTextColor,
        this.textInputAction, this.prefixIcon, this.border, this.style, this.minLines
      });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final FocusNode _focusNode = FocusNode();
  bool isVisible = false;


  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        isVisible = false;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    bool isDark = Theme.of(context).primaryColor == const Color(0xFFEDF0F0);
    double percentage = widget.percentage ?? 0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.hintText != null
            ? Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: AppText(
                    widget.hintText ?? "",
                    size: widget.textSize ?? 15.sp,
                    align: TextAlign.start,
                    weight: FontWeight.w500,
                    color: widget.hintColor,
                  ),
                ),
                if(widget.percentage!=null)...[
                  ClipRRect(
                    borderRadius:BorderRadius.circular(4.r),
                    child: Container(
                      width: 80.sp,
                      height: 6.sp,
                      color: Theme.of(context).inputDecorationTheme.fillColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 6.sp,
                            width: 80.sp * (widget.percentage??0)/100,
                            color: widget.percentage == null || percentage < 50? Colors.red : percentage==50 || percentage < 75? amber7(isDark): green8(isDark),
                          ),
                        ],
                      ),
                    ),
                  )
                ]
              ],
            ),
            5.0.sbH,
          ],
        )
            : 0.0.sbH,
        Row(
          children: [
            Expanded(
              child: TextFormField(
                textAlign: widget.textAlign,
                validator: widget.validator,
                autofillHints: widget.autofillHints,
                onEditingComplete: widget.onEditingComplete,
                autovalidateMode: widget.autoValidateMode,
                onFieldSubmitted: widget.onFieldSubmitted,
                maxLines: widget.maxHeight,
                focusNode: _focusNode,
                maxLength: widget.maxLength,
                minLines: widget.minLines,
                onChanged: (val) {
                  if (widget.onChanged != null) {
                    widget.onChanged!(val);
                  }
                },
                onTap: widget.onTap,
                readOnly: widget.readonly,
                enabled: widget.enabled,
                obscureText: widget.isPassword ? !isVisible : false,
                textInputAction: widget.textInputAction?? TextInputAction.next,
                style: widget.style?? Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16.sp, color: Colors.black),
                controller: widget.controller,
                inputFormatters: widget.inputFormatters,
                decoration: InputDecoration(
                    border: widget.border,
                    focusedBorder: widget.border,
                    focusedErrorBorder: widget.border,
                    enabledBorder: widget.border,
                    errorBorder: widget.border,
                    errorMaxLines: 3,
                    counter: 0.0.sbH,
                    hintText: widget.hint,
                    fillColor: widget.fillColor,
                    enabled: widget.enabled ?? true,
                    error: widget.errorWidget,
                    prefixIcon: widget.prefixIcon?? (widget.prefix==null? null : SizedBox(height: 30.sp, width: 30.sp ,child: Align(alignment: Alignment.center, child: widget.prefix))),
                    suffixIcon: widget.suffixIcon ?? (widget.isPassword
                        ? IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: widget.suffixIcon ??
                            SvgBuilder(isVisible
                                ? Assets.svg.visibilityOff
                                : Assets.svg.visible, size: 20.sp,
                            ))
                        : widget.suffixIcon
                    ),
                    label: widget.label,
                    labelText: widget.labelText,
                    contentPadding: widget.contentPadding,
                    errorStyle: Theme.of(context).inputDecorationTheme.errorStyle?.copyWith(
                      fontSize: !widget.showError? 0.sp: null,

                    )

                ),
                keyboardType: widget.keyboardType,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CustomPhoneNumberInput extends StatelessWidget {
  final Function? onSubmit;
  final double? textSize;
  final double? borderWidth;
  final double? radius;
  final Color? hintColor;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String?)? validator;
  final Function(PhoneNumber)? onSaved;
  final Function(PhoneNumber)? onInputChanged;
  final String? isoCode;
  final String? hint;
  final String? hintText;
  final PhoneNumber? initialValue;
  final String? labelText;
  final bool enabled;
  final bool useBorder;
  final bool isError; // New property to indicate error
  final TextEditingController? controller;

  const CustomPhoneNumberInput({
    super.key,
    this.onSubmit,
    this.onSaved,
    this.isoCode,
    this.onInputChanged,
    this.controller,
    this.hint,
    this.textSize,
    this.hintColor,
    this.validator,
    this.enabled = true,
    this.useBorder = true,
    this.borderWidth,
    this.radius,
    this.contentPadding,
    this.labelText,
    this.hintText,
    this.isError = false, this.initialValue, this.fillColor, // Default to no error
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hintText != null
            ? Column(
          children: [
            AppText(
              hintText ?? "",
              size: textSize ?? 15.sp,
              color: hintColor ?? Theme.of(context).textTheme.bodyMedium?.color,
              align: TextAlign.start,
              weight: FontWeight.w500,
            ),
            5.0.sbH,
          ],
        )
            : 0.0.sbH,
        Container(
          padding: 16.sp.padH,
          decoration: BoxDecoration(
            color: fillColor ?? Theme.of(context).inputDecorationTheme.fillColor,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: isError ? Theme.of(context).inputDecorationTheme.errorStyle!.color! : stateColor6(isAppDark(context)), // Change border color based on isError
              width: borderWidth ?? 1.sp,
            ),
          ),
          child: InternationalPhoneNumberInput(
            textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16.sp),
            onInputChanged: (PhoneNumber number) => onInputChanged!(number),
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: false,
            ),
            locale: locator<LocaleService>().language,
            spaceBetweenSelectorAndTextField: 0,
            // initialValue: PhoneNumber(isoCode: 'US'),
            isEnabled: enabled,
            selectorButtonOnErrorPadding: 0,
            initialValue: initialValue,
            inputDecoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              contentPadding: contentPadding,
              hintText: hint ?? LocaleData.inputYourPhoneNumber.convertString(),
              errorStyle: TextStyle(fontSize: 0.sp),
            ),
            textFieldController: controller,
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.DIALOG,
            ),
            ignoreBlank: true,
            selectorTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16.sp,),
            autoValidateMode: AutovalidateMode.disabled,
            onSaved: (PhoneNumber number) => {onSaved!(number)},
            onSubmit: () => onSubmit!(),
            validator: validator,
          ),
        ),
        if(isError)...[
          5.sp.sbH,
          Padding(
            padding: 16.sp.padL,
            child: AppText(
              LocaleData.invalidPhoneNumber.convertString(),
              style: TextStyle(
                color: Theme.of(context).inputDecorationTheme.errorStyle?.color,
                fontSize: 13.33.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ]
      ],
    );
  }
}

class NewDropDownSelect extends StatelessWidget {
  final String? hintText;
  final String? hint;
  final double? height;
  final double? fontSize;
  final double? textSize;
  final bool enabled;
  final Color? hintColor;
  final Color? fillColor;
  final bool useBorder;
  final Widget? prefix;
  final String? value;
  final EdgeInsetsGeometry? contentPadding;
  final List<String>? items;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String? value)? onChanged;
  final VoidCallback? onTap;
  const NewDropDownSelect({super.key,
    this.hintText,
    this.hint,
    this.value,
    this.items,
    this.onChanged, this.validator, this.inputFormatters, this.height,
    this.textSize, this.hintColor, this.prefix,
    this.contentPadding, this.fillColor, this.useBorder = true,
    this.enabled = true, this.fontSize, this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hintText != null
            ? Column(
          children: [
            AppText(
              hintText ?? "",
              size: textSize ?? 15.sp,
              color :hintColor ?? Theme.of(context).textTheme.bodyMedium?.color,
              // isBold: true,
              align: TextAlign.start,
              weight: FontWeight.w500,
            ),
            5.0.sbH,
          ],
        )
            : 0.0.sbH,
        Container(
          alignment: Alignment.centerLeft,
          child: DropdownButtonFormField(
            borderRadius: BorderRadius.circular(12),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: fontSize?? 16.sp),
            icon: const Icon(Icons.keyboard_arrow_down),
            value: value,
            items: items
                ?.map((e) => DropdownMenuItem(
              value: e,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      e,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: fontSize??  16.sp),
                    ),
                  ),
                ],
              ),
            ))
                .toList(),
            onChanged: onChanged,
            onTap: onTap,
            isExpanded: true,
            dropdownColor: Theme.of(context).cardColor,
            validator: validator,
            decoration: InputDecoration(
              errorMaxLines: 3,
              isDense: true,
              hintText: hint,
              prefix: prefix,
              filled: true,
              enabled: enabled,
              fillColor: fillColor,
              contentPadding: contentPadding,
              focusedBorder: !useBorder? InputBorder.none: null,
              enabledBorder: !useBorder? InputBorder.none: null,
              errorBorder: !useBorder? InputBorder.none: null,
              disabledBorder: !useBorder? InputBorder.none: null,
              border: !useBorder? InputBorder.none: null,
              focusedErrorBorder: !useBorder? InputBorder.none: null,

            ),
          ),
        )
      ],
    );
  }
}

class TextArea extends StatelessWidget {
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode;
  final TextAlign? textAlign;
  final TextInputType? keyBoardType;
  final String? Function(String? val)? validationCallback;
  final void Function()? onEdittingComplete;
  final String? formError;
  final String? label;
  final String? hint;
  final String? hintText;
  final FocusNode? focusnode;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final Function()? clearForm;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final Function(String)? onChanged;
  final int? maxLength;
  final bool? enabled;
  final InputBorder? border;
  final Color? fillColor;
  final Color? hintColor;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputAction? textInputAction;
  final bool? showCursor;
  final bool readOnly;
  final bool autofocus;
  final Widget? labelRightItem;
  final TextStyle? labelStyle;
  final int? minLines;
  final int? maxLines;

  const TextArea({super.key,
    this.autovalidateMode,
    this.inputFormatters,
    this.textAlign,
    this.keyBoardType,
    this.validator,
    this.onEdittingComplete,
    this.validationCallback,
    this.hintText,
    this.label,
    this.hint,
    this.formError,
    this.focusnode,
    this.controller,
    this.clearForm,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.onChanged,
    this.onTap,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.enabled = true,
    this.autofocus = true,
    this.border,
    this.fillColor,
    this.hintColor,
    this.showCursor,
    this.readOnly = false,
    this.labelRightItem,
    this.labelStyle,
    this.contentPadding,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        hintText == null ?0.0.sbH:AppText(
          hintText??"",
          size: 15.sp,
          align: TextAlign.start,
          weight: FontWeight.w500,
          color :hintColor ?? Theme.of(context).textTheme.bodyMedium?.color,
        ),
        hintText == null ? 0.0.sbH:8.0.sbH,
        TextFormField(
          showCursor: showCursor,
          readOnly: readOnly,
          maxLength: maxLength,
          enabled: enabled,
          onTap: onTap,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14.sp, color: Colors.black),
          minLines: minLines,
          autofocus: autofocus,
          maxLines: maxLines,
          focusNode: focusnode,
          controller: controller,
          textInputAction: textInputAction?? TextInputAction.next,
          decoration: InputDecoration(
              counterText: null,
              hintText: hint,
              fillColor: fillColor,
              errorText: formError,
              labelText: label,
              suffixIcon: suffixIcon,
              prefix: prefixIcon,
              contentPadding: contentPadding,
              border: border,
              focusedBorder: border,
              focusedErrorBorder: border,
              enabledBorder: border,
              errorBorder: border,
              isDense: true
          ),
          textAlign: textAlign ?? TextAlign.start,
          inputFormatters: inputFormatters,
          keyboardType: keyBoardType,
          onChanged: onChanged,

          validator: validator,
          onEditingComplete: onEdittingComplete,
          obscureText: obscureText ?? false,
        ),
      ],
    );
  }
}