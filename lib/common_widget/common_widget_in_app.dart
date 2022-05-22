import 'package:feeling_meter/const/color_const.dart';
import 'package:feeling_meter/const/img_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WF {
  //Common Widget Function
  static AppBar getThemeAppBar({
    String title = '',
    bool showBackButton = true,
    bool showCrossButton = false,
    Widget backWidget = const SizedBox.shrink(),
    brightness,
    AlignmentGeometry textAlignment = AlignmentDirectional.center,
  }) {
    return AppBar(
      backgroundColor: AppColors.white,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      //  bottom: bottom,
      toolbarHeight: kToolbarHeight,

      systemOverlayStyle: SystemUiOverlayStyle.dark,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          backWidget,
          showBackButton
              ? InkWell(
                  onTap: () => Get.back(),
                  child: Image.asset(UIImage.BACK_ICON),
                )
              : const SizedBox.shrink(),
          Expanded(
            child: Align(
              alignment: textAlignment,
              child: Text(
                'Your Feelings History',
                style: TextStyle(
                  fontFamily: 'SF Pro Rounded',
                  height: 1.15,
                  fontSize: 20,
                  color: AppColors.black,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
