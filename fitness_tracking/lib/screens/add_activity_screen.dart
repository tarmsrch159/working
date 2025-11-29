// lib/screens/add_activity_screen.dart
import 'package:fitness_tracking/widget/custom_button.dart';
import 'package:fitness_tracking/widget/modernTextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/activity.dart';
import '../providers/activity_provider.dart';

class AddActivityScreen extends StatefulWidget {
  @override
  _AddActivityScreenState createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  final _nameController = TextEditingController();
  final _durationController = TextEditingController();

  void _saveActivity() {
    final name = _nameController.text.trim();
    final duration = int.tryParse(_durationController.text.trim()) ?? 0;

    if (name.isEmpty || duration <= 0) return;

    final newActivity = Activity(
      id: DateTime.now().toString(),
      name: name,
      duration: duration,
      date: DateTime.now(),
    );

    Provider.of<ActivityProvider>(
      context,
      listen: false,
    ).addActivity(newActivity);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Activity')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ModernNeumorphicTextField(
              hintText: 'Activity Name test',
              controller: _nameController,
            ),

            SizedBox(height: 20),
            ModernNeumorphicTextField(
              hintText: 'Duration (minutes)',
              controller: _durationController,
            ),

            SizedBox(height: 20),
            ModernCenterButton(
              text: 'Save',
              icon: Icons.save,
              onTap: _saveActivity,
              h_button: 15,
              w_button: 15,
            ),
          ],
        ),
      ),
    );
  }
}
