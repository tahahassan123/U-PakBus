import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
        title: Text('Universal Pak Bus'),
        backgroundColor: Colors.green[800],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/mainmenu2.jpg'),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(Colors.greenAccent.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: Ink.image(
                    //splashColor: Colors.black,
                    image: AssetImage('images/button3.png'),
                    height: 90,
                    width: 100,
                    fit: BoxFit.cover

                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}