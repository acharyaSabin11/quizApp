import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/controllers/landing_page_animation_controller.dart';
import 'package:quizapp/routes/route_helper.dart';
import 'package:quizapp/utilities/app_colors.dart';
import 'package:quizapp/utilities/app_constants.dart';
import 'package:quizapp/utilities/dimensions.dart';
import 'package:quizapp/widgets/big_text.dart';
import 'package:quizapp/widgets/effects/bounce_back_forth_image.dart';
import 'package:quizapp/widgets/effects/button_press_effect_container.dart';
import 'package:quizapp/widgets/exit_enabled_widget.dart';
import 'package:quizapp/widgets/icon_container.dart';
import 'package:quizapp/widgets/small_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

//This is the on-boarding screen for the app to give a general introduction of the app to the user.
class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with TickerProviderStateMixin {
  //setting last page index value in a variable to maintain updates in future
  int lastPageIndex = 2;

  //getting sharedpreferences object
  final SharedPreferences sharedPreferences = Get.find();

  //two animation controller declaration
  late AnimationController swipeAnimationController,
      containerAnimationController;
  //three animation declaration
  late Animation swipeLeftAnimation,
      swipeRightAnimation,
      containerSizeAnimation;
  //This landingPageAnimationController extends getxController and provides the reactive values to update UI dynamically when the variable value changes
  LandingPageAnimationController landingPageAnimationController = Get.find();

  // bool showSecond = false;

//List of title description for each page of the landing Screen
  final List<String> titleText = [
    "Create your own game",
    "Challenge your friends",
    "Watch Leaderboard",
  ];

//List of text description for each page of the landing Screen
  final List<String> descriptionText = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut arcu orci, fermentum et nisi nec, facilisis molestie tortor. Vivamus eu augue ac elit ullamcorper efficitur placerat a dolor.",
    "consectetur adipiscing elit. Ut arcu orci, fermentum et nisi nec, facilisis molestie tortor. Vivamus eu augue ac elit ullamcorper efficitur placerat a dolor.",
    "dolor sit amet, consectetur adipiscing elit. Ut arcu orci, fermentum et nisi nec, facilisis molestie tortor. Vivamus eu augue ac elit ullamcorper efficitur placerat."
  ];

//list of image path for each image on the image screen
  final List<String> images = [
    "assets/images/createQuiz.png",
    "assets/images/challengeFriends.png",
    "assets/images/leaderboard.png",
  ];

  @override
  void initState() {
    super.initState();
    //initializing animation controllers.
    containerAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    swipeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    //Initializing animations
    swipeLeftAnimation =
        Tween<double>(begin: 0, end: -Dimensions.deviceScreenWidth)
            .animate(swipeAnimationController);
    swipeRightAnimation =
        Tween<double>(begin: Dimensions.deviceScreenWidth, end: 0)
            .animate(swipeAnimationController);
    containerSizeAnimation =
        Tween<double>(begin: 1, end: 2.5).animate(containerAnimationController);

    //Keeping track of the container animation getting reversed.
    containerAnimationController.addStatusListener((status) {
      if (status ==
          AnimationStatus
              .dismissed) //status is dismissed when the animation reversing is complete
      {
        landingPageAnimationController.containerReversed.value = true;
      }
    });
  }

  void getStarted() {
    sharedPreferences.setBool(AppConstants.firstLoad, false);
    Get.offNamed(RouteHelper.getSignUpPage());
  }

//This function handles all the activities when going to next page of landing screen.
  Future<void> onNext() async {
    //only executes this function if the page is not last page
    if (landingPageAnimationController.index.value != lastPageIndex) {
      //doesn't execute the function if the animations are going on.
      if (swipeAnimationController.status != AnimationStatus.forward &&
          containerAnimationController.status != AnimationStatus.forward) {
        //this endIndex value sets the animation value for dots indicator
        landingPageAnimationController.endIndex.value++;
        //Puts the image offset value to 0.0 as the animation of swipe is not taking place. Now indicating the animation value to true makes it take the offset value equal to that of the animation value. By default the "left" value is set to be true which indicates that value of swipeleftAnimation should be used to create swipe animation.
        landingPageAnimationController.start.value = true;
        //resetting the animation values if they are in any other frame of animation
        swipeAnimationController.reset();
        //The swipe in and swipe out animation takes place in two phase. First the swipe-out animation takes place to the left using the swipeLeftAnimation value and then the animationController is reset and then only swipe-in animation takes place from right using the swipeRightAnimation value. This forward animation is for swipe out animation to the left.
        await swipeAnimationController.forward();
        //now changing left flag to set the animation to take value from swipeRightAnimation.
        landingPageAnimationController.left.value = false;
        //changing the contents of the page by changing index.
        landingPageAnimationController.index.value++;
        //resetting the animationController as the swipeRight and left animation both are controlled by a single animationController.
        swipeAnimationController.reset();

        //putting the animation offset to 0.0 by indicating that animation is not taking place now.

        if (landingPageAnimationController.index.value == lastPageIndex) {
          //swipe in animation from right.
          swipeAnimationController.forward();
          //starting forward animation for get started container.
          await containerAnimationController.forward();
          //this containerReversed value indicats that the container forward animation is completed.
          landingPageAnimationController.containerReversed.value = false;
          //creating delay to avoid any activity at the time when the text animation is being executed.
          await Future.delayed(const Duration(seconds: 1));
        } else {
          //swipe in animation from right.
          await swipeAnimationController.forward();
        }
        landingPageAnimationController.start.value = false;
        //resetting the left flat to true for next phase of animation.
        landingPageAnimationController.left.value = true;
        //making container animate only if it has moved to the last page of landing screen.
      }
    }
  }

//This function handles all the activities when going to previous page of landing screen.
  Future<void> onPrev() async {
    //only executes this function if the page is not first page.
    if (landingPageAnimationController.index.value != 0) {
      //only executes this fucntion if the reverse animation is not taking place.
      if (swipeAnimationController.status != AnimationStatus.reverse) {
        //for dots indicator
        landingPageAnimationController.endIndex.value--;
        //indicating start of animation
        landingPageAnimationController.start.value = true;
        //Propagating the animation to end for reversal.
        swipeAnimationController.animateTo(1.0, duration: Duration.zero);
        //taking swipeRightAnimation value.
        landingPageAnimationController.left.value = false;
        //reverse Animation.
        await swipeAnimationController.reverse();
        //loading contents of previous page by decreasing indexValue.
        landingPageAnimationController.index.value--;

        //reseting animation to end for next half of animation
        swipeAnimationController.animateTo(1.0, duration: Duration.zero);
        //taking swipeLeftAnimation value.
        landingPageAnimationController.left.value = true;
        //reverseAnimation.
        if (landingPageAnimationController.index.value == lastPageIndex - 1) {
          swipeAnimationController.reverse();
        } else {
          await swipeAnimationController.reverse();
        }

        //indicating end of animation
        landingPageAnimationController.start.value = false;
        //resetting left flag for next animation.
        landingPageAnimationController.left.value = true;
        //reversing the container animation.
        await containerAnimationController.reverse();
        //the value of text is set to "" at the end of type writter animation. So resetting it to  "Get Started" again for next animation.
        landingPageAnimationController.startedText.value = "Get Started";
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    //disposing controllers after the page is exited.
    swipeAnimationController.dispose();
    containerAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //for swipe respond
      onPanUpdate: (details) async {
        //only executes the code if onNext or onPrev function is not currently executing which is indicated b nextOrPrevIsExecuting flag.
        if (!landingPageAnimationController.methodCalled.value &&
            !landingPageAnimationController.nextOrPrevIsExecuting.value) {
          //setting methodCalled flag to indicate that the method is called just to avoid the function to be called multiple times in a single swipe.
          landingPageAnimationController.methodCalled.value = true;
          //left swipe
          if (details.delta.dx < 0) {
            landingPageAnimationController.nextOrPrevIsExecuting.value = true;
            await onNext();
          }
          //right swipe
          if (details.delta.dx > 0) {
            landingPageAnimationController.nextOrPrevIsExecuting.value = true;
            await onPrev();
          }
          landingPageAnimationController.nextOrPrevIsExecuting.value = false;
        }
      },
      onPanEnd: (details) {
        //on swiping end, the methodCalled flag is reset to false to make it ready to execute for swipe.
        landingPageAnimationController.methodCalled.value = false;
      },
      // obx widget to react to change in observable (obs) values.
      child: Obx(
        //ExitEnabledWidget to show exit dialog on back key press.
        () => ExitEnabledWidget(
          child: Scaffold(
            backgroundColor: AppColors.backgroundWhiteColor,
            body: Column(
              children: [
                //upper blue background container
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
                  //stack for circle and image to overlap
                  child: Stack(
                    children: [
                      //circle
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: Dimensions.height30),
                          child: CircleAvatar(
                            radius: Dimensions.responsiveHeight(
                                Dimensions.height130),
                            backgroundColor: AppColors.mediumOpacityWhiteColor,
                          ),
                        ),
                      ),
                      //image
                      Center(
                        //AnimatedBuilder for swipe animation
                        child: AnimatedBuilder(
                            animation: swipeAnimationController,
                            builder: (context, _) {
                              return Transform.translate(
                                offset: Offset(
                                    !landingPageAnimationController.start.value
                                        ? 0.0
                                        : landingPageAnimationController
                                                .left.value
                                            ? swipeLeftAnimation.value
                                            : swipeRightAnimation.value,
                                    0),
                                //for bouncing effect
                                child: BounceBackForthImage(
                                  yPos: 10,
                                  xPos: 0,
                                  yNeg: 10,
                                  xNeg: 0,
                                  duration: const Duration(seconds: 4),
                                  path: images[landingPageAnimationController
                                      .index.value],
                                  imageHeight: Dimensions.height130 * 2.5,
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height50),
                //Swipe animation enabled title text
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
                          text: titleText[
                              landingPageAnimationController.index.value],
                          textColor: AppColors.titleTextColor,
                          size: 27,
                        ),
                      );
                    }),
                SizedBox(height: Dimensions.height20),
                //swipe animation enabled description text
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
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width40),
                          child: SmallText(
                            text: descriptionText[
                                landingPageAnimationController.index.value],
                            textColor: AppColors.textColor,
                          ),
                        ),
                      );
                    }),
                SizedBox(height: Dimensions.height50),
                //to provide set of values to dots indicator for smooth dots animation.
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
              //skip and next button
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //removing skip button in last page
                  landingPageAnimationController.index.value != lastPageIndex
                      //skip button
                      ? InkWell(
                          onTap: () {
                            getStarted();
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
                  //Next button is shown only if the page is not lastpage of landing screen and also if the getting started container has animated back to its original size.
                  (landingPageAnimationController.index.value !=
                              lastPageIndex &&
                          landingPageAnimationController
                              .containerReversed.value)
                      ? ButtonPressEffectContainer(
                          onTapFunction: () async {
                            if (!landingPageAnimationController
                                    .methodCalled.value &&
                                !landingPageAnimationController
                                    .nextOrPrevIsExecuting.value) {
                              landingPageAnimationController
                                  .methodCalled.value = true;

                              landingPageAnimationController
                                  .nextOrPrevIsExecuting.value = true;
                              await onNext();
                              landingPageAnimationController
                                  .nextOrPrevIsExecuting.value = false;
                              landingPageAnimationController
                                  .methodCalled.value = false;
                            }
                          },
                          height: Dimensions.height60,
                          width: Dimensions.height60,
                          child: IconContainer(
                            containerColor: AppColors.mainBlueColor,
                            iconData: Icons.arrow_forward_ios,
                            containerSize: Dimensions.height60,
                          ),
                        )
                      //to animate get started contianer size.
                      : AnimatedBuilder(
                          animation: containerAnimationController,
                          builder: (context, _) {
                            return ButtonPressEffectContainer(
                              key: UniqueKey(),
                              height: Dimensions.height60,
                              width: Dimensions.height60 *
                                  containerSizeAnimation.value,
                              onTapFunction: () {
                                getStarted();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.mainBlueColor,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.height15)),
                                child: Center(
                                    child: IgnorePointer(
                                  child: AnimatedTextKit(
                                    onFinished: () =>
                                        landingPageAnimationController
                                            .startedText.value = "",
                                    displayFullTextOnTap: true,
                                    totalRepeatCount: 1,
                                    pause: const Duration(milliseconds: 500),
                                    animatedTexts: [
                                      TyperAnimatedText(
                                          landingPageAnimationController
                                              .startedText.value,
                                          textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20))
                                    ],
                                  ),
                                )),
                              ),
                            );
                          }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
