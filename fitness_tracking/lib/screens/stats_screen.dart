// lib/screens/stats_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/activity_provider.dart';

class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final totalDuration = Provider.of<ActivityProvider>(context).totalDuration;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            // ---- ส่วนบน ----
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text('Statistics', style: TextStyle(fontSize: 20)),
            ),

            // ---- ส่วนกลาง (ขยายเต็มพื้นที่) ----
            Expanded(
              child: Center(
                child: Text(
                  'Total Activity Duration: $totalDuration minutes',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // ส่วนล่าง (ปล่อยว่าง)
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
