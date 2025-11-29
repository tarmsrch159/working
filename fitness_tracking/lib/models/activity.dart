// lib/models/activity.dart
class Activity {
  final String id;
  final String name;
  final int duration; // นาที
  final DateTime date;

  Activity({
    required this.id,
    required this.name,
    required this.duration,
    required this.date,
  });
}
