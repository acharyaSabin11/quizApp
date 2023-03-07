import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/controllers/user_controller.dart';
import 'package:quizapp/routes/route_helper.dart';

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
  final double gridWidth = Dimensions.deviceScreenWidth * 0.78;
  final double gridCrossAxisSpacing = Dimensions.width30;
  final double gridMainAxisSpacing = Dimensions.height15;
  late final double gridContainerSize;
  UserModel? userModel;
  int listViewItemCount = 3;

  List<String> listRouteList = [
    RouteHelper.getCreateQuizPage(),
    RouteHelper.getCreateQuizPage(),
    RouteHelper.getCreateQuizPage(),
  ];

  List<String> listTitle1List = [
    "Create",
    "Join in",
    "Challenge",
  ];

  List<String> listTitle2List = [
    "Quiz",
    "Quiz",
    "Friends",
  ];

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

  //override init method
  @override
  void initState() {
    super.initState();
    //fetching the user data from the firestore
    gridContainerSize = (gridWidth - (gridCrossAxisSpacing * 2)) / 2;
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
            width: gridWidth,
            height: Dimensions.deviceScreenHeight * 0.40,
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: Dimensions.height10),
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: gridCrossAxisSpacing,
                  mainAxisSpacing: gridMainAxisSpacing,
                  crossAxisCount: 2),
              itemBuilder: (context, index) => _buildGridViewContainer(index),
            ),
          ),
        ),
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
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Dimensions.height35),
                bottomRight: Radius.circular(Dimensions.height35),
              )),
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
                  GetBuilder<UserController>(builder: (userController) {
                    return BigText(
                      text: userController.userModel?.name ?? "user...",
                      size: 30,
                    );
                  }),
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
        image: const DecorationImage(
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
                  text: listTitle1List[index],
                  textColor: Colors.white,
                  size: 25,
                ),
                SizedBox(
                  height: Dimensions.height10 / 2,
                ),
                BigText(
                  text: listTitle2List[index],
                  textColor: Colors.white,
                  size: 35,
                ),
              ],
            ),
            ButtonPressEffectContainer(
              onTapFunction: () {
                Get.toNamed(listRouteList[index]);
              },
              margin: EdgeInsets.only(top: Dimensions.height10),
              height: Dimensions.height40,
              width: Dimensions.height60,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/arrowBoxWithOpacity.png"),
                    fit: BoxFit.fill),
              ),
              child: const SizedBox(height: 0),
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
                height: gridContainerSize * 0.7,
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
              height: gridContainerSize / 1.3,
              width: gridContainerSize / 1.3,
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
