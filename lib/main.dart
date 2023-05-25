import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
         decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage('images/mainmenu2.jpg'),
           fit: BoxFit.cover,
         ),
         ),
          ),
        appBar: AppBar(
            title: Text('Universal Pak Bus'),
          backgroundColor: Colors.green[800],
        ),
      ),
    ),
  );
}