import 'package:fitness_app/services/support_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 2.0,
                child: Container(
                  padding: EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                    right: 40,
                    left: 40,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Finished',
                        style: AppWidget.headlineTetxtstyle(18.0),
                      ),
                      SizedBox(height: 20),
                      Text('12', style: AppWidget.headlineTetxtstyle(50.0)),
                      Text(
                        'Completed\nWorkouts',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 2.0,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Text("🔃 In progress"),
                          Row(
                            children: [
                              Text("2"),
                              SizedBox(width: 5),
                              Text("Workouts"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 2.0,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Text("⏱️ Time spent"),
                          Row(
                            children: [
                              Text("62"),
                              SizedBox(width: 5),
                              Text("Minutes"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                "Discover new workouts",
                style: AppWidget.headlineTetxtstyle(20),
              ),
            ],
          ),
          Container(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cardio",
                            style: AppWidget.headlineTetxtstyle(20),
                          ),
                          Text("10 Exercise"),
                          Text("50 Minutes"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
