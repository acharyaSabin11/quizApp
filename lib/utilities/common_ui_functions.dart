import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/empty_custom_dialog.dart';
import 'app_colors.dart';

void showProgressIndicatorDialog() {
  showDialog(
    context: Get.context!,
    builder: (context) => const EmptyCustomDialog(
      child: CircularProgressIndicator(
        color: AppColors.mainBlueColor,
      ),
    ),
  );
}
