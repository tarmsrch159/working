import 'package:chat_app_new/core/constants/color.dart';
import 'package:chat_app_new/core/constants/string.dart';
import 'package:chat_app_new/core/constants/styles.dart';
import 'package:chat_app_new/ui/Widgets/button_widget.dart';
import 'package:chat_app_new/ui/Widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
            Text("Create your account", style: heading),
            Text("Please provide the details", style: TextStyle(color: grey)),
            20.verticalSpace,
            CustomTextField(hintName: "Enter name"),
            20.verticalSpace,
            CustomTextField(hintName: "Enter email"),
            20.verticalSpace,
            CustomTextField(hintName: "Enter password"),
            20.verticalSpace,
            CustomTextField(hintName: "Confirm password"),
            30.verticalSpace,
            CustomButton(textName: "SignUp", onPressed: () {}),
            30.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have account", style: body.copyWith(color: grey)),
                5.horizontalSpace,
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, login);
                  },

                  child: Text(
                    "Login",
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
