import 'package:flutter/material.dart';
import 'package:reversation_app/models/reservation.dart';

class AddReversation extends StatefulWidget {
  const AddReversation({super.key});

  @override
  State<AddReversation> createState() => _AddReversationState();
}

class _AddReversationState extends State<AddReversation> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController peopleController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  Future<void> pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() => selectedTime = time);
    }
  }

  void saveReservation() {
    if (nameController.text.isEmpty ||
        peopleController.text.isEmpty ||
        selectedDate == null ||
        selectedTime == null)
      return;

    final reservation = Reservation(
      name: nameController.text,
      date: selectedDate!,
      time: selectedTime!,
      people: int.parse(peopleController.text),
    );

    Navigator.pop(context, reservation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Reservation")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: peopleController,
              decoration: const InputDecoration(labelText: "Number of people"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate == null
                      ? "Select Date"
                      : selectedDate!.toLocal().toString().split(" ")[0],
                ),
                ElevatedButton(
                  onPressed: pickDate,
                  child: const Text("Pick Date"),
                ),
              ],
            ),

            // Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedTime == null
                      ? "Select Time"
                      : selectedTime!.format(context),
                ),
                ElevatedButton(
                  onPressed: pickTime,
                  child: const Text("Pick Time"),
                ),
              ],
            ),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: saveReservation,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
