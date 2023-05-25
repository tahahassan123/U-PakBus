import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: Container(
              child: Image.asset('images/pp.png')
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/login2.jpg'),
                  fit: BoxFit.cover,
            ),
          ),

        ),

      ),
    ),
  );
}