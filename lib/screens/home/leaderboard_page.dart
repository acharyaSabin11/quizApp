import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/controllers/profile_image_controller.dart';
import 'package:quizapp/utilities/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/auth_controller.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/icon_container.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        upperAppBar(),
        SizedBox(height: Dimensions.height10),
        SizedBox(
          height: Dimensions.deviceScreenHeight * 0.43,
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (int index = 0; index < 10; index++)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width15,
                      vertical: Dimensions.height10,
                    ),
                    margin: EdgeInsets.only(
                      left: Dimensions.width30,
                      right: Dimensions.width30,
                      bottom: Dimensions.height10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 2,
                          offset: const Offset(1, 1),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(Dimensions.height10),
                    ),
                    child: Center(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: Dimensions.height20,
                          // backgroundImage: const NetworkImage(
                          //   "https://th.bing.com/th/id/R.95e45a66c918a53280e796b44add2d66?rik=oVKQ59XBdewj8Q&pid=ImgRaw&r=0",
                          // ),
                        ),
                        title: const BigText(
                          text: "John Doe",
                          textColor: AppColors.titleTextColor,
                          size: 20,
                        ),
                        trailing: const BigText(
                          text: "1520",
                          textColor: AppColors.brightCyanColor,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        )
        //Profile Box
      ],
    );
  }

  Widget upperAppBar() {
    return Container(
      height: Dimensions.deviceScreenHeight * 0.47,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.mainBlueColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(Dimensions.height30),
          bottomRight: Radius.circular(Dimensions.height30),
        ),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            "assets/images/glow.png",
          ),
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  top: Dimensions.responsiveHeight(25) +
                      Dimensions.statusBarHeight),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const BigText(text: "Leaderboard"),
                  SizedBox(height: Dimensions.height30),
                  Container(
                    height: Dimensions.height50,
                    width: Dimensions.deviceScreenWidth * 0.8,
                    decoration: BoxDecoration(
                      color: AppColors.leaderBoardBlueColor,
                      borderRadius: BorderRadius.circular(Dimensions.height10),
                    ),
                    child: Row(
                      children: [
                        for (int index = 0; index < 3; index++)
                          Container(
                            margin: EdgeInsets.only(
                                bottom: Dimensions.height5 * 0.75),
                            decoration: BoxDecoration(
                              color: index == 1
                                  ? AppColors.leaderBoardCyanColor
                                  : AppColors.leaderBoardBlueColor,
                              borderRadius: BorderRadius.circular(
                                Dimensions.height10,
                              ),
                            ),
                            width: Dimensions.deviceScreenWidth * 0.8 / 3,
                            child: const Center(
                              child: CustomText(
                                text: "Local",
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.height20),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.width30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Dimensions.deviceScreenWidth * 0.25,
                            child: winnerBox("second", ""),
                          ),
                          SizedBox(
                            width: Dimensions.deviceScreenWidth * 0.35,
                            child: winnerBox("first", ""),
                          ),
                          SizedBox(
                            width: Dimensions.deviceScreenWidth * 0.25,
                            child: winnerBox("third", ""),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.height20),
                ],
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(
              top: Dimensions.statusBarHeight + Dimensions.height10,
              right: Dimensions.width30,
              left: Dimensions.width30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.find<AuthController>().signOut();
                  },
                  child: const IconContainer(
                    iconData: Icons.widgets_rounded,
                  ),
                ),
                const IconContainer(
                  iconData: Icons.notifications,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget winnerBox(String position, String url) {
    return LayoutBuilder(builder: (context, expandedConstraints) {
      return Container(
        alignment: Alignment.bottomCenter,
        child: Stack(
          children: [
            Image.asset(
              "assets/images/${position}.png",
              fit: BoxFit.contain,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: expandedConstraints.maxWidth * 0.025,
                left: expandedConstraints.maxWidth * 0.05,
              ),
              child: CircleAvatar(
                // minRadius: constraints.maxHeight * 0.20,
                backgroundImage: Get.find<SharedPreferences>()
                        .containsKey(AppConstants.profileImagePresentKey)
                    ? FileImage(
                        File(Get.find<ProfileImageController>()
                            .profileImageUrl
                            .value),
                      )
                    : null,
                radius: expandedConstraints.maxWidth * 0.45,
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      );
    });
  }
}
