import 'dart:io';


import 'package:flutter/foundation.dart';
import 'package:notepad_practice/Model/Notes.dart';
import 'package:notepad_practice/UsefulClass/DatabaseManager.dart';

class ManageNotes extends ChangeNotifier {
  ManageNotes(){
    setNotesList();
  }

  List<Notes> _notesList=[];
  DatabaseManager db=DatabaseManager.instance;

  Future<void> addNotes(Notes notes) async{
    notes.id=await db.createNote(notes);
    setNotesList();
  }

  Future<void> setNotesList() async{
    _notesList=(await db.getNotesList()).reversed.toList();
    notifyListeners();
  }

  Future<void> editNotes(Notes notes) async{
    db.updateNote(notes);
    setNotesList();//SetNotesList contains notify listener
  }

  Future<void> deleteNotes(int id) async{
    db.deleteNote(id);
    setNotesList();//SetNotesList contains notify listener
  }
  Future<List<Notes>> get getList async{
   return _notesList;
  }

}