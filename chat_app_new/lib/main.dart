import 'package:chat_app_new/core/constants/string.dart';
import 'package:chat_app_new/core/utils/route_utils.dart';
import 'package:chat_app_new/firebase_options.dart';
import 'package:chat_app_new/ui/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  //เป็นชุดที่ดึงข้อมูลจาก firebase มาก่อนแล้วค่อยเริ่ม app
  //basic setup with firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteUtils.onGenerateRoute,
          title: 'ChatApp',
          home: SplashScreen(),
        );
      },
    );
  }
}
