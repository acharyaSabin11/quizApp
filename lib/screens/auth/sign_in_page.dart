import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/routes/route_helper.dart';
import 'package:quizapp/widgets/effects/button_press_effect_container.dart';
import 'package:quizapp/widgets/exit_enabled_widget.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/dimensions.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';
import '../../widgets/custom_text.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ExitEnabledWidget(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: Dimensions.height120 * 2.5,
              ),
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.responsiveWidth(20),
              ),
              decoration:
                  const BoxDecoration(color: Colors.white, boxShadow: []),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      fontWeight: FontWeight.w500,
                      text: "Email",
                      textColor: Colors.black,
                      size: 16,
                    ),
                    SizedBox(height: Dimensions.height10),
                    AppTextField(
                      prefixIcon: Icons.email_outlined,
                      hintText: "ABCXYZ@gmail.com",
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    const CustomText(
                      fontWeight: FontWeight.w500,
                      text: "Password",
                      textColor: Colors.black,
                      size: 16,
                    ),
                    SizedBox(height: Dimensions.height10),
                    AppTextField(
                      prefixIcon: Icons.lock_outline,
                      hintText: "Password",
                    ),
                    SizedBox(height: Dimensions.height50),
                    ButtonPressEffectContainer(
                      decoration: BoxDecoration(
                        color: AppColors.mainBlueColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: Dimensions.height60,
                      width: double.maxFinite,
                      onTapFunction: () {},
                      child: const Center(
                        child: CustomText(
                          text: "Sign In",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.deviceScreenHeight * 0.34,
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
                        //top left Small Circle Design
                        Positioned(
                          top: -Dimensions.height50,
                          left: -Dimensions.width15,
                          child: CircleAvatar(
                            backgroundColor: AppColors.lowOpacityWhiteColor,
                            radius: Dimensions.responsiveHeight(50),
                            child: CircleAvatar(
                              backgroundColor: AppColors.mainBlueColor,
                              radius: Dimensions.responsiveHeight(25),
                            ),
                          ),
                        ),
                        //Right  Circle Design
                        Positioned(
                          top: Dimensions.height30,
                          right: -Dimensions.width40 * 3.5,
                          child: CircleAvatar(
                            backgroundColor: AppColors.lowOpacityWhiteColor,
                            radius: Dimensions.responsiveHeight(90),
                            child: CircleAvatar(
                              backgroundColor: AppColors.mainBlueColor,
                              radius: Dimensions.responsiveHeight(65),
                            ),
                          ),
                        ),
                        //Create Quiz Title
                        Padding(
                          padding: EdgeInsets.only(
                            top: Dimensions.statusBarHeight +
                                Dimensions.height10,
                            left: Dimensions.width30,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: const TextSpan(
                                  text: "Quiz",
                                  style: TextStyle(
                                    color: AppColors.logoBlueColor,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "app",
                                      style: TextStyle(
                                        color: AppColors.logoBluishWhiteColor,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: Dimensions.height20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const BigText(
                                      text: "Sign In",
                                      textColor: Colors.white,
                                      size: 30,
                                    ),
                                    SizedBox(height: Dimensions.height15),
                                    Row(
                                      children: [
                                        const CustomText(
                                          text: "Don't have an account?",
                                          textColor: Colors.white,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 5),
                                        GestureDetector(
                                          onTap: () {
                                            Get.offNamed(
                                                RouteHelper.getSignUpPage());
                                          },
                                          child: const CustomText(
                                            text: "Sign Up",
                                            textColor: AppColors.logoBlueColor,
                                            size: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //Form Box
          ],
        ),
      ),
    );
  }
}
