import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_pratice/provider/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        actions: [
          Padding(
            padding: EdgeInsetsGeometry.only(right: 8),
            child: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return Switch(
                  activeThumbColor: Colors.white,
                  inactiveThumbColor: Colors.white,
                  thumbColor: WidgetStatePropertyAll(Colors.orange),
                  inactiveTrackColor: Colors.transparent,
                  thumbIcon: MaterialStatePropertyAll(
                    //เช็คเงื่อนไขกับ isSelected ใน providder
                    //ถ้าปุ่มเป็นกลางคืนให้แสดงicon กลางคืน
                    //ถ้าปุ่มเป็นกลางวันให้แสดงicon กลางวัน
                    themeProvider.isSelected
                        ? Icon(Icons.nights_stay)
                        : Icon(Icons.sunny),
                  ),
                  value: themeProvider.isSelected,
                  onChanged: (value) {
                    themeProvider.toggleThemefn();
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Center(
          child: Column(
            children: [
              Text(
                "Paris",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 25),
              Icon(Icons.sunny, size: 250, color: Colors.orange),
              const SizedBox(height: 25),
              Text(
                "20 ํ C",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
              ),

              Text(
                "Good Morning",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),

              Text(
                "Noida",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
              ),

              SizedBox(height: 25),
              SizedBox(width: 50, child: Divider(thickness: 3)),

              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.wb_twighlight),
                        Text('Sunrise'),
                        Text("7:00"),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                      child: VerticalDivider(color: Colors.black, thickness: 1),
                    ),

                    Column(
                      children: [Icon(Icons.air), Text('Wind'), Text("4m/s")],
                    ),
                    SizedBox(
                      height: 50,
                      child: VerticalDivider(color: Colors.black, thickness: 1),
                    ),
                    Column(
                      children: [
                        Icon(Icons.thermostat),
                        Text('Temperature'),
                        Text("23"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
