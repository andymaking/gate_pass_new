import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:gate_pass/styles/palette.dart';
import 'package:gate_pass/styles/palette.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gate_pass/data/cache/constants.dart';
import 'package:gate_pass/data/model/user_model.dart';
import 'package:gate_pass/screens/base-vm.dart';
import 'package:gate_pass/utils/app_logger.dart';
import 'package:gate_pass/utils/snack_message.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widget/apptexts.dart';
import 'edit.profile.ui.dart';

class ProfileHomeViewModel extends BaseViewModel {

  init(){
    user = userService.user;
    firstName = TextEditingController(text: user.firstName);
    lastName = TextEditingController(text: user.lastName);
    email = TextEditingController(text: user.email);
    phoneNumber = TextEditingController(text: user.phone);
    address = TextEditingController(text: user.address);
    getUserInfo();
  }

  AppUser user = AppUser();

  Stream<AppUser> getUserInfo() async*{
    init();
    userService.getCurrentUserData().listen((users){
      user = users?? user;
    });
    yield user;
  }

  File? image;

  updates() async {
    try {
      await updateProfile(
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        address: address.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
      );
    }catch (err){
      AppLogger.debug("De error :: $err");
    }
  }

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();

  selectImage({ImageSource source = ImageSource.gallery}) async {
    XFile? file = await ImagePicker().pickImage(source: source);
    if(file != null){
      var res = await pickCroppedImage(File(file.path), aspectRatio: 1);
      image = res == null? null : File(res);
      if(image != null){
        await uploadToCloudinary(image!).then((val) async {
          if(val != null){
            await updateProfile(profilePicture: val);
          }
        });
      }
    }
    notifyListeners();
  }

  onChanged(String? val) async {
    formKey.currentState!.validate();
    notifyListeners();
  }

  goToEditProfile() async {
    await navigationService.navigateToRoute(const EditProfileScreen());
    notifyListeners();
  }

  Future<String?> uploadToCloudinary(File mediaFile) async {
    startLoader();
    const cloudName = "dqlzgew36";
    const uploadPreset = "flutter_upload_preset"; // Create one in Cloudinary settings

    final url = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/upload");

    // Determine if the media is a video or an image
    final mimeType = mediaFile.path.endsWith(".mp4") ? "video" : "image";


    // Create the Multipart request for uploading
    var request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..fields['cloud_name'] = cloudName
      ..fields['resource_type'] = mimeType
      ..files.add(await http.MultipartFile.fromPath('file', mediaFile.path));

    // Send the request
    var response = await request.send();

    // Handle the response
    if (response.statusCode == 200) {
      final responseData = await http.Response.fromStream(response);
      final Map<String, dynamic> responseBody = jsonDecode(responseData.body);
      AppLogger.debug("Uploaded media URL: ${responseBody['secure_url']}");
      AppLogger.debug('Media uploaded to Cloudinary to analyze');
      stopLoader();
      return responseBody['secure_url'];
    } else {
      AppLogger.debug("Failed to upload media.");
      stopLoader();
      return null;
    }
  }

  void showIosBottomPopup() {
    showCupertinoModalPopup(
      context: navigationService.context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: AppText("Select Image From", isTitle: true, size: 17.sp, align: TextAlign.center, color: stateColor12(false),),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              selectImage(source: ImageSource.camera);
            },
            child: AppText("Camera", size: 15.sp, isTitle: true, color: stateColor11(false),),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              selectImage(source: ImageSource.gallery);
            },
            child: AppText("Gallery", size: 15.sp, isTitle: true, color: stateColor11(false),),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
      ),
    );
  }

}