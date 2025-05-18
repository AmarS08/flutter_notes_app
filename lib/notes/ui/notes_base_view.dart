import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/notes_bloc.dart';

class NotesBaseView extends StatelessWidget {
  NotesBaseView({super.key});

  NotesBloc? notesBloc;
  @override
  Widget build(BuildContext context) {
    if(notesBloc == null){
      notesBloc = BlocProvider.of<NotesBloc>(context);
      notesBloc?.initialise();
    }
    return const Placeholder();
  }
}
