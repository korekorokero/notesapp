import 'package:flutter/material.dart';
import 'package:notesapp/models/note_model.dart';

Future<NoteModel?> showAddNoteBottomSheet(BuildContext context) {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final timestampController = TextEditingController(text: DateTime.now().millisecondsSinceEpoch.toString());

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext ctx) {
      return Padding(
        padding: EdgeInsets.only(
          left: 32.0,
          right: 32.0,
          top: 32.0,
          bottom: 32.0 + MediaQuery.of(ctx).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: contentController,
                decoration: InputDecoration(labelText: 'Content'),
                maxLines: 3,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    ctx, 
                    NoteModel(
                      key: '',
                      timestamp: int.parse(timestampController.text),
                      title: titleController.text,
                      content: contentController.text,
                    ),
                  );
                },
                child: Text('Add Note'),
              ),
            ],
          ),
        ),
      );
    },
  );
}