import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quizapp/utilities/app_colors.dart';
import 'package:quizapp/utilities/dimensions.dart';
import 'package:quizapp/widgets/big_text.dart';
import 'package:quizapp/widgets/icon_container.dart';
import 'package:quizapp/widgets/small_text.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhiteColor,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: Dimensions.statusBarHeight),
            height: Dimensions.deviceScreenHeight / 2,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: AppColors.mainBlueColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Dimensions.height50),
                bottomRight: Radius.circular(Dimensions.height50),
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: Dimensions.height30),
                    child: CircleAvatar(
                      radius: Dimensions.responsiveHeight(Dimensions.height130),
                      backgroundColor: AppColors.mediumOpacityWhiteColor,
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    "assets/images/book1.png",
                    height: Dimensions.height130 * 2.1,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.height50),
          const BigText(
            text: "Create your own game",
            textColor: AppColors.titleTextColor,
            size: 27,
          ),
          SizedBox(height: Dimensions.height20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width40),
            child: const SmallText(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut arcu orci, fermentum et nisi nec, facilisis molestie tortor. Vivamus eu augue ac elit ullamcorper efficitur placerat a dolor.",
              textColor: AppColors.textColor,
            ),
          ),
          SizedBox(height: Dimensions.height50),
          Wrap(
            children: List.generate(
              3,
              (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                height: 7,
                width: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: index == 0
                      ? AppColors.mainBlueColor
                      : AppColors.fadedBlueColor,
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          bottom: Dimensions.height30,
          left: Dimensions.width20,
          right: Dimensions.width20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SmallText(
              text: "Skip",
              textColor: AppColors.textColor,
              size: 18,
            ),
            IconContainer(
              iconData: Icons.arrow_forward_ios,
              containerSize: 50,
            ),
          ],
        ),
      ),
    );
  }
}
