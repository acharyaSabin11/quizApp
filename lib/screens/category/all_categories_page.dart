import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utilities/app_colors.dart';
import '../../utilities/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/effects/button_press_effect_container.dart';
import '../../widgets/icon_container.dart';

class AllCategoriesPage extends StatefulWidget {
  AllCategoriesPage({super.key});

  @override
  State<AllCategoriesPage> createState() => _AllCategoriesPageState();
}

class _AllCategoriesPageState extends State<AllCategoriesPage> {
  List<String> gridImageList = [
    "assets/images/science.png",
    "assets/images/geography.png",
    "assets/images/sports.png",
    "assets/images/biology.png",
  ];

  List<String> gridTitleList = [
    "Science",
    "Geography",
    "Sports",
    "Biology",
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                      child: const BigText(text: "Choose Categories"),
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
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(bottom: Dimensions.height10),
                  itemCount: 25,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: Dimensions.height20,
                      mainAxisSpacing: Dimensions.height20,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) =>
                      _buildGridViewContainer(index),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGridViewContainer(int index) {
    index = index % 4;
    return ButtonPressEffectContainer(
      onTapFunction: () {
        print(index);
      },
      height:
          0, //the size is controlled automatically by the gridview and is not needed to be set manually as height and width. But it is set to 0 because height and width are required parameters of buttonPressEffectContainer widget.
      width: 0,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                height: Dimensions.deviceScreenWidth * 0.3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.height10 / 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: const Offset(2, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    CustomText(
                      text: gridTitleList[index],
                      size: 20,
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.gridTextColors[index],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: Dimensions.deviceScreenWidth * 0.3 / 1.3,
              width: Dimensions.deviceScreenWidth * 0.3 / 1.3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(gridImageList[index]),
                fit: BoxFit.cover,
              )),
            ),
          )
        ],
      ),
    );
  }
}
