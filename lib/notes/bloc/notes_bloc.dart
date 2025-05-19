import 'package:bloc/bloc.dart';
import 'package:sqflite_creation_poc/note.dart';

import '../../database_helper.dart';
import 'notes_states.dart';

class NotesBloc extends Cubit<NotesState> {
  NotesBloc() : super(NotesLoadingState());

  late List<Note> notesList;
  void initialise(){
    notesList = [];
  }

  Future<void> getNotesList({bool emitLoadingState = true}) async {
    if(notesList.isNotEmpty){
      notesList.clear();
    }
    if(emitLoadingState) emit(NotesLoadingState());
    try{
      notesList = await DatabaseHelper.instance.getAllNotes();
      if(notesList.isEmpty){
        emit(NotesNoDataState());
      }
      emit(NotesLoadedState());
    }catch(e){
      emit(NotesErrorState());
    }
  }
}