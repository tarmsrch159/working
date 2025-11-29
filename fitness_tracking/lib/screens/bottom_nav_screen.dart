import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fitness_tracking/screens/home_screen.dart';
import 'package:fitness_tracking/screens/stats_screen.dart';
import 'package:fitness_tracking/widget/support_widget.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  //index ตัวจับตำแหน่งใน list เพื่อเลือกว่าจะแสดงหน้าไหนบน nav
  int index = 0;

  //list เอาไว้เก็บหน้าpageแต่ละหน้า
  final pages = [HomeScreen(), StatsScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.black,
        backgroundColor: Colors.white,
        animationDuration: Duration(milliseconds: 500),
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.bar_chart, size: 30, color: Colors.white),
        ],
        onTap: (selectedindex) {
          setState(() {
            //indexตัวจับตำแหน่ง ถ้ามีการกดเปลี่ยนหน้าจะส่งเลขหน้าไปให้index และทำการเปลี่ยนpageตามตัวเลขที่selectedIndexส่งไป
            //selectedIndex parameterสำหรับเก็บตัวเลขที่จะส่งไปให้index
            index = selectedindex;
          });
        },
      ),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hi, Arm', style: AppWidget.headlineTetxtstyle(20.0)),
                  Text(
                    "Let's check your activity",
                    style: AppWidget.headlineTetxtstyle(20.0),
                  ),
                ],
              ),

              // ClipRRect(
              //   borderRadius: BorderRadius.circular(60),
              //   child: Image.asset(
              //     "assets/images/1.png",
              //     height: 50,
              //     width: 50,
              //     fit: BoxFit.cover,
              //   ),
              // ),
            ],
          ),
        ),
      ),
      //pages[index] ตัวpageแต่ละpagesที่จะเปลี่ยนไปตามตัวเลขที่ถูกส่งมาจากIndex
      body: pages[index],
    );
  }
}
