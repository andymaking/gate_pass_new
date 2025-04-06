import 'package:flutter_localization/flutter_localization.dart';

const List<MapLocale> LOCALES =[
  MapLocale("en", LocaleData.EN),
];

mixin LocaleData {

  static const String emptyPhoneNumber = 'emptyPhoneNumber';
  static const String invalidPhoneNumber = 'invalidPhoneNumber';
  static const String password8 = 'password8';
  static const String passwordNumber = 'passwordNumber';
  static const String passwordCapital = 'passwordCapital';
  static const String continues = 'continues';
  static const String passwordSmall = 'passwordSmall';
  static const String passwordSign = 'passwordSign';
  static const String enterPassword = 'enterPassword';
  static const String emptyField = 'emptyField';
  static const String confirmPassword = 'confirmPassword';
  static const String confirmPasswordSamePassword = 'confirmPasswordSamePassword';
  static const String inputYourPhoneNumber = 'inputYourPhoneNumber';
  static const String seeLess = 'seeLess';
  static const String seeMore = 'seeMore';
  static const String euro = 'euro';
  static const String gbp = 'gbp';
  static const String ngn = 'ngn';
  static const String usd = 'usd';
  static const String yuan = 'yuan';
  static const String cedis = 'cedis';
  static const String crop = 'crop';
  static const String imageCropper = 'imageCropper';
  static const String no = 'no';
  static const String yes = 'yes';
  static const String areYouSureYouWantTo = 'areYouSureYouWantTo';
  // static const String imageCropper = 'imageCropper';
  // static const String imageCropper = 'imageCropper';


  static const Map<String, dynamic> EN = {
    emptyPhoneNumber: "Phone Number cannot be empty",
    continues: "Continue",
    no: "No",
    yes: "Yes",
    areYouSureYouWantTo: "Are you sure you want to %a",
    // continues: "Continue",
    // continues: "Continue",
    seeLess: "See Less",
    imageCropper: "Image Cropper",
    seeMore: "See More",
    inputYourPhoneNumber: "Invalid Phone Number",
    password8: "8 characters minimum",
    enterPassword: "Enter Password",
    confirmPassword: "Confirm Password",
    passwordNumber: "A number",
    passwordCapital: "CAPITAL letter",
    passwordSmall: "small letter",
    emptyField: "Field Cannot be empty",
    confirmPasswordSamePassword: "Confirm password Must be equal to password",
    passwordSign: "Password must contain signs (\$-@!*)",
    invalidPhoneNumber: "Invalid Phone Number",
    crop: "Crop",
    euro: "EUR",
    gbp: "GBP",
    ngn: "NGN",
    usd: "USD",
    yuan: "Yuan",
    cedis: "Cedis",



  };

}