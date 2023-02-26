import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quizapp/routes/route_helper.dart';
import 'package:quizapp/utilities/app_colors.dart';
import 'package:quizapp/widgets/big_text.dart';
import 'package:quizapp/widgets/custom_dialog.dart';
import 'package:quizapp/widgets/empty_custom_dialog.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void _showProgressIndicatorDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) => const EmptyCustomDialog(
        child: CircularProgressIndicator(
          color: AppColors.mainBlueColor,
        ),
      ),
    );
  }

  Future signIn(String email, String password) async {
    _showProgressIndicatorDialog();
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showErrorDialog(description: 'No user found for that email.');
        return;
      } else if (e.code == 'wrong-password') {
        _showErrorDialog(description: 'Wrong password provided for that user.');
        return;
      } else {
        _showErrorDialog(description: e.code);
        return;
      }
    } catch (e) {
      _showErrorDialog(description: "Something went wrong");
      return;
    }
    //Popinng the circular progress indicator dialog before navigating to the main page
    Navigator.of(Get.context!).pop();
    //Navigating to the main page if everything is set
    Get.toNamed(RouteHelper.getMainPage());
  }

  Future signUp(
      {required String email,
      required String password,
      required String name}) async {
    _showProgressIndicatorDialog();
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _showErrorDialog(description: "Password is too weak");
      } else if (e.code == 'email-already-in-use') {
        _showErrorDialog(
            description: 'The account already exists for that email.');
      } else {
        _showErrorDialog(description: e.code);
      }
      return;
    } catch (e) {
      _showErrorDialog(description: "Something went wrong");
      return;
    }

    //Save user data to the database
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set({
        'name': name,
        'email': email,
        'uid': _auth.currentUser!.uid,
      });
    } catch (e) {
      _showErrorDialog(description: e.toString());
      return;
    }

    //Popinng the circular progress indicator dialog before navigating to the main page
    Navigator.of(Get.context!).pop();
    //Navigating to the main page if everything is set
    Get.toNamed(RouteHelper.getMainPage());
  }

  Future signOut() async {
    await _auth.signOut();
    Get.toNamed(RouteHelper.getSignInPage());
    _googleSignIn.signOut();
  }

  Future signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount;
    UserCredential? userCredential;
    googleSignInAccount = await _googleSignIn.signIn().catchError((error) {
      return null;
    }); //this catch error doesnt work in debug mode but works in release mode so it will cause no issue later.

    if (googleSignInAccount != null) {
      _showProgressIndicatorDialog();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        userCredential = await _auth.signInWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          _showErrorDialog(
              description:
                  'The account already exists with a different credential.');
          return;
        } else if (e.code == 'invalid-credential') {
          _showErrorDialog(
              description:
                  'Error occurred while accessing credentials. Try again.');
          return;
        }
      } catch (e) {
        _showErrorDialog(description: e.toString());
        return;
      }

      if (userCredential != null) {
        //Save user data to the database
        try {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(_auth.currentUser!.uid)
              .set({
            'name': userCredential.user!.displayName,
            'email': userCredential.user!.email,
            'uid': _auth.currentUser!.uid,
          });
        } catch (e) {
          _showErrorDialog(description: e.toString());
          return;
        }
      }
    } else {
      return;
    }

    //Popinng the circular progress indicator dialog before navigating to the main page
    Navigator.of(Get.context!).pop();

    //Navigating to the main page if everything is set
    Get.toNamed(RouteHelper.getMainPage());
  }

  void _showErrorDialog({
    required String description,
  }) {
    Navigator.of(Get.context!).pop();
    showDialog(
        context: Get.context!,
        builder: (context) {
          return CustomDialog(
            iconData: Icons.error,
            iconColor: Colors.red,
            title: "Error",
            titleColor: Colors.red,
            descriptionText: description,
            actionWidgets: [
              TextButton(
                onPressed: () {
                  Navigator.of(Get.context!).pop();
                },
                child: const BigText(
                  text: "OK",
                  textColor: AppColors.mainBlueColor,
                  size: 18,
                ),
              ),
            ],
          );
        });
  }
}
