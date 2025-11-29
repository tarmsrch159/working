class Note {
  String id;
  String title;
  String content;
  DateTime createdAt;
  DateTime updatedAt;
  bool isSynced;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.isSynced = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'isSynced': isSynced,
  };

  factory Note.fromJson(Map<String, dynamic> json) {
    //ใช้รับค่าได้ทั้ง Int UnixStamp และ Iso8601
    DateTime parseDate(dynamic value) {
      if (value == null) return DateTime.now();

      if (value is int) {
        // ถ้าเป็น Unix timestamp (seconds) -> แปลงเป็น DateTime
        return DateTime.fromMillisecondsSinceEpoch(value * 1000);
      } else if (value is String) {
        // ถ้าเป็น ISO string -> parse เป็น DateTime
        return DateTime.tryParse(value) ?? DateTime.now();
      } else {
        return DateTime.now();
      }
    }

    return Note(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      createdAt: parseDate(json['createdAt']),
      updatedAt: parseDate(json['updatedAt']),
      isSynced: json['isSynced'] ?? false,
    );
  }
  Note copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSynced,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}
