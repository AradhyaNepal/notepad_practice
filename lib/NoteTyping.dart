
import 'package:flutter/material.dart';
import 'package:notepad_practice/Model/ScreenArguments.dart';
import 'package:notepad_practice/UsefulClass/ManageNotes.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'Model/Constants.dart';
import 'Model/Notes.dart';
import 'UsefulClass/DatabaseManager.dart';

class NoteTyping extends StatefulWidget {
  static const route='/NoteTyping';
  @override
  _NoteTypingState createState() => _NoteTypingState();
}

class _NoteTypingState extends State<NoteTyping> {
  final key=GlobalKey<FormState>();
  final headerController=TextEditingController();
  final contentController=TextEditingController();
  bool loading=false;

  @override
  void dispose() {
    // TODO: implement dispose
    headerController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenArguments data=ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    bool isForEditing=data.forEditing;

    String appBarTitle='Add Notes';
    Notes notes=Notes();
    if (isForEditing){
      appBarTitle='Edit Note';
      notes=data.notes!;
      headerController.text=notes.header;
      contentController.text=notes.content;
    }
    return ChangeNotifierProvider(
      create: (context)=>ManageNotes(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          actions: [
            Padding(
                  padding:EdgeInsets.all(5),
                  child: IconButton(
                    icon: Icon(Icons.done),
                    onPressed: (){
                      if (key.currentState!.validate()){
                        notes.content=contentController.text;
                        notes.header=headerController.text;
                        if (isForEditing){
                          context.read<ManageNotes>().editNotes(notes);

                        }
                        else{
                          context.read<ManageNotes>().addNotes(notes);

                        }

                        setState(() {
                          loading=true;
                        });


                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Color(Constants().getRandomColor()),
                                content: Text('Saved',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                              )
                          );
                          Navigator.of(context).pop();

                      }

                    },
                  ),
                )
          ],
        ),
        body: SafeArea(
          child: loading?Center(child: CircularProgressIndicator(),):Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: key,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  TextFormField(
                    controller: headerController,

                    textInputAction: TextInputAction.next,
                    textAlignVertical: TextAlignVertical.center,
                    maxLength: 25,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                      fontFamily: 'Merriweather'

                    ),
                    decoration:InputDecoration(
                      counter: SizedBox(),
                      hintText: 'Header',

                      border: InputBorder.none,
                    ) ,
                  ),
                  Divider(
                    thickness: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: contentController,
                      validator: (value){
                        if (value==null || value.isEmpty) return 'Your must give some content to the note';

                      },
                      keyboardType: TextInputType.multiline,
                      maxLength: 1000,
                      maxLines: 100,
                      style: TextStyle(
                      fontFamily: 'Merriweather',
                      ),
                      decoration:InputDecoration(
                        hintText: 'Text Goes Here...',
                        border: InputBorder.none,
                      ) ,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



}

