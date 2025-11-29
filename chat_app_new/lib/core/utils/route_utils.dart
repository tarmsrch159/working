import 'package:chat_app_new/core/constants/string.dart';
import 'package:chat_app_new/ui/screens/auth/login/login_screen.dart';
import 'package:chat_app_new/ui/screens/auth/signup/signup_screen.dart';
import 'package:chat_app_new/ui/screens/home/home_screen.dart';
import 'package:chat_app_new/ui/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteUtils {
  //parameter setting สำหรับเก็บชื่อroutes แล้วเอา routes ไปเช็คใน switch case
  // ถ้าตรงอันไหนไปหน้านั้น
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      //home
      case home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      //Auth
      case signup:
        return MaterialPageRoute(builder: (context) => const SignupScreen());
      case login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(body: Text("No Route")),
        );
    }
  }
}
