import 'package:firebase_database/firebase_database.dart';
import 'package:notesapp/models/note_model.dart';

class NoteService {
  final _db = FirebaseDatabase.instance;

  Future<void> createNote(NoteModel note) async {
    await _db.ref().child('notes').push().set(note.toJson());
  }

  Future<List<NoteModel>> readNotes() async {
    final notes = await _db.ref().child('notes').once();
    if (notes.snapshot.value == null) {
      return [];
    }
    final notesMap = notes.snapshot.value as Map<dynamic, dynamic>;
    final notesList = notesMap.entries.map((entry) {
      final noteData = entry.value as Map<dynamic, dynamic>;
      return NoteModel.fromJson(noteData, entry.key);
    }).toList();
    notesList.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return notesList;
  }

  Future<void> deleteNote(String key) async {
    await _db.ref().child('notes').child(key).remove();
  }

  Future<void> updateNote(String key, NoteModel note) async {
    await _db.ref().child('notes').child(key).update(note.toJson());
  }
}