import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/controllers/auth_controller.dart';
import 'package:quizapp/models/user_model.dart';
import 'package:quizapp/utilities/app_colors.dart';
import 'package:quizapp/utilities/dimensions.dart';

import '../../widgets/big_text.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/icon_container.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final userID = FirebaseAuth.instance.currentUser!.uid;
  UserModel? userModel;

  int currentIndex = 0;
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
    return Scaffold(
      body: Column(
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
      ),
      bottomNavigationBar: _customBottomNavigationBar(),
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
      width: Dimensions.deviceScreenWidth * 0.4,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(Dimensions.height15),
      ),
      margin: EdgeInsets.only(
        left: Dimensions.width20,
        right: listViewItemCount == index + 1 ? Dimensions.width20 : 0,
      ),
    );
  }

  Widget _customBottomNavigationBar() {
    return SizedBox(
      height: Dimensions.height20 + Dimensions.height35 * 2.5,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(
                  bottom: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              height: Dimensions.height60,
              decoration: BoxDecoration(
                color: AppColors.mainBlueColor,
                borderRadius: BorderRadius.circular(Dimensions.height15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentIndex = 0;
                      });
                    },
                    icon: Icon(
                      Icons.home,
                      color: currentIndex == 0
                          ? Colors.white
                          : Colors.white.withOpacity(0.7),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentIndex = 1;
                      });
                    },
                    icon: Icon(
                      Icons.search,
                      color: currentIndex == 1
                          ? Colors.white
                          : Colors.white.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width30 * 2,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentIndex = 2;
                      });
                    },
                    icon: Icon(
                      Icons.bookmark,
                      color: currentIndex == 2
                          ? Colors.white
                          : Colors.white.withOpacity(0.7),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentIndex = 3;
                      });
                    },
                    icon: Icon(
                      Icons.person,
                      color: currentIndex == 3
                          ? Colors.white
                          : Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: Dimensions.height20 + Dimensions.height35 / 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: Dimensions.height35 * 2,
                  width: Dimensions.height35 * 2,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundWhiteColor,
                    borderRadius: BorderRadius.circular(
                      Dimensions.height35,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.all(Dimensions.height5),
                      decoration: BoxDecoration(
                        color: AppColors.mainBlueColor,
                        borderRadius: BorderRadius.circular(
                          Dimensions.height35,
                        ),
                      ),
                      child: Center(
                          child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: Dimensions.height35,
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
