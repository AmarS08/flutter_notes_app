import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_creation_poc/notes/bloc/notes_states.dart';
import 'package:sqflite_creation_poc/notes/ui/notes_common_widgets.dart';
import 'package:sqflite_creation_poc/notes/ui/notes_error_view.dart';
import 'package:sqflite_creation_poc/notes/ui/notes_loaded_view.dart';
import 'package:sqflite_creation_poc/strings.dart';

import '../bloc/notes_bloc.dart';
import 'notes_no_data_view.dart';

class NotesBaseView extends StatelessWidget {
  const NotesBaseView({super.key});

  @override
  Widget build(BuildContext context) {
    NotesBloc? notesBloc =
        BlocProvider.of<NotesBloc>(context)
          ..initialise()
          ..getNotesList();
    TextEditingController nameController = TextEditingController();
    TextEditingController descController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent.shade100,
        title: Text(Strings.appBarNotesText),
      ),
      body: BlocBuilder(
        bloc: notesBloc,
        builder: (context, state) {
          // return const Center(child: CupertinoActivityIndicator());
          // return NotesNoDataView(notesBloc: notesBloc);
          // return NotesErrorView(notesBloc: notesBloc);
          if (state is NotesLoadingState) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (state is NotesLoadedState) {
            return NotesLoadedView(
              notesBloc: notesBloc,
              notesList: notesBloc.notesList,
              nameController: nameController,
              descController: descController,
            );
          } else if (state is NotesNoDataState) {
            return NotesNoDataView(notesBloc: notesBloc);
          } else if (state is NotesErrorState) {
            return NotesErrorView(notesBloc: notesBloc);
          } else {
            return SizedBox.shrink(); //This case should not happen
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => NotesCommonWidgets().showEditDialog(
              notesBloc,
              nameController,
              descController,
              context,
              isNewNote: true,
            ),
        child: Icon(Icons.add),
      ),
    );
  }
}
