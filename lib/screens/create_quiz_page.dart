import 'package:flutter/material.dart';
import 'package:quizapp/utilities/app_colors.dart';
import 'package:quizapp/utilities/dimensions.dart';
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
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.responsiveWidth(20), vertical: 20),
              height: Dimensions.deviceScreenHeight -
                  Dimensions.responsiveHeight(140),
              width: double.maxFinite,
              margin: EdgeInsets.only(
                left: Dimensions.responsiveWidth(20),
                right: Dimensions.responsiveWidth(20),
                bottom: Dimensions.responsiveHeight(20),
              ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CustomText(
                    text: "Question 5",
                    fontWeight: FontWeight.w500,
                    textColor: Colors.black,
                    size: 20,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 5),
                        borderRadius: BorderRadius.all(
                          Radius.circular(13),
                        ),
                      ),
                      hintText: "Your Question Here",
                      fillColor: AppColors.backgroundWhiteColor,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
