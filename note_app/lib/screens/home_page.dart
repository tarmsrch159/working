import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:note_app/services/sync_serveice.dart';
import '../models/note.dart';
// import '../services/storage_service.dart';
// import '../services/sync_service.dart';
import '../widgets/note_card.dart';
import '../widgets/search_bar.dart';
import '../utils/constants.dart';
import 'note_editor_page.dart';

class NotesHomePage extends StatefulWidget {
  const NotesHomePage({Key? key}) : super(key: key);

  @override
  State<NotesHomePage> createState() => _NotesHomePageState();
}

class _NotesHomePageState extends State<NotesHomePage> {
  // final StorageService _storageService = StorageService();
  final SyncService _syncService = SyncService();
  final TextEditingController _searchController = TextEditingController();

  List<Note> _notes = [];
  List<Note> _filteredNotes = [];
  bool _isLoading = true;
  bool _isSyncing = false;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadNotes() async {
    setState(() => _isLoading = true);

    //Fetch From Api Mockup
    _notes = await _syncService.fetchNotesFromCloud();
    log("notes : $_notes");
    _filteredNotes = _notes;

    setState(() => _isLoading = false);

    //Fetch From storage share pref
    // _notes = await _storageService.loadNotes();
  }

  // Future<void> _saveNotes() async {
  //   if (_notes.isNotEmpty) {
  //     await _syncService.uploadNote(_notes.first);
  //   }
  // }

  Future<void> _syncNotes() async {
    setState(() => _isSyncing = true);

    for (var note in _notes) {
      if (!note.isSynced) {
        // เฉพาะ note ที่ยังไม่ได้ sync
        bool success = await _syncService.syncNotes(note, true);
        log("success : $success");
        if (success) {
          note.isSynced = true; // update local state
        }
      }
    }
    setState(() => _isSyncing = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Notes synced successfully!')),
      );
    }
  }

  void _searchNotes(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredNotes = _notes;
      } else {
        _filteredNotes = _notes.where((note) {
          return note.title.toLowerCase().contains(query.toLowerCase()) ||
              note.content.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _addOrEditNote({Note? note}) async {
    //รับ Dataจากหน้า NoteEditor Page
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteEditorPage(note: note)),
    );

    if (result != null && result is Note) {
      setState(() {
        if (note == null) {
          _notes.insert(0, result);
        } else {
          final index = _notes.indexWhere((n) => n.id == result.id);
          if (index != -1) {
            _notes[index] = result;
          }
        }
        _searchNotes(_searchController.text);
      });
      // await _saveNotes();
    }
  }

  void _deleteNote(Note note) async {
    // 1️⃣ ลบ note จาก UI ทันที (optimistic update)
    setState(() {
      _notes.removeWhere((n) => n.id == note.id);
      _searchNotes(_searchController.text);
    });

    // 2️⃣ เรียก API ลบ note จาก cloud
    final success = await _syncService.deleteNoteFromCloud(note.id);

    // 3️⃣ ถ้า API ล้มเหลว → ใส่ note กลับ
    if (!success) {
      setState(() {
        _notes.insert(0, note);
        _searchNotes(_searchController.text);
      });
    }

    // 4️⃣ แสดง SnackBar พร้อม Undo
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(AppConstants.deleteMessage),
          action: SnackBarAction(
            label: AppConstants.undoLabel,
            onPressed: () {
              setState(() {
                _notes.insert(0, note);
                _searchNotes(_searchController.text);
              });
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            icon: _isSyncing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Icon(Icons.cloud_upload),
            onPressed: _isSyncing ? null : _syncNotes,
            tooltip: 'Sync to Cloud',
          ),
        ],
      ),
      body: Column(
        children: [
          NotesSearchBar(
            controller: _searchController,
            onChanged: _searchNotes,
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredNotes.isEmpty
                ? _buildEmptyState()
                : _buildNotesList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addOrEditNote(),
        icon: const Icon(Icons.add),
        label: const Text('New Note'),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.note_add, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            _searchController.text.isEmpty
                ? AppConstants.emptyNotesTitle
                : AppConstants.noResultsTitle,
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            _searchController.text.isEmpty
                ? AppConstants.emptyNotesSubtitle
                : AppConstants.noResultsSubtitle,
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
      ),
      itemCount: _filteredNotes.length,
      itemBuilder: (context, index) {
        final note = _filteredNotes[index];
        return NoteCard(
          note: note,
          onTap: () => _addOrEditNote(note: note),
          onDelete: () {
            return _deleteNote(note);
          },
        );
      },
    );
  }
}
