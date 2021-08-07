



import '../Model/Notes.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';



class DatabaseManager{
  static final _databaseName='notes.db';
  static final _version=1;

  static final tableName='notes_table';
  static final noteId='id';
  static final noteHeading='heading';
  static final noteContent='content';

  Database? database;

  Future<Database?> getDatabase() async{
    if(database!=null) return database;
    database=await _initDatabase();
    return database;
  }

  _initDatabase() async{

    return await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        return db.execute('''
      CREATE TABLE $tableName (
          $noteId INTEGER PRIMARY KEY,
          $noteHeading TEXT NOT NULL,
          $noteContent TEXT NOT NULL
          )
          ''');
      },

      version: _version,
    );
  }


  DatabaseManager._privateConstructor();
  static final DatabaseManager instance=DatabaseManager._privateConstructor();








    Future<int> createNote(Notes notes) async {
      Database? db=await instance.getDatabase();
      return await db!.insert(tableName, notes.toMap());

    }
    Future<List<Notes>> getNotesList() async {
      Database? db=await instance.getDatabase();
      List<Notes> notesList = [];
      List<Map<String, dynamic>> mapList = await db!.query(tableName);
      for (Map<String, dynamic> map in mapList) {
        Notes note=Notes();
        note.id = map['$noteId'];
        note.header = map['$noteHeading'];
        note.content = map['$noteContent'];
        notesList.add(note);
      }
      print('length ${notesList.length}');
      return notesList;
    }

    void deleteNote(int id) async {
      Database? db=await instance.getDatabase();
      await db!.delete(tableName, where: "$noteId = ?", whereArgs: [id]);
    }


    void updateNote(Notes notes) async {
      Database? db=await instance.getDatabase();
      await db!.update(
          tableName, {noteHeading: notes.header, noteContent: notes.content},
          where: "$noteId = ?", whereArgs: [notes.id]);
    }


  }

