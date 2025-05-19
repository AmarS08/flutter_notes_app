import 'package:flutter/material.dart';
import 'package:sqflite_creation_poc/database_helper.dart';
import 'package:sqflite_creation_poc/note.dart';
import 'package:sqflite_creation_poc/notes/bloc/notes_bloc.dart';
import 'package:sqflite_creation_poc/strings.dart';

class NotesCommonWidgets {
  void showEditDialog(
    NotesBloc notesBloc,
    TextEditingController? nameController,
    TextEditingController? descController,
    BuildContext context, {
    Note? note,
    bool isNewNote = false,
  }) {
    nameController?.text = note?.name ?? "";
    descController?.text = note?.description ?? "";
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(isNewNote ? Strings.addNoteText : Strings.editNoteText),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: Strings.nameLabelText,
                    ),
                  ),
                  TextField(
                    controller: descController,
                    decoration: const InputDecoration(
                      labelText: Strings.descriptionLabelText,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  if (isNewNote == false) {
                    final updatedNote = Note(
                      id: note?.id,
                      name: nameController?.text ?? "",
                      description: descController?.text ?? "",
                    );
                    await DatabaseHelper.instance.updateNote(updatedNote);
                    nameController?.clear();
                    descController?.clear();
                    Navigator.pop(context);
                    // _reloadNotes(context);
                    notesBloc.getNotesList(emitLoadingState: false);
                  } else {
                    if ((nameController?.text ?? "").isEmpty ||
                        (descController?.text ?? "").isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            Strings.emptyNameAndDescriptionErrorText,
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                      Navigator.pop(context);
                      return;
                    }
                    final newNote = Note(
                      name: nameController?.text ?? "",
                      description: descController?.text ?? "",
                    );
                    await DatabaseHelper.instance.insertNote(newNote);
                    nameController?.clear();
                    descController?.clear();
                    Navigator.pop(context);
                    notesBloc.getNotesList(emitLoadingState: false);
                  }
                },
                child: Text(Strings.saveButtonText),
              ),
              TextButton(
                onPressed: () {
                  nameController?.clear();
                  descController?.clear();
                  Navigator.pop(context);
                },
                child: Text(Strings.cancelButtonText),
              ),
            ],
          ),
    );
  }

  void deleteNote(NotesBloc notesBloc, Note note, BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          "${Strings.deleteNoteText}${note.name} with ${Strings.descriptionLabelText} ${note.description}",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
    await DatabaseHelper.instance.deleteNote(note.id ?? 0);
    notesBloc.getNotesList(emitLoadingState: false);
  }
}
