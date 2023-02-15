import 'package:flutter/material.dart';
import 'package:quizapp/widgets/exit_enabled_widget.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/dimensions.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';
import '../../widgets/custom_text.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ExitEnabledWidget(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: Dimensions.deviceScreenHeight * 0.35,
              child: Stack(
                children: [
                  Positioned(
                    top: Dimensions.height20 * 2,
                    left: Dimensions.width30 * 2,
                    right: Dimensions.width30 * 2,
                    child: Container(
                      height: Dimensions.responsiveHeight(200) +
                          Dimensions.statusBarHeight,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: AppColors.lightestBlueColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            Dimensions.width20,
                          ),
                          bottomRight: Radius.circular(
                            Dimensions.width20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: Container(
                      height: Dimensions.responsiveHeight(200) +
                          Dimensions.statusBarHeight,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: AppColors.lightBlueColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            Dimensions.width20,
                          ),
                          bottomRight: Radius.circular(
                            Dimensions.width20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: Dimensions.responsiveHeight(200) +
                        Dimensions.statusBarHeight,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: AppColors.mainBlueColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                          Dimensions.width20,
                        ),
                        bottomRight: Radius.circular(
                          Dimensions.width20,
                        ),
                      ),
                    ),
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
                ],
              ),
            ),
            //Question Box
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.responsiveWidth(20), vertical: 20),
              decoration:
                  const BoxDecoration(color: Colors.white, boxShadow: []),
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
                        text: "Sign Up",
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
