// lib/screens/home_screen.dart
import 'package:fitness_tracking/widget/activity_card.dart';
import 'package:fitness_tracking/widget/custom_button.dart';
import 'package:fitness_tracking/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/activity_provider.dart';
import 'add_activity_screen.dart';
import 'stats_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final activities = Provider.of<ActivityProvider>(context).activities;

    return Scaffold(
      // appBar: AppBar(
      //   title: Center(child: Text('Fitness Tracker')),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.bar_chart),
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (_) => StatsScreen()),
      //         );
      //       },
      //     ),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 30),
        child: Column(
          children: [
            Center(
              child: Text(
                'Fitness Tracker',
                style: AppWidget.headlineTetxtstyle(20),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: activities.length,
                itemBuilder: (ctx, i) => ActivityCard(activity: activities[i]),
              ),
            ),
            ModernCenterButton(
              text: "Add",
              icon: Icons.add,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddActivityScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
