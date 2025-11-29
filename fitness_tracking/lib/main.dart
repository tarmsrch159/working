import 'package:fitness_tracking/providers/activity_provider.dart';
import 'package:fitness_tracking/screens/bottom_nav_screen.dart';
import 'package:fitness_tracking/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ActivityProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fitness Tracker',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: BottomNavScreen(),
      ),
    );
  }
}
