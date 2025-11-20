import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fitness_app/pages/home.dart';
import 'package:fitness_app/pages/profile.dart';
import 'package:fitness_app/pages/workout.dart';
import 'package:fitness_app/services/support_widget.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  //index ตัวจับตำแหน่งใน list เพื่อเลือกว่าจะแสดงหน้าไหนบน nav
  int index = 0;

  //list เอาไว้เก็บหน้าpageแต่ละหน้า
  final pages = [Home(), ProfilePage(), WorkoutPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.black,
        backgroundColor: Colors.white,
        animationDuration: Duration(milliseconds: 500),
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.run_circle, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
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

              ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset(
                  "assets/images/1.png",
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
      //pages[index] ตัวpageแต่ละpagesที่จะเปลี่ยนไปตามตัวเลขที่ถูกส่งมาจากIndex
      body: pages[index],
    );
  }
}
