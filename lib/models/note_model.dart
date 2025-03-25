class NoteModel {
  final String key;
  final String title;
  final String content;
  final int timestamp;

  NoteModel({
    required this.key,
    required this.title,
    required this.content,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'timestamp': timestamp,
    };
  }

  factory NoteModel.fromJson(Map<dynamic, dynamic> json, String key) {
    return NoteModel(
      key: key,
      title: json['title'],
      content: json['content'],
      timestamp: json['timestamp'],
    );
  }
}