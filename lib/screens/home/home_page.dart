import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../models/user_model.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/effects/button_press_effect_container.dart';
import '../../widgets/icon_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userID = FirebaseAuth.instance.currentUser!.uid;
  UserModel? userModel;
  int listViewItemCount = 3;

  //override init method
  @override
  void initState() {
    super.initState();
    //fetching the user data from the firestore
    FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .get()
        .then((value) {
      //setting the user data to the auth controller
      setState(() {
        userModel = UserModel.fromJson(value.data()!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _upperContainer(),
        SizedBox(
          height: Dimensions.height20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              BigText(
                text: "Choose Categories",
                textColor: AppColors.titleTextColor,
                size: 20,
              ),
              CustomText(
                text: "See All",
                textColor: Color(0xFF2ad3f9),
                size: 16,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        Center(
          child: SizedBox(
            width: Dimensions.deviceScreenWidth * 0.78,
            height: Dimensions.deviceScreenHeight * 0.35,
            child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: Dimensions.width30,
                    mainAxisSpacing: Dimensions.height15,
                    crossAxisCount: 2),
                itemBuilder: (context, index) => Container(
                      height: 100,
                      width: 100,
                      color: Colors.amber,
                    )),
          ),
        )
      ],
    );
  }

  Widget _upperContainer() {
    return Stack(
      children: [
        Container(
          height:
              Dimensions.deviceScreenHeight * 0.30 + Dimensions.statusBarHeight,
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: AppColors.mainBlueColor,
              borderRadius: BorderRadius.circular(Dimensions.height35)),
        ),
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
        //Back button
        Column(
          children: [
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(
                top: Dimensions.statusBarHeight + Dimensions.height10,
                right: Dimensions.width30,
                left: Dimensions.width30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  const CustomText(
                    text: "Welcome Back!",
                    size: 23,
                    fontWeight: FontWeight.w300,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  BigText(
                    text: userModel?.name ?? "user...",
                    size: 30,
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.height20),
            SizedBox(
              height: Dimensions.height120 * 1.5,
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: listViewItemCount,
                itemBuilder: (context, index) => _buildListViewContainer(index),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildListViewContainer(int index) {
    return Container(
      width: Dimensions.deviceScreenHeight * 0.19,
      decoration: BoxDecoration(
        gradient: AppColors.homePageGradients[(index % 3)],
        borderRadius: BorderRadius.circular(Dimensions.height15),
        image: DecorationImage(
            image: AssetImage("assets/images/effect.png"), fit: BoxFit.fill),
      ),
      margin: EdgeInsets.only(
        left: Dimensions.width20,
        right: listViewItemCount == index + 1 ? Dimensions.width20 : 0,
      ),
      child: Padding(
        padding: EdgeInsets.all(Dimensions.width15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dimensions.height10,
                ),
                CustomText(
                  text: "Create",
                  textColor: Colors.white,
                  size: 25,
                ),
                SizedBox(
                  height: Dimensions.height10 / 2,
                ),
                BigText(
                  text: "Quiz",
                  textColor: Colors.white,
                  size: 35,
                ),
              ],
            ),
            ButtonPressEffectContainer(
              onTapFunction: () {
                print(index);
              },
              margin: EdgeInsets.only(top: Dimensions.height10),
              height: Dimensions.height40,
              width: Dimensions.height60,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/arrowBoxWithOpacity.png"),
                    fit: BoxFit.fill),
              ),
              child: SizedBox(height: 0),
            )
          ],
        ),
      ),
    );
  }
}
