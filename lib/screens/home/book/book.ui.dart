import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gate_pass/screens/base-ui.dart';
import 'package:gate_pass/screens/home/book/book.vm.dart';
import 'package:gate_pass/styles/palette.dart';
import 'package:gate_pass/utils/validator.dart';
import 'package:gate_pass/utils/widget_extensions.dart';
import 'package:gate_pass/widget/app-button.dart';
import 'package:gate_pass/widget/app-card.dart';
import 'package:gate_pass/widget/apptexts.dart';
import 'package:gate_pass/widget/svg_builder.dart';
import 'package:gate_pass/widget/text_field.dart';

import '../../../gen/assets.gen.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<BookViewModel>(
      builder: (model, theme) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Book Gate Pass"),
          ),
          body: Padding(
            padding: 16.sp.padH,
            child: Column(
              children: [
                10.sp.sbH,
                Row(
                  spacing: 16.sp,
                  children: List.generate(
                    model.passType.length,
                    (index){
                      return Expanded(
                        child: AppCard(
                          onTap: ()=> model.changeType(model.passType[index]),
                          heights: 48.sp,
                          radius: 0.sp,
                          backgroundColor: model.isSingle == model.passType[index] ?  black(isAppDark(context)) : white(isAppDark(context)),
                          child: Center(
                            child: AppText(
                              (index == 0? "Single Pass": "Multi Pass").toUpperCase(), isTitle: true, color: model.isSingle != model.passType[index] ?  black(isAppDark(context)) : white(isAppDark(context),),
                              weight: FontWeight.w500,
                              size: 16.sp,
                            )
                          ),
                        ),
                      );
                    }
                  ),
                ),
                10.sp.sbH,
                Expanded(
                  child: SingleChildScrollView(
                    padding: 6.sp.padV,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        20.sp.sbH,
                        AppText("Visitors Information!", isTitle: true,),
                        20.sp.sbH,
                        if(model.isSingle)
                          SingleUserForm(model: model)
                        else
                          MultipleUserForm(model: model)
                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
        );
      }
    );
  }
}

class SingleUserForm extends StatelessWidget {
  final BookViewModel model;
  const SingleUserForm({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: model.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            hint: "Full Name",
            onChanged: model.onChanged,
            validator: fullNameValidator,
            controller: model.visitorsInput[0].fullName,
          ),
          16.sp.sbH,
          AppTextField(
            hint: "Email Address",
            onChanged: model.onChanged,
            validator: emailValidator,
            controller: model.visitorsInput[0].email,
          ),
          16.sp.sbH,
          AppTextField(
            hint: "Phone Number",
            onChanged: model.onChanged,
            validator: emptyValidator,
            controller: model.visitorsInput[0].phoneNumber,
          ),
          16.sp.sbH,
          const AppText("Duration"),
          16.sp.sbH,
          SizedBox(
            width: width(context),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16.sp,
              children: [
                Expanded(
                  child: AppTextField(
                    hint: "From",
                    readonly: true,
                    onTap: model.pickStartDateTime,
                    validator: emptyValidator,
                    controller: model.startDateController,
                  ),
                ),
                Expanded(
                  child: AppTextField(
                    hint: "To",
                    readonly: true,
                    onTap: model.pickEndDateTime,
                    validator: emptyValidator,
                    controller: model.endDateController,
                  ),
                ),
            
              ],
            ),
          ),
          16.sp.sbH,
          TextArea(
            hint: "Purpose of visit?",
            onChanged: model.onChanged,
            validator: emptyValidator,
            controller: model.purposeController,
            maxLines: 5,
            autofocus: false,
          ),
          25.sp.sbH,
          AppButton.fullWidth(
            isLoading: model.isLoading,
            text: "Book Pass".toUpperCase(),
            onTap: model.formKey.currentState?.validate() == true ? model.submit: null,
          ),
          25.sp.sbH,
        ],
      ),
    );
  }
}

class MultipleUserForm extends StatelessWidget {
  final BookViewModel model;
  const MultipleUserForm({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: model.formKey2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextArea(
            hint: "Purpose of visit?",
            onChanged: model.onChanged2,
            validator: emptyValidator,
            controller: model.purposeController,
            maxLines: 5,
            autofocus: false,
          ),
          16.sp.sbH,
          const AppText("Duration"),
          16.sp.sbH,
          SizedBox(
            width: width(context),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16.sp,
              children: [
                Expanded(
                  child: AppTextField(
                    hint: "From",
                    readonly: true,
                    onTap: model.pickStartDateTime,
                    validator: emptyValidator,
                    controller: model.startDateController,
                  ),
                ),
                Expanded(
                  child: AppTextField(
                    hint: "To",
                    readonly: true,
                    onTap: model.pickEndDateTime,
                    validator: emptyValidator,
                    controller: model.endDateController,
                  ),
                ),

              ],
            ),
          ),
          16.sp.sbH,
          AppText(
            "Visitors (${model.visitorsInput.length == 1? (model.visitorsInput[0].fullName.text.trim().isEmpty? 0: 1): model.visitorsInput.length})",
            size: 20.sp,
          ),
          Column(
            children: List.generate(
              model.visitorsInput.length,
              (index) {
                return  Row(
                  spacing: 10.sp,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          8.sp.sbH,
                          AppTextField(
                            hint: "Full Name of visitor ${index+1}",
                            onChanged: model.onChanged2,
                            validator: fullNameValidator,
                            controller: model.visitorsInput[index].fullName,
                          ),
                          16.sp.sbH,
                          AppTextField(
                            hint: "Email Address of visitor ${index+1}",
                            onChanged: model.onChanged2,
                            validator: emailValidator,
                            controller: model.visitorsInput[index].email,
                          ),
                          16.sp.sbH,
                          AppTextField(
                            hint: "Phone Number of visitor ${index+1}",
                            onChanged: model.onChanged2,
                            validator: emptyValidator,
                            controller: model.visitorsInput[index].phoneNumber,
                          ),
                          16.sp.sbH,
                        ],
                      ),
                    ),
                    if(index!=0)
                    InkWell(
                      onTap: ()=> model.removeVisitor(index),
                      child: Container(
                        margin: 8.sp.padV,
                        height: 30.sp,
                        width: 30.sp,
                        color: Colors.red,
                        child: Center(
                          child: Icon(Icons.close, color: Colors.white,),
                        ),
                      ),
                    )
                  ],
                );
              }
            ),
          ),
          AppButton.outline(
            borderColor: black(false).withValues(alpha: 0.3),
            textColor: black(isAppDark(context)).withValues(alpha: 0.7),
            onTap: model.addVisitor,
            text: "Add Visitor",
            isLoading: false,
          ),
          16.sp.sbH,
          AppButton.fullWidth(
            isLoading: model.isLoading,
            text: "Book Pass".toUpperCase(),
            onTap: model.formKey2.currentState?.validate() == true ? model.submit: null,
          ),
          25.sp.sbH,

        ],
      ),
    );
  }
}
