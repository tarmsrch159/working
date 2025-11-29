import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';

class StorageService {
  static const String _notesKey = 'notes';

  Future<List<Note>> loadNotes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final notesJson = prefs.getString(_notesKey) ?? '[]';
      final List<dynamic> notesList = json.decode(notesJson);

      List<Note> notes = notesList.map((note) => Note.fromJson(note)).toList();
      notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      return notes;
    } catch (e) {
      print('Error loading notes: $e');
      return [];
    }
  }

  Future<bool> saveNotes(List<Note> notes) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final notesJson = json.encode(
        notes.map((note) => note.toJson()).toList(),
      );
      return await prefs.setString(_notesKey, notesJson);
    } catch (e) {
      print('Error saving notes: $e');
      return false;
    }
  }

  Future<bool> clearAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_notesKey);
    } catch (e) {
      print('Error clearing notes: $e');
      return false;
    }
  }
}
