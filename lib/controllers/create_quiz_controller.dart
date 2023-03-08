import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/utilities/app_colors.dart';
import 'package:quizapp/utilities/common_ui_functions.dart';
import 'package:quizapp/widgets/app_text_field.dart';
import 'package:quizapp/widgets/empty_custom_dialog.dart';

import '../utilities/dimensions.dart';
import '../widgets/big_text.dart';
import '../widgets/small_text.dart';

class CreateQuizController extends GetxController {
  var questionNumber = 1.obs;
  var questionText = ''.obs;
  var option1 = ''.obs;
  var option2 = ''.obs;
  var option3 = ''.obs;
  var option4 = ''.obs;
  var correctOption = 1.obs;
  RxString quizPassword = 's22w57C'.obs;
  RxString quizId = 's22w57Csafasf'.obs;

  void editPassword() async {
    TextEditingController passwordController = TextEditingController();
    await showDialog(
        context: (Get.context!),
        builder: (context) {
          return Center(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
              child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: Dimensions.width40 * 1.25),
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                    vertical: Dimensions.height20),
                // height: Dimensions.deviceScreenHeight / 5,
                // width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.height20),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const BigText(
                      text: "Edit Password",
                      textColor: AppColors.mainBlueColor,
                      size: 30,
                    ),
                    SizedBox(
                      height: Dimensions.height15,
                    ),
                    const SmallText(
                      text: "Enter new Password",
                      textColor: AppColors.textColor,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    AppTextField(
                      textEditingController: passwordController,
                      hintText: 'Enter new password',
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const BigText(
                            textColor: Colors.red,
                            text: "Cancel",
                            size: 20,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (passwordController.text.isNotEmpty) {
                              quizPassword.value = passwordController.text;
                              Get.back();
                            } else {
                              showErrorDialog(
                                  description: "Password cannot be empty");
                            }
                          },
                          child: const BigText(
                            text: "Save",
                            textColor: AppColors.mainBlueColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
          );
        });
  }

  void incrementQuestionNumber() {
    questionNumber.value++;
  }

  void updateQuestionText(String value) {
    questionText.value = value;
  }

  void updateOption1(String value) {
    option1.value = value;
  }

  void updateOption2(String value) {
    option2.value = value;
  }

  void updateOption3(String value) {
    option3.value = value;
  }

  void updateOption4(String value) {
    option4.value = value;
  }

  void updateCorrectOption(int value) {
    correctOption.value = value;
  }
}
