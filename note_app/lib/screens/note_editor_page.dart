import 'package:flutter/material.dart';
import 'package:note_app/services/sync_serveice.dart';
import '../models/note.dart';
import '../utils/constants.dart';

class NoteEditorPage extends StatefulWidget {
  final Note? note;

  const NoteEditorPage({Key? key, this.note}) : super(key: key);

  @override
  State<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool _hasChanges = false;
  final SyncService _syncService = SyncService();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(
      text: widget.note?.content ?? '',
    );

    _titleController.addListener(_onTextChanged);
    _contentController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (!_hasChanges) {
      setState(() => _hasChanges = true);
    }
  }

  void _saveNote() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    // 1️⃣ ไม่ต้องบันทึกถ้าไม่มีข้อมูล
    if (title.isEmpty && content.isEmpty) {
      Navigator.pop(context);
      return;
    }

    final now = DateTime.now();

    // ตรวจสอบว่าเป็น edit หรือ add
    final isEditing = widget.note != null;

    // 2️⃣ สร้าง Note ชั่วคราว (id อาจยังไม่มี)
    Note note = Note(
      id: widget.note?.id ?? '', // ถ้ามี id เดิมใช้ id นั้น
      title: title,
      content: content,
      createdAt: widget.note?.createdAt ?? now,
      updatedAt: now,
      isSynced: false,
    );

    // 3️⃣ อัปโหลด note ขึ้น API
    // call API
    Note? uploadedNote;
    if (isEditing) {
      // Edit → PUT request
      uploadedNote = await _syncService.updateNoteApi(note) ? note : null;
    } else {
      // Add → POST request
      uploadedNote = await _syncService.uploadNote(note);
    }

    // 4️⃣ ถ้า server ส่ง note กลับมา ใช้ note ใหม่ (มี id จริงจาก cloud)
    if (uploadedNote != null) {
      note = uploadedNote;
    }

    // 5️⃣ ส่ง note กลับไปยังหน้า list
    // ignore: use_build_context_synchronously
    Navigator.pop(context, note);
  }

  Future<bool> _onWillPop() async {
    if (_hasChanges) {
      final shouldSave = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Save changes?'),
          content: const Text(
            'Do you want to save your changes before leaving?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Discard'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Save'),
            ),
          ],
        ),
      );

      if (shouldSave == true) {
        _saveNote();
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.note == null ? 'New Note' : 'Edit Note'),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _saveNote,
              tooltip: 'Save',
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: AppConstants.titleHint,
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              Expanded(
                child: TextField(
                  controller: _contentController,
                  decoration: const InputDecoration(
                    hintText: AppConstants.contentHint,
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 16),
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
