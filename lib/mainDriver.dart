import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Driver());
}
class Driver extends StatelessWidget{
  const Driver({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/drivermainmenu2.jpg'),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(Colors.greenAccent.withOpacity(0.75), BlendMode.dstATop),
            ),
          ),
        ),
        appBar: AppBar(
          title: Text('U-PakBus Driver'),
          backgroundColor: Colors.green[800],
        ),
      ),
    );
  }
}