import 'package:flutter/material.dart';
import 'package:sqflite_creation_poc/note.dart';
import 'package:sqflite_creation_poc/notes/ui/notes_common_widgets.dart';

import '../bloc/notes_bloc.dart';

class NotesLoadedView extends StatelessWidget {
  const NotesLoadedView({
    super.key,
    required this.notesBloc,
    required this.notesList,
    required this.nameController,
    required this.descController,
  });

  final NotesBloc notesBloc;
  final List<Note> notesList;
  final TextEditingController nameController;
  final TextEditingController descController;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if(orientation == Orientation.portrait){
        return ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: notesList.length,
          itemBuilder: (context, index) {
            final note = notesList[index];
            return _notesListTile(context, note, true);
          },
        );
      } else if(orientation == Orientation.landscape){
        return GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 3.5),
          itemCount: notesList.length,
          itemBuilder: (context, index) {
            final note = notesList[index];
            return _notesListTile(context, note,false);
          },
        );
      }else {
        return SizedBox.shrink();
      }
    },);
  }

  Widget _notesListTile(BuildContext context, Note note,bool isPortrait) => ListTile(
    title: _orientationText(isPortrait, note.name),
    subtitle: _orientationText(isPortrait, note.description),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed:
              () => NotesCommonWidgets().showEditDialog(
            notesBloc,
            nameController,
            descController,
            context,
            note: note,
            isNewNote: false,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed:
              () => NotesCommonWidgets().deleteNote(
            notesBloc,
            note,
            context,
          ),
        ),
      ],
    ),
  );

  Widget _orientationText(bool isPortrait,String text) => isPortrait ? Text(text) : Text(text,maxLines: 3,overflow: TextOverflow.ellipsis,);
}
