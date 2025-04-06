import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gate_pass/styles/palette.dart';
import 'package:gate_pass/utils/widget_extensions.dart';
import 'package:provider/provider.dart';

import '../../../data/cache/constants.dart';
import '../../../utils/validator.dart';
import '../../../widget/app-button.dart';
import '../../../widget/apptexts.dart';
import '../../../widget/text_field.dart';
import '../../base-ui.dart';
import '../signup/signup_screen.dart';
import 'login_vm.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      builder: (model, theme)=> Scaffold(
        appBar: AppBar(),
        body:SingleChildScrollView(
          child: Form(
            key: model.formKey,
            child: Padding(
              padding: 16.sp.padH,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText("Welcome back!", isTitle: true,),
                  8.sp.sbH,
                  AppText("Login to your account now.", isLabel: true,),
                  30.sp.sbH,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppTextField(
                        controller: model.emailController,
                        keyboardType: TextInputType.emailAddress,
                        hint: "Email",
                        validator: emailValidator,
                        onChanged: model.onChanged,
                      ),
                      16.sp.sbH,
                      AppTextField(
                        controller: model.passwordController,
                        isPassword: true,
                        onChanged: model.onChanged,
                        hint: 'Password',
                        validator: passwordValidator,
                      ),
                      24.sp.sbH,
                      AppButton.fullWidth(
                        isLoading: model.isLoading,
                        text: "Sign In",
                        onTap: model.formKey.currentState?.validate() == true? model.signIn : null,
                      ),
                      20.sp.sbH,
                      AppText(
                        "Forgot Password?",
                        weight: FontWeight.w500,
                      ),
                      20.sp.sbH,
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Don’t have an account?",
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontSize: 14.sp
                              ),
                            ),

                            TextSpan(
                                text: " Sign Up",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 14.sp,
                                    color: white(isAppDark(context)),
                                    fontWeight: FontWeight.w500
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = ()=> navigationService.navigateToAndRemoveUntilWidget(const SignupScreen())
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      50.sp.sbH,
                      AppText(
                        "By continuing with the service above, you agree to\nPasskey ‘s Terms of services and privacy policy",
                        isLabel: true,
                        size: 10.sp,
                        align: TextAlign.center,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}