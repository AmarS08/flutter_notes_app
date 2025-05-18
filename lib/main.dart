/*
import 'package:flutter/material.dart';
import 'package:sqflite_creation_poc/strings.dart';
import 'database_helper.dart';
import 'note.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NotesPage());
  }
}

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Note> _notes = [];
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshNotes();
  }

  Future<void> _refreshNotes() async {
    final notes = await DatabaseHelper.instance.getAllNotes();
    setState(() {
      _notes = notes;
    });
  }

  void _deleteNote(Note note) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "${Strings.deleteNoteText}${note.name} with ${Strings.descriptionLabelText} ${note.description}",style: TextStyle(fontSize: 20),textAlign: TextAlign.center,)),
    );
    await DatabaseHelper.instance.deleteNote(note.id ?? 0);
    _refreshNotes();
  }

  void _showEditDialog(Note? note, {bool isNewNote = false}) {
    _nameController.text = note?.name??"";
    _descController.text = note?.description??"";
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(isNewNote ? Strings.addNoteText : Strings.editNoteText),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: Strings.nameLabelText),
                ),
                TextField(
                  controller: _descController,
                  decoration: const InputDecoration(labelText: Strings.descriptionLabelText),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  if (isNewNote == false) {
                    final updatedNote = Note(
                      id: note?.id,
                      name: _nameController.text,
                      description: _descController.text,
                    );
                    await DatabaseHelper.instance.updateNote(updatedNote);
                    _nameController.clear();
                    _descController.clear();
                    Navigator.pop(context);
                    _refreshNotes();
                  } else {
                    if (_nameController.text.isEmpty ||
                        _descController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                                Strings.emptyNameAndDescriptionErrorText,style: TextStyle(fontSize: 20),textAlign: TextAlign.center,)),
                      );
                      Navigator.pop(context);
                      return;
                    }
                    final newNote = Note(
                      name: _nameController.text,
                      description: _descController.text,
                    );
                    await DatabaseHelper.instance.insertNote(newNote);
                    _nameController.clear();
                    _descController.clear();
                    Navigator.pop(context);
                    _refreshNotes();
                  }
                },
                child: Text(Strings.saveButtonText),
              ),
              TextButton(
                onPressed: () {
                  _nameController.clear();
                  _descController.clear();
                  Navigator.pop(context);
                },
                child: Text(Strings.cancelButtonText),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.yellowAccent.shade100,title: Text(Strings.appBarNotesText)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                return ListTile(
                  title: Text(note.name),
                  subtitle: Text(note.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showEditDialog(note),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteNote(note),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEditDialog(null,isNewNote: true),
        child: Icon(Icons.add),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notes/bloc/notes_bloc.dart';
import 'notes/ui/notes_base_view.dart';

void main() {
  runApp(BlocProvider(create: (context) => NotesBloc(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: NotesBaseView(),
    );
  }
}
