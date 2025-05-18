import 'package:bloc/bloc.dart';

import 'notes_states.dart';

class NotesBloc extends Bloc<NotesBloc, NotesState> {
  NotesBloc() : super(NotesLoadingState());
  void initialise(){}
}