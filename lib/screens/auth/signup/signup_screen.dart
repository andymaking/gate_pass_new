import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gate_pass/utils/widget_extensions.dart';
import 'package:gate_pass/widget/apptexts.dart';
import 'package:provider/provider.dart';

import '../../../data/cache/constants.dart';
import '../../../styles/palette.dart';
import '../../../utils/validator.dart';
import '../../../widget/app-button.dart';
import '../../../widget/text_field.dart';
import '../../base-ui.dart';
import '../login/login_screen.dart';
import 'signup_vm.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpViewModel>(
      builder: (model, theme)=> Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Form(
            key: model.formKey,
            child: Padding(
              padding: 16.sp.padH,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText("Sign Up", isTitle: true,),
                  8.sp.sbH,
                  const AppText("Register your account now! ", isLabel: true,),
                  30.sp.sbH,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppTextField(
                        controller: model.firstNameController,
                        hint: "Enter first name",
                        validator: emptyValidator,
                        onChanged: model.onChanged,
                      ),
                      16.sp.sbH,
                      AppTextField(
                        controller: model.lastNameController,
                        hint: "Enter last name",
                        validator: emptyValidator,
                        onChanged: model.onChanged,
                      ),
                      16.sp.sbH,
                      AppTextField(
                        controller: model.emailController,
                        keyboardType: TextInputType.emailAddress,
                        hint: "Enter email address",
                        validator: emailValidator,
                        onChanged: model.onChanged,
                      ),
                      16.sp.sbH,
                      AppTextField(
                        controller: model.phoneController,
                        keyboardType: TextInputType.emailAddress,
                        hint: "Enter phone number",
                        validator: emptyValidator,
                        onChanged: model.onChanged,
                      ),
                      16.sp.sbH,
                      AppTextField(
                        controller: model.addressController,
                        keyboardType: TextInputType.emailAddress,
                        hint: "Enter resident address",
                        validator: emptyValidator,
                        onChanged: model.onChanged,
                      ),
                      16.sp.sbH,
                      AppTextField(
                        controller: model.passwordController,
                        onChanged: model.onChanged,
                        isPassword: true,
                        hint: "Password",
                        validator: passwordValidator,
                      ),
                      if (model.errorMessage != null)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.sp),
                          child: Text(
                            model.errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      24.sp.sbH,
                      AppButton.fullWidth(
                        isLoading: model.isLoading,
                        text: "Sign Up",
                        onTap: model.formKey.currentState?.validate() == true? model.signUp : null,
                      ),
                      20.sp.sbH,
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Already have an account?",
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontSize: 14.sp
                              ),
                            ),

                            TextSpan(
                                text: " Login",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 14.sp,
                                    color: white(isAppDark(context)),
                                    fontWeight: FontWeight.w500
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = ()=> navigationService.navigateToAndRemoveUntilWidget(const LoginScreen())
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      30.sp.sbH,
                      AppText(
                        "By continuing with the service above, you agree to\nPasskey ‘s Terms of services and privacy policy",
                        isLabel: true,
                        size: 10.sp,
                        align: TextAlign.center,
                      )
                      // AppButton.transparent(
                      //   onTap: () {
                      //     navigationService.navigateToAndRemoveUntilWidget(const LoginScreen());
                      //   },
                      //   text: 'Already have an account? Sign In',
                      //   textColor: primaryColor,
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}