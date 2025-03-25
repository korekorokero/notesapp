import 'package:flutter/material.dart';
import 'package:notesapp/pages/add_note.dart';
import 'package:notesapp/models/note_model.dart';
import 'package:notesapp/pages/edit_note.dart';
import 'package:notesapp/pages/note_card.dart';
import 'package:notesapp/services/note_service.dart';

class HomePage extends StatefulWidget {
  final String title;
  
  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  final _noteService = NoteService();
  List<NoteModel> notes = [];

  @override
  void initState() {
    super.initState();
    _fetchNotes();
  }

  Future<void> _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });
    notes = await _noteService.readNotes();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(
              top: 12.0,
              left: 12.0,
              right: 12.0,
              bottom: 80.0
            ),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return NoteCard(
                title: notes[index].title,
                content: notes[index].content,
                onDelete: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  await _noteService.deleteNote(notes[index].key);

                  setState(() {
                    notes.removeAt(index);
                    _isLoading = false;
                  });
                },
                onEdit: () async {
                  final newNote = await showEditNoteBottomSheet(context, notes[index].title, notes[index].content);
                  if (newNote != null) {
                    setState(() {
                      _isLoading = true;
                    });

                    final updatedNote = NoteModel(
                      key: notes[index].key,
                      title: newNote[0],
                      content: newNote[1],
                      timestamp: notes[index].timestamp,
                    );

                    await _noteService.updateNote(notes[index].key, updatedNote);

                    setState(() {
                      notes[index] = updatedNote;
                      _isLoading = false;
                    });
                  }
                }
              );
            },
          ),
          if (_isLoading)
          Container(
            color: Colors.black54,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newNote = await showAddNoteBottomSheet(context);
          if (newNote != null) {
            setState(() {
              _isLoading = true;
            });

            await _noteService.createNote(newNote);
            await _fetchNotes();

            setState(() {
              _isLoading = false;
            });
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}