import 'package:feeling_meter/common_widget/base_screen_widget.dart';
import 'package:feeling_meter/const/color_const.dart';
import 'package:feeling_meter/const/img_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SplashScreen extends BasePageScreen {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () => navigateToHomePage());
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: AppColors.white,
      child: Material(
        color: AppColors.white,
        child: InkWell(
          onTap: () => navigateToHomePage(),
          child: Image.asset(UIImage.SPLASH_ICON),
        ),
      ),
    );
  }

  void navigateToHomePage() {
    Get.toNamed("/home_page");
  }
}
