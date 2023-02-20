import 'package:flutter/material.dart';
import 'package:quizapp/utilities/dimensions.dart';

import '../utilities/app_colors.dart';

class AppTextField extends StatefulWidget {
  String? hintText;
  IconData? prefixIcon;
  AppTextField({
    super.key,
    this.hintText,
    this.prefixIcon,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  String? errorText;

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowBlackColor,
            offset: Offset(0, 1),
            blurRadius: 1,
          ),
        ],
      ),
      child: TextField(
        controller: textEditingController,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: AppColors.textColor,
            fontSize: Dimensions.height15,
          ),
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  size: Dimensions.height20 + Dimensions.height5,
                  color: AppColors.textColor,
                )
              : null,
          errorText: errorText,
          contentPadding: EdgeInsets.symmetric(
              horizontal: Dimensions.width20,
              vertical: Dimensions.responsiveHeight(17)),
          filled: true,
          fillColor: Colors.white,
          // enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.2,
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
      ),
    );
  }
}
