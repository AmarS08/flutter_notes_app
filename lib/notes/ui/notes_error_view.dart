import 'package:flutter/material.dart';

import '../bloc/notes_bloc.dart';

class NotesErrorView extends StatelessWidget {
  const NotesErrorView({super.key,required this.notesBloc});

  final NotesBloc notesBloc;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset("assets/images/server_error.jpg").image,
            fit:
            (Orientation.portrait == MediaQuery.of(context).orientation)
                ? BoxFit.fitWidth
                : BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
