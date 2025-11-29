import 'package:flutter/material.dart';

class Reservation {
  String name;
  DateTime date;
  TimeOfDay time;
  int people;

  Reservation({
    required this.name,
    required this.date,
    required this.time,
    required this.people,
  });
}
