import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gate_pass/styles/palette.dart';
import 'package:gate_pass/utils/widget_extensions.dart';

import '../../../widget/apptexts.dart';
import '../../base-ui.dart';
import 'notificaton.vm.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<NotificationViewModel>(
      builder: (model, theme) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Notifications"),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: model.grouped.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(entry.key, style: TextStyle(color: Colors.white70, fontSize: 16.sp, fontWeight: FontWeight.w500)),
                  20.sp.sbH,
                  ...entry.value.map((notification) {
                    return Container(
                      padding: 16.sp.padB,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: stateColor12(false), width: 1)
                        )
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        spacing: 16.sp,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.circle, size: 8, color: notification.isUrgent ? Colors.black : Colors.white),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    AppText(
                                      notification.topic,
                                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                                    ),
                                    const Spacer(),
                                    AppText(
                                      model.formatTimeAgo(notification.createdAt),
                                      size: 15.sp,
                                      isLabel: true,
                                    ),
                                  ],
                                ),
                                6.sp.sbH,
                                AppText(
                                  notification.message,
                                  isLabel: true,
                                  size: 13.sp,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              );
            }).toList(),
          ),
        );
      }
    );
  }
}
