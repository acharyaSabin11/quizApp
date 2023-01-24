import 'package:flutter/material.dart';
import 'package:quizapp/utilities/app_colors.dart';
import 'package:quizapp/utilities/dimensions.dart';
import 'package:quizapp/widgets/app_text_field.dart';
import 'package:quizapp/widgets/big_text.dart';
import 'package:quizapp/widgets/custom_text.dart';
import 'package:quizapp/widgets/icon_container.dart';

class CreateQuizPage extends StatelessWidget {
  const CreateQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  child: const IconContainer(
                    iconData: Icons.arrow_back_ios,
                    iconLeftPadding: 10,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: "Question 5",
                          fontWeight: FontWeight.w500,
                          textColor: Colors.black,
                          size: 20,
                        ),
                        SizedBox(height: Dimensions.height20),
                        const CustomText(
                          text: "Quiz Question",
                          textColor: Colors.black,
                          size: 16,
                        ),
                        SizedBox(height: Dimensions.height20),
                        AppTextField(
                          hintText: "Your Question Here",
                        ),
                        SizedBox(
                          height: Dimensions.height30,
                        ),
                        const CustomText(
                          text: "Quiz Answers",
                          textColor: Colors.black,
                          size: 16,
                        ),
                        SizedBox(height: Dimensions.height20),
                        AppTextField(
                          hintText: "Option A",
                        ),
                        SizedBox(height: Dimensions.height15),
                        AppTextField(
                          hintText: "Option B",
                        ),
                        SizedBox(height: Dimensions.height15),
                        AppTextField(
                          hintText: "Option C",
                        ),
                        SizedBox(height: Dimensions.height15),
                        AppTextField(
                          hintText: "Option D",
                        ),
                        SizedBox(
                          height: Dimensions.height30,
                        ),
                        const CustomText(
                          text: "Correct Option",
                          textColor: Colors.black,
                          size: 16,
                        ),
                        SizedBox(height: Dimensions.height20),
                        AppTextField(
                          hintText: "A or B or C or D",
                        ),
                        SizedBox(height: Dimensions.height20),
                        Container(
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
