import 'package:flutter/material.dart';
import 'package:notepad_practice/Model/Notes.dart';
import 'package:notepad_practice/Model/ScreenArguments.dart';
import 'package:notepad_practice/NoteTyping.dart';
import 'package:notepad_practice/UsefulClass/DatabaseManager.dart';
import 'package:notepad_practice/UsefulClass/ManageNotes.dart';
import 'package:notepad_practice/Widgets/NotesWidget.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

import 'Model/Constants.dart';

class MainPage extends StatefulWidget {
  static const route = '/MainPage';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Notes App'),
          leading: Padding(
              padding: EdgeInsets.all(5),
              child: CircleAvatar(
                  backgroundImage: AssetImage('images/notes.jpg'))),
        ),
        floatingActionButton: FloatingActionButton(
          splashColor: Color(
            Constants().getRandomColor(),
          ),
          backgroundColor: Color(
            Constants().getRandomColor(),
          ),
          onPressed: () {
            Navigator.of(context)
                .pushNamed(NoteTyping.route, arguments: ScreenArguments(false));
          },
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        body: FutureBuilder(

                  future:context.watch<ManageNotes>().getList,
                  builder: (context,snapshot){
                if(snapshot.hasData){
                  List<Notes> notesList=snapshot.data as List<Notes>;
                  return GridView.builder(

                    itemCount:notesList.length,
                    itemBuilder: (context, index) {
                      return NotesWidget(notesList[index]);
                    },
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 250),
                  );

                }
                else{
                  return Center(child:CircularProgressIndicator());
                }
              })



          );

  }

}

