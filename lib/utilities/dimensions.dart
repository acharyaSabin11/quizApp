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
}
