import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Dimensions {
  static double statusBarHeight = MediaQuery.of(Get.context!).viewPadding.top;

  static double deviceScreenHeight = Get.height.toDouble();
  static double deviceScreenWidth = Get.width.toDouble();

  static double developmentDeviceHeight = 856.7272727272727;
  static double developmentDeviceWidth = 392.72727272727275;

  static double responsiveHeight(double height) {
    return (height / developmentDeviceHeight) * deviceScreenHeight;
  }

  static double responsiveWidth(double width) {
    return (width / developmentDeviceWidth) * deviceScreenWidth;
  }

  static double height20 = responsiveHeight(20);
  static double height30 = responsiveHeight(30);
  static double height15 = responsiveHeight(15);
  static double height50 = responsiveHeight(50);
  static double height60 = responsiveHeight(60);
  static double height130 = responsiveHeight(130);
  static double height120 = responsiveHeight(120);

  static double width40 = responsiveWidth(40);
  static double width20 = responsiveWidth(20);
}