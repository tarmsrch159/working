// lib/widgets/activity_card.dart
import 'package:fitness_tracking/providers/activity_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../models/activity.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;

  const ActivityCard({required this.activity});

  String formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ActivityProvider>(
      builder: (context, Provider, _) {
        final remaining = Provider.getRemainingTime(activity.id);
        return Slidable(
          key: ValueKey(activity.id),
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                backgroundColor: Colors.red,
                onPressed: (ctx) {
                  // ลบ Activity จาก Provider
                  Provider.removeActivity(activity.id);
                },
                icon: Icons.delete,
                borderRadius: BorderRadius.circular(15),
              ),
            ],
          ),
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ListTile(
              title: Text(activity.name),
              subtitle: Text(
                remaining > 0 ? 'Time Left: ${formatTime(remaining)}' : 'Done!',
              ),
              trailing: SizedBox(
                width: 150,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: remaining == 0
                          ? null
                          : () => Provider.startCountdown(activity.id),
                    ),
                    IconButton(
                      icon: Icon(Icons.stop),
                      onPressed: () => Provider.stopCountdown(),
                    ),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () => Provider.resetCountdown(activity.id),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
