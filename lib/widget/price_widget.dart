import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:gate_pass/utils/string-extensions.dart';

import '../data/services/local/locale.service.dart';
import '../localization/locales.dart';
import '../locator.dart';

class PriceWidget extends StatelessWidget {
  final dynamic value;
  final double? size;
  final num? spaceSize;
  final Color? color;
  final String? family;
  final bool roundUp;
  final bool? isNegative;
  final Currency? currency;
  final bool isBold;
  final bool usePrefixCurrency;
  final double? height;
  final int? maxLine;
  final TextStyle? style;
  final bool useSymbol;
  final int decimalPlaces;
  final TextAlign? align;
  final double? iconSize;
  final FontWeight? weight;
  final TextOverflow? overflow;
  final FontStyle fontStyle;
  final bool? isHeader;
  final bool isLabel;
  final bool isHidden;
  final bool isTitle;
  final double? letterSpacing;
  final Locale? locale;
  final TextDecoration? decoration;

  const PriceWidget({
    super.key,
    this.value,
    this.size,
    this.color,
    this.roundUp = false,
    this.family,
    this.isBold = false,
    this.isHidden = false,
    this.useSymbol = false,
    this.usePrefixCurrency = false,
    this.weight,
    this.currency,
    this.decimalPlaces = 2,
    this.iconSize,
    this.spaceSize,
    this.align,
    this.height,
    this.maxLine,
    this.style,
    this.overflow,
    this.fontStyle = FontStyle.normal,
    this.isHeader,
    this.isLabel = false,
    this.isTitle = false,
    this.letterSpacing,
    this.locale,
    this.decoration, this.isNegative,
  });

  /// Factory constructors for different styles
  factory PriceWidget.withCurrency({
    dynamic value,
    double? size,
    num? spaceSize,
    required Currency currency,
    Color? color,
    String? family,
    bool roundUp = false,
    bool isBold = false,
    bool usePrefixCurrency = false,
    double? height,
    int? maxLine,
    TextStyle? style,
    bool useSymbol = false,
    int decimalPlaces = 2,
    TextAlign? align,
    double? iconSize,
    bool? isNegative,
    FontWeight? weight,
    TextOverflow? overflow,
    FontStyle fontStyle = FontStyle.normal,
    bool? isHeader,
    bool isLabel = false,
    bool isHidden = false,
    bool isTitle = false,
    double? letterSpacing,
    Locale? locale,
    TextDecoration? decoration,
  }) {
    return PriceWidget(
      value: value,
      size: size,
      spaceSize: spaceSize,
      color: color,
      isNegative: isNegative,
      family: family,
      roundUp: roundUp,
      currency: currency,
      isBold: isBold,
      usePrefixCurrency: usePrefixCurrency,
      height: height,
      maxLine: maxLine,
      style: style,
      useSymbol: useSymbol,
      decimalPlaces: decimalPlaces,
      align: align,
      iconSize: iconSize,
      weight: weight,
      overflow: overflow,
      fontStyle: fontStyle,
      isHeader: isHeader,
      isLabel: isLabel,
      isHidden: isHidden,
      isTitle: isTitle,
      letterSpacing: letterSpacing,
      decoration: decoration,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Format value to 2 decimal places or round up if specified



    double formattedValue = value == null
        ? 0.00
        : roundUp == true
        ? double.tryParse(value.toStringAsFixed(decimalPlaces)) ?? 0.00
        : (double.tryParse(value.toStringAsFixed(decimalPlaces)) ?? 0.00);

    // Define default styles or use provided styles
    TextStyle? styles = style ?? (isTitle?
    Theme.of(context).textTheme.titleLarge?.copyWith(
        fontSize: size ?? 14.sp,
        height: height,
        decoration: decoration,
        letterSpacing: letterSpacing?? -0.25,
        fontFamily: family,
        color: color,
        // fontFamily: family,
        overflow: overflow,
        fontStyle: fontStyle,
        fontWeight: weight ?? (isBold == true ? FontWeight.w700 : FontWeight.w400)
    ):
    isLabel?  Theme.of(context).textTheme.labelMedium?.copyWith(
        fontSize: size ?? 14.sp,
        height: height,
        decoration: decoration,
        letterSpacing: letterSpacing?? -0.25,
        fontFamily: family,
        color: color,
        // fontFamily: family,
        overflow: overflow,
        fontStyle: fontStyle,
        fontWeight: weight ?? (isBold == true ? FontWeight.w700 : FontWeight.w400)
    ):
    Theme.of(context).textTheme.bodyMedium)?.copyWith(
        fontSize: size ?? 14.sp,
        height: height,
        decoration: decoration,
        letterSpacing: letterSpacing?? -0.25,
        fontFamily: family,
        color: color,
        // fontFamily: family,
        overflow: overflow,
        fontStyle: fontStyle,
        fontWeight: weight ?? (isBold == true ? FontWeight.w700 : FontWeight.w400)
    );

    String currencySymbol = getCurrencySymbol(currency ?? Currency.dollar);

    return RichText(
      text: TextSpan(
        children: [
          // Currency Symbol Prefix
          if (isNegative!=null)
            TextSpan(
              text: isNegative==true? "- ": "+ ",
              style: styles,
            ),
          if (useSymbol && usePrefixCurrency)
            TextSpan(
              text: currencySymbol,
              style: styles,
            ),
          if (!useSymbol && usePrefixCurrency)
            TextSpan(
              text: getCurrencyText(currency),
              style: styles,
            ),

          // Formatted Value
          TextSpan(
            text: usePrefixCurrency
                ? " ${isHidden ? "*****" : formatValue(formattedValue, roundUp: roundUp, decimalPlaces: decimalPlaces) }"
                : "${isHidden ? "*****" : formatValue(formattedValue, roundUp: roundUp, decimalPlaces: decimalPlaces)} ",
            style: styles,
          ),

          // Currency Symbol Suffix
          if (useSymbol && !usePrefixCurrency)
            TextSpan(
              text: currencySymbol,
              style: styles,
            ),
          if (!useSymbol && !usePrefixCurrency)
            TextSpan(
              text: getCurrencyText(currency),
              style: styles,
            ),
        ],
      ),
      textAlign: align ?? TextAlign.start,
    );
  }
}

enum Currency { dollar, naira, euro, pounds, yuan, cedi}

String formatValue(num? value, {bool roundUp = false, int decimalPlaces = 2}) {
  if (value == null) {
    return "0.00";
  }

  num processedValue = roundUp
      ? (value * (10 * decimalPlaces)).floor() / (10 * decimalPlaces)
      : value;

  // Use `NumberFormat` from the `intl` package to format the number with commas and specified decimal places
  final formatter = NumberFormat.currency(
    decimalDigits: decimalPlaces,
    symbol: "",
  );

  return formatter.format(processedValue);
}

String getCurrencySymbol(Currency currency) {
  switch (currency) {
    case Currency.dollar:
      return '\$';
    case Currency.naira:
      return '₦';
    case Currency.euro:
      return '€';
    case Currency.pounds:
      return '£';
    case Currency.yuan:
      return '¥';
    default:
      return '';
  }
}

String getCurrencyText(Currency? currency) {
  switch (currency) {
    case Currency.dollar:
      return LocaleData.usd.convertString();
    case Currency.naira:
      return LocaleData.ngn.convertString();
    case Currency.euro:
      return LocaleData.euro.convertString();
    case Currency.pounds:
      return LocaleData.gbp.convertString();
    case Currency.yuan:
      return LocaleData.yuan.convertString();
    default:
      return '';
  }
}