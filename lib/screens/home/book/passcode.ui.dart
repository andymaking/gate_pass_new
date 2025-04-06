import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gate_pass/data/cache/constants.dart';
import 'package:gate_pass/screens/home/bottom_nav/bottom_nav.ui.dart';
import 'package:gate_pass/styles/palette.dart';
import 'package:gate_pass/utils/utils.dart';
import 'package:gate_pass/utils/widget_extensions.dart';
import 'package:gate_pass/widget/app-button.dart';
import 'package:gate_pass/widget/app-card.dart';
import 'package:gate_pass/widget/apptexts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/model/vistor_pass_model.dart';

class PassCodeScreen extends StatelessWidget {
  final VisitorPass pass;
  final LatLng location;
  const PassCodeScreen({super.key, required this.pass, required this.location});

  @override
  Widget build(BuildContext context) {

    String joinWithDash(List<String> items) {
      return items.join('\n');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Passcode"),
      ),
      body: ListView(
        padding: 16.sp.padA,
        children: [
          Container(
            height: 200.sp,
            padding: 0.sp.padA,
            width: width(context),
            child: GoogleMap(
              // style: ImageUrl.mapSetting,
              mapType: MapType.normal,
              // onTap: ,
              initialCameraPosition: CameraPosition(
                target: location,
                zoom: 14,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('currentLocation'),
                  position: location,
                ),
              },
            ),
          ),
          AppCard(
            backgroundColor: const Color(0xFF9F9F9F),
            padding: 0.0.padA,
            radius: 0.sp,
            child: Column(
              children: [
                ContainerView(
                  title: "To", 
                  value: Utils.formatDateTime(pass.endTime),
                  view: Padding(
                    padding: 16.sp.padR,
                    child: Column(
                      spacing: 5.sp,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText("Status", color: const Color(0xFF2B2C30), size: 16.sp,),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 4.sp, horizontal: 16.sp
                          ),
                          color: black(isAppDark(context)),
                          child: AppText(
                            Utils.getPassStatus(pass.startTime, pass.endTime),
                            color: white(isAppDark(context)),
                            size: 10.sp,
                          )
                        ),
                      ],
                    ),
                  ),
                ),
                ContainerView(
                  title: "Visitors Name",
                  value: joinWithDash(pass.visitors.map((t)=> t.fullName).toList())
                ),
                ContainerView(
                    title: "Address",
                    value: pass.address??""
                ),
                ContainerView(
                    title: "Purpose of visit",
                    value: pass.purpose??""
                ),
                ContainerView(
                  title: "Code",
                  value: (pass.passKey??"").toUpperCase(),
                  size: 28.sp,
                ),
              ],
            ),
          ),
          8.sp.sbH,
          AppButton.fullWidth(
            isLoading: false,
            text: "Share",
            backgroundColor: white(isAppDark(context)),
            textColor: black(isAppDark(context)),
            onTap: (){},
          ),
          8.sp.sbH,
          if(!navigationService.canPop())
          AppButton.fullWidth(
            isLoading: false,
            text: "Go Home",
            onTap: ()=> navigationService.navigateToAndRemoveUntilWidget(const BottomNavigationScreen(initialIndex: 0,)),
          ),
          50.sp.sbH,

        ],
      ),
    );
  }
}

class ContainerView extends StatelessWidget {
  final double? size;
  final Widget? view;
  final String title;
  final String value;
  const ContainerView({super.key, required this.title, required this.value, this.size, this.view});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 16.sp.padA,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: stateColor10(isAppDark(context)), width: 1.sp)
        )
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 5.sp,
              children: [
                AppText(title, color: const Color(0xFF2B2C30), size: 16.sp,),
                AppText(value, color: black(isAppDark(context)), size: size?? 18.sp, weight: FontWeight.w700,),
              ],
            ),
          ),
          if(view != null)...[
            view!
          ]
        ],
      ),
    );
  }
}
