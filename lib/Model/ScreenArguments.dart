import 'package:notepad_practice/Model/Notes.dart';

class ScreenArguments {
  final bool forEditing;
  final Notes? notes;

  ScreenArguments(this.forEditing, {this.notes});
}