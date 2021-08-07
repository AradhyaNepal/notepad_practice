import 'package:notepad_practice/UsefulClass/DatabaseManager.dart';

class Notes {
  late int id;
  late String header, content;


  Map<String, Object?> toMap(){
    var map = <String, Object?>{
      DatabaseManager.noteHeading: header,
      DatabaseManager.noteContent: content,
    };

    return map;
  }



}


