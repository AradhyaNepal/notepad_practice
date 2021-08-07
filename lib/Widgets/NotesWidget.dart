import 'package:flutter/material.dart';
import 'package:notepad_practice/Model/Notes.dart';
import 'package:notepad_practice/Model/ScreenArguments.dart';
import 'package:notepad_practice/UsefulClass/DatabaseManager.dart';
import 'package:notepad_practice/UsefulClass/ManageNotes.dart';
import 'package:provider/provider.dart';
import '../Model/Constants.dart';
import 'package:notepad_practice/NoteTyping.dart';

class NotesWidget extends StatelessWidget {
  final Notes _notes;

  NotesWidget(this._notes):super(key: ValueKey(_notes.id));

  Widget build(BuildContext context) {

    Constants constants = Constants();
    return ChangeNotifierProvider(
        create: (context) => ManageNotes(),
        child: Consumer<ManageNotes>(
          builder: (context,manageNotes,child){
            return Dismissible(
              onDismissed: (_) {
                context.read<ManageNotes>().deleteNotes(_notes.id);


                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Color(Constants().getRandomColor()),
                  content: Text(
                    'Deleted',
                    style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ));

              },
              key: ValueKey(_notes.id),
              child: InkWell(
                splashColor: Color(constants.getRandomColor()),
                onTap: () {
                  Navigator.of(context).pushNamed(NoteTyping.route,
                      arguments: ScreenArguments(true, notes: _notes));
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(constants.getRandomColor()),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _notes.header,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            _notes.content.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },


        ));
  }
}
