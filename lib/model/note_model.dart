class NoteModel {
  final String title;
  final String content;

  NoteModel({
    required this.title,
    required this.content
  });
}

List<NoteModel> notes = [
  NoteModel(
    title: 'Note 1',
    content: 'Ini konten dari note 1'
  ),
  NoteModel(
    title: 'Note 2',
    content: 'Ini konten dari note 2'
  ),
];