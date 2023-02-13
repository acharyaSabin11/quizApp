import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/controllers/landing_page_animation_controller.dart';
import 'package:quizapp/utilities/app_colors.dart';
import 'package:quizapp/utilities/dimensions.dart';
import 'package:quizapp/widgets/big_text.dart';
import 'package:quizapp/widgets/bounce_back_forth_image.dart';
import 'package:quizapp/widgets/effects/button_press_effect_container.dart';
import 'package:quizapp/widgets/icon_container.dart';
import 'package:quizapp/widgets/small_text.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with TickerProviderStateMixin {
  late AnimationController swipeAnimationController;
  late Animation swipeLeftAnimation, swipeRightAnimation;
  LandingPageAnimationController landingPageAnimationController = Get.find();

  final List<String> descriptionText = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut arcu orci, fermentum et nisi nec, facilisis molestie tortor. Vivamus eu augue ac elit ullamcorper efficitur placerat a dolor.",
    "consectetur adipiscing elit. Ut arcu orci, fermentum et nisi nec, facilisis molestie tortor. Vivamus eu augue ac elit ullamcorper efficitur placerat a dolor.",
    "dolor sit amet, consectetur adipiscing elit. Ut arcu orci, fermentum et nisi nec, facilisis molestie tortor. Vivamus eu augue ac elit ullamcorper efficitur placerat."
  ];

  final List<String> titleText = [
    "Create your own game",
    "Challenge your friends",
    "Watch Leaderboard",
  ];

  final List<String> images = [
    "assets/images/createQuiz.png",
    "assets/images/challengeFriends.png",
    "assets/images/leaderboard.png",
  ];

  @override
  void initState() {
    super.initState();
    swipeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    swipeLeftAnimation =
        Tween<double>(begin: 0, end: -Dimensions.deviceScreenWidth)
            .animate(swipeAnimationController);
    swipeRightAnimation =
        Tween<double>(begin: Dimensions.deviceScreenWidth, end: 0)
            .animate(swipeAnimationController);

    swipeAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        swipeAnimationController.reset();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    swipeAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
                        radius:
                            Dimensions.responsiveHeight(Dimensions.height130),
                        backgroundColor: AppColors.mediumOpacityWhiteColor,
                      ),
                    ),
                  ),
                  Center(
                    child: AnimatedBuilder(
                        animation: swipeAnimationController,
                        builder: (context, _) {
                          return Transform.translate(
                            offset: Offset(
                                !landingPageAnimationController.start.value
                                    ? 0.0
                                    : landingPageAnimationController.left.value
                                        ? swipeLeftAnimation.value
                                        : swipeRightAnimation.value,
                                0),
                            child: BounceBackForthImage(
                              yPos: 10,
                              xPos: 0,
                              yNeg: 10,
                              xNeg: 0,
                              duration: const Duration(seconds: 4),
                              path: images[
                                  landingPageAnimationController.index.value],
                              imageHeight: Dimensions.height130 * 2.5,
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.height50),
            AnimatedBuilder(
                animation: swipeAnimationController,
                builder: (context, _) {
                  return Transform.translate(
                    offset: Offset(
                        !landingPageAnimationController.start.value
                            ? 0.0
                            : landingPageAnimationController.left.value
                                ? swipeLeftAnimation.value
                                : swipeRightAnimation.value,
                        0),
                    child: BigText(
                      text:
                          titleText[landingPageAnimationController.index.value],
                      textColor: AppColors.titleTextColor,
                      size: 27,
                    ),
                  );
                }),
            SizedBox(height: Dimensions.height20),
            AnimatedBuilder(
                animation: swipeAnimationController,
                builder: (context, _) {
                  return Transform.translate(
                    offset: Offset(
                        !landingPageAnimationController.start.value
                            ? 0.0
                            : landingPageAnimationController.left.value
                                ? swipeLeftAnimation.value
                                : swipeRightAnimation.value,
                        0),
                    child: Container(
                      height: Dimensions.deviceScreenHeight / 6,
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.width40),
                      child: SmallText(
                        text: descriptionText[
                            landingPageAnimationController.index.value],
                        textColor: AppColors.textColor,
                      ),
                    ),
                  );
                }),
            SizedBox(height: Dimensions.height50),
            TweenAnimationBuilder(
                duration: const Duration(milliseconds: 500),
                tween: Tween<double>(
                  begin: landingPageAnimationController.endIndex.value,
                  end: landingPageAnimationController.endIndex.value,
                ),
                builder: (context, value, _) {
                  return DotsIndicator(
                    dotsCount: 3,
                    position: value,
                    decorator: DotsDecorator(
                      activeColor: AppColors.mainBlueColor,
                      activeSize: const Size(22, 9),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  );
                }),
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
              landingPageAnimationController.index.value != 2
                  ? InkWell(
                      onTap: () {
                        //go to signup page
                      },
                      splashColor: AppColors.mainBlueColor.withOpacity(0.2),
                      child: const SmallText(
                        text: "Skip",
                        textColor: AppColors.textColor,
                        size: 20,
                      ),
                    )
                  : const SizedBox(
                      width: 0,
                    ),
              ButtonPressEffectContainer(
                onTapFunction: () async {
                  if (landingPageAnimationController.index.value != 2) {
                    if (swipeAnimationController.status !=
                        AnimationStatus.forward) {
                      landingPageAnimationController.endIndex.value++;
                      landingPageAnimationController.start.value = true;
                      await swipeAnimationController.forward();
                      landingPageAnimationController.left.value = false;
                      // stopAnimation = true;
                      landingPageAnimationController.index.value++;

                      swipeAnimationController.reset();
                      await swipeAnimationController.forward();
                      landingPageAnimationController.start.value = false;
                      landingPageAnimationController.left.value = true;
                    }
                  } else {
                    //Go to signUp page.
                  }
                },
                height: Dimensions.height60,
                width: Dimensions.height60,
                child: IconContainer(
                  iconData: Icons.arrow_forward_ios,
                  containerSize: Dimensions.height60,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
