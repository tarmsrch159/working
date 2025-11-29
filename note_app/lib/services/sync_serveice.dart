import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/note.dart';

class SyncService {
  // Replace with your actual API endpoint
  static const String baseUrl = 'https://6925a19382b59600d7247d13.mockapi.io/';

  Future<bool> syncNotes(Note note, bool isSynced) async {
    try {
      // Simulate cloud sync with delay
      await Future.delayed(const Duration(seconds: 2));
      // In real implementation, you would make HTTP requests here
      // Example:
      // final response = await http.put(
      //   Uri.parse('$baseUrl/noteapp/${note.id}.'),
      //   headers: {'Content-Type': 'application/json'},
      //   body: json.encode({'isSynced': isSynced}),
      // );

      return true; // Simulate successful sync
    } catch (e) {
      print('Error syncing notes: $e');
      return false;
    }
  }

  Future<List<Note>> fetchNotesFromCloud() async {
    try {
      // Simulate fetching from cloud
      await Future.delayed(const Duration(seconds: 1));

      // In real implementation:
      final response = await http.get(
        Uri.parse('$baseUrl/noteapp'),
        headers: {'Content-Type': 'application/json'},
      );
      log("res : ${response.body} ");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((note) => Note.fromJson(note)).toList();
      }
      return [];
    } catch (e) {
      print('Error fetching notes from cloud: $e');
      return [];
    }
  }

  Future<Note?> uploadNote(Note note) async {
    try {
      // Simulate upload
      await Future.delayed(const Duration(milliseconds: 500));

      // In real implementation:
      final response = await http.post(
        Uri.parse('$baseUrl/noteapp'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(note.toJson()),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return Note.fromJson(data); // <-- คืน note พร้อม id ใหม่
      }
      return null;
    } catch (e) {
      print('Error uploading note: $e');
      return null;
    }
  }

  Future<bool> updateNoteApi(Note note) async {
    final url = Uri.parse('$baseUrl/noteapp/${note.id}');

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(note.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to update: ${response.statusCode} ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<bool> deleteNoteFromCloud(String noteId) async {
    try {
      // Simulate delete
      await Future.delayed(const Duration(milliseconds: 500));

      try {
        final response = await http.delete(
          Uri.parse('$baseUrl/noteapp/$noteId'),
          headers: {'Content-Type': 'application/json'},
        );

        return response.statusCode == 200;
      } catch (e) {
        log("Delete error: $e");
        return false;
      }
      // In real implementation:

      // return true;
    } catch (e) {
      print('Error deleting note from cloud: $e');
      return false;
    }
  }
}
