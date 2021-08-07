import 'package:flutter/material.dart';
import 'package:notepad_practice/SplashPage.dart';
import 'package:provider/provider.dart';

import 'MainPage.dart';
import 'NoteTyping.dart';
import 'UsefulClass/ManageNotes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(_)=>ManageNotes(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData.dark().copyWith(
            accentColor: Color(0xFFD4D4D4)
          ),
        initialRoute: '/',
        routes: {
          SplashPage.route:(context)=> SplashPage(),
          MainPage.route:(context)=> MainPage(),
          NoteTyping.route:(context)=>NoteTyping(),
        },
      ),
    );
  }
}