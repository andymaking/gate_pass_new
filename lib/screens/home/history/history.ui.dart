import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gate_pass/screens/base-ui.dart';
import 'package:gate_pass/utils/widget_extensions.dart';

import '../../../gen/assets.gen.dart';
import '../../../widget/apptexts.dart';
import '../../../widget/svg_builder.dart';
import '../home/home_screen.ui.dart';
import 'history.vm.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<HistoryViewModel>(
      useFullScreenLoader: true,
      builder: (model, theme) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("History"),
            actions: [
              InkWell(
                onTap: model.goToNotification,
                child: Padding(
                  padding: 8.sp.padA,
                  child: SvgBuilder(
                    Assets.svg.notification,
                    size: 25.sp,
                  ),
                ),
              ),
              8.sp.sbW,
            ],
          ),
          body: model.myPass.isEmpty? SizedBox(
            height: 300.sp,
            width: width(context),
            child: const Center(
              child: AppText("No pass given out yet"),
            ),
          ):
            ListView.builder(
            padding: 16.sp.padH,
            itemCount: model.myPass.length,
            itemBuilder: (_, index) {
              return ContainerViewPass(pass: model.myPass[index], onTap: model.goToPassCodeScreen,);
            }
          ),
        );
      }
    );
  }
}
