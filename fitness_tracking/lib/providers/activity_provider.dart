// lib/providers/activity_provider.dart
import 'dart:async';

import 'package:flutter/material.dart';
import '../models/activity.dart';

class ActivityProvider with ChangeNotifier {
  // _activities เก็บรายการ Activity ภายใน provider (private)
  final List<Activity> _activities = [];

  // getter เพื่อให้ส่วนอื่นเข้าถึงได้แบบ read-only
  List<Activity> get activities => List.unmodifiable(_activities);

  // เพิ่ม Activity ใหม่
  void addActivity(Activity activity) {
    _activities.add(activity);
    _remainingTime[activity.id] = activity.duration * 60;
    notifyListeners(); // แจ้ง UI ให้รีเฟรช
  }

  // ลบ Activity ตาม id
  void removeActivity(String id) {
    _activities.removeWhere((activity) => activity.id == id);
    notifyListeners(); // แจ้ง UI ให้รีเฟรช
  }

  // คำนวณเวลาทั้งหมดของ Activity ทั้งหมด
  int get totalDuration =>
      _activities.fold(0, (total, activity) => total + activity.duration);

  // Map เก็บเวลานับถอยหลังสำหรับแต่ละ Activity (วินาที)
  final Map<String, int> _remainingTime = {};

  int getRemainingTime(String activityId) => _remainingTime[activityId] ?? 0;

  Timer? _timer;

  void startCountdown(String activityId) {
    // เริ่ม countdown ถ้ายังไม่เริ่ม
    if (_timer != null) _timer!.cancel();

    final activity = _activities.firstWhere(
      (act) => act.id == activityId,
      orElse: () => throw Exception('Activity not found'),
    );

    _remainingTime[activityId] = activity.duration * 60; // นาที → วินาที

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime[activityId]! > 0) {
        _remainingTime[activityId] = _remainingTime[activityId]! - 1;
        notifyListeners();
      } else {
        timer.cancel();
        notifyListeners();
      }
    });
  }

  void stopCountdown() {
    _timer?.cancel();
  }

  void resetCountdown(String activityId) {
    final activity = _activities.firstWhere(
      (act) => act.id == activityId,
      orElse: () => throw Exception('Activity not found'),
    );
    _remainingTime[activityId] = activity.duration * 60;
    notifyListeners();
  }
}
