import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/big_text.dart';
import '../widgets/custom_dialog.dart';
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

void showErrorDialog({
  required String description,
}) {
  Navigator.of(Get.context!).pop();
  showDialog(
    context: Get.context!,
    builder: (context) {
      return CustomDialog(
        iconData: Icons.error,
        iconColor: Colors.red,
        title: "Error",
        titleColor: Colors.red,
        descriptionText: description,
        actionWidgets: [
          TextButton(
            onPressed: () {
              Navigator.of(Get.context!).pop();
            },
            child: const BigText(
              text: "OK",
              textColor: AppColors.mainBlueColor,
              size: 18,
            ),
          ),
        ],
      );
    },
  );
}

void showAppSnackbar({required String title, required String description}) {
  Get.snackbar(
    title,
    description,
    colorText: AppColors.mainBlueColor,
    backgroundColor: Colors.white,
    duration: const Duration(seconds: 2),
  );
}
