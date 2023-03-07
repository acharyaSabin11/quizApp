import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/utilities/app_colors.dart';
import 'package:quizapp/utilities/common_ui_functions.dart';
import 'package:quizapp/utilities/dimensions.dart';
import 'package:quizapp/widgets/big_text.dart';
import 'package:quizapp/widgets/custom_text.dart';
import 'package:quizapp/widgets/icon_container.dart';

import '../widgets/app_text_field.dart';
import '../widgets/effects/button_press_effect_container.dart';

class CreateQuizPage extends StatefulWidget {
  const CreateQuizPage({super.key});

  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  //text editing controllers
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _optionAController = TextEditingController();
  final TextEditingController _optionBController = TextEditingController();
  final TextEditingController _optionCController = TextEditingController();
  final TextEditingController _optionDController = TextEditingController();
  final TextEditingController _correctOptionController =
      TextEditingController();

  //defining errors for text fields
  String? questionError;
  String? optionAError;
  String? optionBError;
  String? optionCError;
  String? optionDError;
  String? correctOptionError;

  bool isFormValid() {
    bool isQuestionValid = false;
    bool isOptionAValid = false;
    bool isOptionBValid = false;
    bool isOptionCValid = false;
    bool isOptionDValid = false;
    bool areOptionsValid = false;
    bool isCorrectOptionValid = false;

    //validating question
    if (_questionController.text.isEmpty) {
      setState(() {
        questionError = "Question cannot be empty";
      });
    } else if (_questionController.text.length <= 10) {
      setState(() {
        questionError = "Question must be at least 10 characters";
      });
    } else {
      setState(() {
        questionError = null;
      });
      isQuestionValid = true;
    }

    //validating options A, B, C, D by checking if any of the option match each other or not. No options can be same.
    //validating options A, B, C, D by checking if they are empty
    if (_optionAController.text.isEmpty) {
      setState(() {
        optionAError = "Option A cannot be empty";
      });
    } else if (_optionAController.text == _optionBController.text ||
        _optionAController.text == _optionCController.text ||
        _optionAController.text == _optionDController.text) {
      setState(() {
        optionAError = "Two or more options cannot be same";
      });
    } else {
      setState(() {
        optionAError = null;
      });
      isOptionAValid = true;
    }

    if (_optionBController.text.isEmpty) {
      setState(() {
        optionBError = "Option B cannot be empty";
      });
    } else if (_optionBController.text == _optionAController.text ||
        _optionBController.text == _optionCController.text ||
        _optionBController.text == _optionDController.text) {
      setState(() {
        optionBError = "Two or more options cannot be same";
      });
    } else {
      setState(() {
        optionBError = null;
      });
      isOptionBValid = true;
    }

    if (_optionCController.text.isEmpty) {
      setState(() {
        optionCError = "Option C cannot be empty";
      });
    } else if (_optionCController.text == _optionAController.text ||
        _optionCController.text == _optionBController.text ||
        _optionCController.text == _optionDController.text) {
      setState(() {
        optionCError = "Two or more options cannot be same";
      });
    } else {
      setState(() {
        optionCError = null;
      });
      isOptionCValid = true;
    }

    if (_optionDController.text.isEmpty) {
      setState(() {
        optionDError = "Option D cannot be empty";
      });
    } else if (_optionDController.text == _optionAController.text ||
        _optionDController.text == _optionBController.text ||
        _optionDController.text == _optionCController.text) {
      setState(() {
        optionDError = "Two or more options cannot be same";
      });
    } else {
      setState(() {
        optionDError = null;
      });
      isOptionDValid = true;
    }

    areOptionsValid =
        isOptionAValid && isOptionBValid && isOptionCValid && isOptionDValid;

    //validating correct option
    if (_correctOptionController.text.isEmpty) {
      setState(() {
        correctOptionError = "Correct option cannot be empty";
      });
    } else if (_correctOptionController.text.length > 1) {
      setState(() {
        correctOptionError = "Correct option must be a single character";
      });
    } else if (_correctOptionController.text.toLowerCase() != "a" &&
        _correctOptionController.text.toLowerCase() != "b" &&
        _correctOptionController.text.toLowerCase() != "c" &&
        _correctOptionController.text.toLowerCase() != "d") {
      setState(() {
        correctOptionError = "Correct option must be A, B, C or D";
      });
    } else {
      setState(() {
        correctOptionError = null;
      });
      isCorrectOptionValid = true;
    }

    if (isQuestionValid && areOptionsValid && isCorrectOptionValid) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    int questionCount = 50;
    return Scaffold(
      backgroundColor: AppColors.backgroundWhiteColor,
      body: Stack(
        children: [
          Container(
            height:
                Dimensions.responsiveHeight(150) + Dimensions.statusBarHeight,
            width: double.maxFinite,
            decoration: const BoxDecoration(color: AppColors.mainBlueColor),
            child: Stack(
              children: [
                //Left Small Circle Design
                Positioned(
                  top: Dimensions.responsiveHeight(50) +
                      Dimensions.statusBarHeight,
                  left: Dimensions.responsiveWidth(70),
                  child: CircleAvatar(
                    backgroundColor: AppColors.lowOpacityWhiteColor,
                    radius: Dimensions.responsiveHeight(40),
                  ),
                ),
                //Right Large Circle Design
                Positioned(
                  top: Dimensions.responsiveHeight(-20),
                  right: Dimensions.responsiveWidth(-30),
                  child: CircleAvatar(
                    backgroundColor: AppColors.lowOpacityWhiteColor,
                    radius: Dimensions.responsiveHeight(90),
                  ),
                ),
                //Back button
                Positioned(
                  top: Dimensions.responsiveHeight(20) +
                      Dimensions.statusBarHeight,
                  left: Dimensions.responsiveWidth(20),
                  child: ButtonPressEffectContainer(
                    onTapFunction: () {
                      Get.back();
                    },
                    height: Dimensions.height40,
                    width: Dimensions.height40,
                    child: const IconContainer(
                      iconData: Icons.arrow_back_ios,
                      iconLeftPadding: 10,
                    ),
                  ),
                ),
                //Create Quiz Title
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: Dimensions.responsiveHeight(25) +
                            Dimensions.statusBarHeight),
                    child: const BigText(text: "Create Quiz"),
                  ),
                ),
              ],
            ),
          ),
          //Question Box
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.deviceScreenHeight -
                  Dimensions.responsiveHeight(140),
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.responsiveWidth(20), vertical: 20),
              margin: EdgeInsets.only(
                  left: Dimensions.responsiveWidth(20),
                  right: Dimensions.responsiveWidth(20),
                  bottom: Dimensions.responsiveHeight(20),
                  top: Dimensions.statusBarHeight),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: AppColors.shadowBlackColor,
                        offset: Offset(0, 5),
                        blurRadius: 5,
                        spreadRadius: 2)
                  ]),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Dimensions.height5),
                        const CustomText(
                          text: "Question 5",
                          fontWeight: FontWeight.w500,
                          textColor: Colors.black,
                          size: 20,
                        ),
                        SizedBox(height: Dimensions.height15),
                        SizedBox(
                          height: Dimensions.height5 * 0.6,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (int index = 0;
                                  index < questionCount;
                                  index++)
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: index <= 2
                                                ? AppColors.mainBlueColor
                                                : AppColors
                                                    .logoBluishWhiteColor,
                                          ),
                                        ),
                                      ),
                                      questionCount >= 50
                                          ? const Expanded(
                                              flex: 1,
                                              child: SizedBox(),
                                            )
                                          : SizedBox(
                                              width:
                                                  Dimensions.responsiveWidth(3),
                                            )
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: Dimensions.height20),
                        const BigText(
                          text: "Quiz Question",
                          textColor: Colors.black,
                          size: 16,
                        ),
                        SizedBox(height: Dimensions.height20),
                        AppTextField(
                          textEditingController: _questionController,
                          hintText: "Your Question Here",
                          errorText: questionError,
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        const BigText(
                          text: "Quiz Answers",
                          textColor: Colors.black,
                          size: 16,
                        ),
                        SizedBox(height: Dimensions.height20),
                        AppTextField(
                          textEditingController: _optionAController,
                          hintText: "Option A",
                          errorText: optionAError,
                        ),
                        SizedBox(height: Dimensions.height15),
                        AppTextField(
                          textEditingController: _optionBController,
                          hintText: "Option B",
                          errorText: optionBError,
                        ),
                        SizedBox(height: Dimensions.height15),
                        AppTextField(
                          textEditingController: _optionCController,
                          hintText: "Option C",
                          errorText: optionCError,
                        ),
                        SizedBox(height: Dimensions.height15),
                        AppTextField(
                          textEditingController: _optionDController,
                          hintText: "Option D",
                          errorText: optionDError,
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        const BigText(
                          text: "Correct Option",
                          textColor: Colors.black,
                          size: 16,
                        ),
                        SizedBox(height: Dimensions.height20),
                        AppTextField(
                          textEditingController: _correctOptionController,
                          hintText: "A or B or C or D",
                          errorText: correctOptionError,
                        ),
                        SizedBox(height: Dimensions.height20),
                        ButtonPressEffectContainer(
                          onTapFunction: () {
                            if (isFormValid()) {
                              showAppSnackbar(
                                  title: "Form Validation",
                                  description:
                                      "Your quiz meets all our criteria");
                            }
                          },
                          height: 60,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: AppColors.mainBlueColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                            child: CustomText(
                              text: "Continue",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
