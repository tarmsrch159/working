import 'package:chat_app_new/core/constants/color.dart';
import 'package:chat_app_new/core/constants/string.dart';
import 'package:chat_app_new/core/constants/styles.dart';
import 'package:chat_app_new/ui/Widgets/button_widget.dart';
import 'package:chat_app_new/ui/Widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: 0.05.sw,
          vertical: 10.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            30.verticalSpace,
            Text("Login", style: heading),
            Text(
              "Please Log in to your Account!",
              style: TextStyle(color: grey),
            ),
            20.verticalSpace,
            CustomTextField(hintName: "Enter name"),
            20.verticalSpace,
            CustomTextField(hintName: "Enter password"),
            30.verticalSpace,
            CustomButton(textName: "Login", onPressed: () {}),
            30.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have any account",
                  style: body.copyWith(color: grey),
                ),
                5.horizontalSpace,
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, signup);
                  },
                  child: Text(
                    "SignUp",
                    style: body.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
