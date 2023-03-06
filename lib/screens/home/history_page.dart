import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/icon_container.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        upperAppBar(),
        //Profile Box
        Positioned(
          top: Dimensions.height130,
          left: 0,
          right: 0,
          child: contentBox(),
        )
      ],
    );
  }

  Widget contentBox() {
    return Container(
      height: Dimensions.deviceScreenHeight * 0.73,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.responsiveWidth(20), vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowBlackColor,
              offset: Offset(1, 1),
              blurRadius: 2,
              spreadRadius: 2,
            ),
          ]),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return buildHistoryItem(index);
        },
      ),
    );
  }

  Widget buildHistoryItem(int index) {
    return Container(
        width: double.maxFinite,
        height: Dimensions.height50 * 2,
        margin: EdgeInsets.only(bottom: Dimensions.height10),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhiteColor,
          borderRadius: BorderRadius.circular(Dimensions.height15),
        ),
        child: Center(
          child: ListTile(
            leading: Container(
              height: Dimensions.height50,
              width: Dimensions.height50,
              decoration: BoxDecoration(
                color: AppColors.mainBlueColor,
                borderRadius: BorderRadius.circular(Dimensions.height10),
              ),
              child: Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  height: Dimensions.height30,
                  width: Dimensions.height30,
                ),
              ),
            ),
            title: const CustomText(
              text: "History Quiz",
              textColor: AppColors.mainBlueColor,
              size: 20,
              fontWeight: FontWeight.bold,
            ),
            subtitle: const CustomText(
              text: "10 Questions",
              textColor: AppColors.mainBlueColor,
              size: 20,
            ),
            trailing: CustomText(
              text: "10/10",
              textColor: AppColors.mainBlueColor,
              size: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }

  Widget upperAppBar() {
    return Container(
      height: Dimensions.responsiveHeight(150) + Dimensions.statusBarHeight,
      width: double.maxFinite,
      decoration: const BoxDecoration(color: AppColors.mainBlueColor),
      child: Stack(
        children: [
          //Left Small Circle Design
          Positioned(
            top: Dimensions.responsiveHeight(50) + Dimensions.statusBarHeight,
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
              child: const BigText(text: "History"),
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
}
