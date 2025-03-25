import 'package:flutter/material.dart';

Future<List<String>?> showEditNoteBottomSheet(BuildContext context, String initTitle, String initContent) {
  final titleController = TextEditingController(text: initTitle);
  final contentController = TextEditingController(text: initContent);

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
                  Navigator.pop(ctx, [
                    titleController.text,
                    contentController.text,
                  ]);
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      );
    },
  );
}