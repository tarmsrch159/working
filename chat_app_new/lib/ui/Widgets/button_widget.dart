import 'package:chat_app_new/core/constants/color.dart';
import 'package:chat_app_new/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    this.textName,
    this.loading = false,
  });

  final void Function()? onPressed;
  final String? textName;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 50.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: primary),
        onPressed: () {},
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : Text(textName!, style: body.copyWith(color: white)),
      ),
    );
  }
}
