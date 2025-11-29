import 'package:flutter/material.dart';
import 'package:reversation_app/models/reservation.dart';
import 'package:reversation_app/screens/add_reversation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Reservation> reservations = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservation System"),
        centerTitle: true,
      ),
      body: reservations.isEmpty
          ? const Center(child: Text("No reservations yet"))
          : ListView.builder(
              itemCount: reservations.length,
              itemBuilder: (context, index) {
                final r_info = reservations[index];

                return ListTile(
                  leading: const Icon(Icons.event),
                  title: Text(r_info.name),
                  subtitle: Text(
                    "${r_info.date.toLocal().toString().split('  '[0])} - "
                    "${r_info.time.format(context)} | ${r_info.people} people",
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newReservetion = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddReversation()),
          );

          if (newReservetion != null) {
            setState(() {
              reservations.add(newReservetion);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
