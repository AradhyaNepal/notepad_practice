import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notepad_practice/MainPage.dart';



class SplashPage extends StatelessWidget {
  static const route='/';
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacementNamed(MainPage.route);
    });
    return Scaffold(

      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: CircleAvatar(backgroundImage:AssetImage('images/notes.jpg')),
                width: 100,
                height: 100,
            ),
            SizedBox(height: 50,),
            CircularProgressIndicator()
          ],
        ),
      )
    );
  }
}
