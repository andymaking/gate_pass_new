import 'dart:io';
import 'dart:typed_data';

import 'package:cupertino_modal_sheet/cupertino_modal_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native_image_cropper/native_image_cropper.dart';

import '../../locator.dart';
import '../data/cache/constants.dart';
import '../data/cache/view_state.dart';
import '../utils/app_logger.dart';
import '../utils/snack_message.dart';
import '../widget/action-widget.dart';
import '../widget/image_crop_screen.dart';
import 'home/notification/notificaton.ui.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.Loading;

  ViewState get viewState => _viewState;

  goToNotification() async {
    navigationService.navigateToRoute(const NotificationScreen());
  }

  updateProfile({
    VoidCallback? toDo,
    String? firstName,
    String? lastName,
    String? address,
    String? phoneNumber,
    String? profilePicture,
    String? activeLocationId,
  }) async {
    startLoader();
    try{
      var res = await userService.updateUser(
        firstName: firstName,
        lastName: lastName,
        address: address,
        phoneNumber: phoneNumber,
        profilePicture: profilePicture,
        activeLocationId: activeLocationId,
      );
      stopLoader();
      if(res){
        showCustomToast("Profile updated successfully", success: true);
        if(toDo != null){
          toDo();
        }
      }
    }catch(err){
      stopLoader();
      AppLogger.debug("Error updating profile $err");
    }
  }

  final formKey = GlobalKey<FormState>();
  final GlobalKey repaintKey = GlobalKey();

  String convertPhoneNumber(String number) {
    String replacement = "0";
    if (number.length < 3) {
      // If the input string is less than 3 characters, replace the entire string
      return replacement + number.substring(replacement.length);
    } else {
      // Replace the first 3 characters and concatenate the rest of the string
      return replacement + number.substring(3);
    }
  }

  Future<Uint8List> convertFileToBytes(File file) async {
    try {
      Uint8List bytes = await file.readAsBytes();
      return bytes;
    } catch (e) {
      print("Error reading file: $e");
      return Uint8List(0);
    }
  }

  Future<String?> pickCroppedImage(File imageFile, {double aspectRatio = 390/844, CropMode mode = CropMode.oval}) async {
    try {
      return await navigationService.navigateToRoute(DefaultPage(bytes: await convertFileToBytes(imageFile), aspectRatio: aspectRatio, mode: mode));
    } catch (e) {
      print("Error cropping image: $e");
      return null;
    }
  }


  // getUser() async {
  //   startLoader();
  //   try{
  //     // var res = await repository.getUser();
  //   }catch(err){
  //     debugPrint(err.toString());
  //   }
  //   stopLoader();
  //   notifyListeners();
  // }

  set viewState(ViewState newState) {
    _viewState = newState;
    _viewState == ViewState.Loading ? isLoading = true : isLoading = false;
    notifyListeners();
  }

  logOuts(BuildContext context) {
    popDialog(context: context, onTap: authService.signOut, title: "Log out");
  }

  bool isLoading = false;

  void startLoader() {
    if (!isLoading) {
      isLoading = true;
      viewState = ViewState.Loading;
      notifyListeners();
    }
  }

  Future popDialog({
    required BuildContext context,
    VoidCallback? onTap,
    VoidCallback? otherOnTap,
    String? title,
    String? subTitle,
    String? cancelButtonText,
    String? doItButtonText,
    Widget? prefixIcon1,
    Widget? child,
    Widget? prefixIcon2,
  }) async {
    return await showCupertinoModalSheet(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ActionBottomSheet(
        onTap: onTap,
        title: title,
        subTitle: subTitle,
        cancelButtonText: cancelButtonText,
        doItButtonText: doItButtonText,
        prefixIcon1: prefixIcon1,
        prefixIcon2: prefixIcon2,
        otherOnTap: otherOnTap,
        child: child,
      )
    );
  }

  void stopLoader() {
    if (isLoading) {
      isLoading = false;
      viewState = ViewState.Idle;
      notifyListeners();
    }
  }


}