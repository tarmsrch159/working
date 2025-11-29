import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'Notes App';
  static const String appVersion = '1.0.0';

  // Colors
  static const Color primaryColor = Colors.blue;
  static const Color accentColor = Colors.blueAccent;
  static const Color errorColor = Colors.red;
  static const Color successColor = Colors.green;

  // Sizes
  static const double defaultPadding = 16.0;
  static const double cardElevation = 2.0;
  static const double borderRadius = 12.0;

  // Messages
  static const String syncSuccessMessage = 'Notes synced successfully!';
  static const String syncErrorMessage = 'Failed to sync notes';
  static const String deleteMessage = 'Note deleted';
  static const String undoLabel = 'Undo';

  // Placeholders
  static const String emptyNotesTitle = 'No notes yet';
  static const String emptyNotesSubtitle = 'Tap + to create your first note';
  static const String noResultsTitle = 'No notes found';
  static const String noResultsSubtitle = 'Try a different search';
  static const String untitled = 'Untitled';
  static const String noContent = 'No content';

  // Hints
  static const String searchHint = 'Search notes...';
  static const String titleHint = 'Title';
  static const String contentHint = 'Start typing...';

  // Durations
  static const Duration syncDuration = Duration(seconds: 2);
  static const Duration snackBarDuration = Duration(seconds: 2);
}
