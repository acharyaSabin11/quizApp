import 'package:flutter/material.dart';
import 'package:quizapp/utilities/dimensions.dart';

import '../utilities/app_colors.dart';

class AppTextField extends StatefulWidget {
  String? hintText;
  AppTextField({super.key, this.hintText});

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  String? errorText;

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        errorText: errorText,
        contentPadding: EdgeInsets.symmetric(
            horizontal: Dimensions.responsiveWidth(20),
            vertical: Dimensions.responsiveHeight(17)),
        filled: true,
        fillColor: AppColors.backgroundWhiteColor,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(13),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: AppColors.mainBlueColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(13),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(13),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: Colors.orange,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(13),
          ),
        ),
        hintText: widget.hintText,
      ),
      onChanged: (value) {
        if (value.isEmpty) {
          setState(() {
            errorText = "This is a required field";
          });
        } else {
          setState(() {
            errorText = null;
          });
        }
      },
    );
  }
}
