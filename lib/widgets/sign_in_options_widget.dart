import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/controllers/auth_controller.dart';

import '../utilities/dimensions.dart';
import 'effects/button_press_effect_container.dart';

class SignInOptionsWidget extends StatelessWidget {
  SignInOptionsWidget({super.key});
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonPressEffectContainer(
          onTapFunction: () async {
            await authController.signInWithGoogle();
          },
          height: Dimensions.height40,
          width: Dimensions.height40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.height30),
            boxShadow: iconBoxShadow(),
          ),
          child: CircleAvatar(
            radius: Dimensions.height20,
            backgroundImage: const AssetImage(
              "assets/images/google.png",
            ),
          ),
        ),
        SizedBox(width: Dimensions.width40),
        ButtonPressEffectContainer(
          onTapFunction: () async {
            await authController.signInWithMicrosoft();
          },
          height: Dimensions.height40,
          width: Dimensions.height40,
          decoration: BoxDecoration(
            boxShadow: iconBoxShadow(),
            borderRadius: BorderRadius.circular(Dimensions.height30),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: Dimensions.height20,
            backgroundImage: const AssetImage(
              "assets/images/microsoft.png",
            ),
          ),
        ),
        SizedBox(width: Dimensions.width40),
        ButtonPressEffectContainer(
          onTapFunction: () async {
            await authController.signInWithFacebook();
          },
          height: Dimensions.height40,
          width: Dimensions.height40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.height30),
            boxShadow: iconBoxShadow(),
          ),
          child: CircleAvatar(
            radius: Dimensions.height20,
            backgroundImage: const AssetImage(
              "assets/images/facebook.png",
            ),
          ),
        ),
        SizedBox(width: Dimensions.width40),
        ButtonPressEffectContainer(
          onTapFunction: () async {
            // await authController.signInWithFacebook();
          },
          height: Dimensions.height40,
          width: Dimensions.height40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.height30),
            boxShadow: iconBoxShadow(),
          ),
          child: CircleAvatar(
            radius: Dimensions.height20,
            backgroundImage: const AssetImage(
              "assets/images/twitter.png",
            ),
          ),
        ),
      ],
    );
  }

  List<BoxShadow> iconBoxShadow() {
    return [
      BoxShadow(
        color: Colors.grey,
        blurRadius: Dimensions.height5,
        offset: const Offset(1, 2),
      ),
    ]; // changes position of shadow
  }
}
