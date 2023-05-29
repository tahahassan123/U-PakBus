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
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/login2.jpg'),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.grey[700],
                radius: 120,
                child: CircleAvatar(
                  backgroundColor: Colors.lightGreen[700],
                  backgroundImage: AssetImage('images/pp.png'),
                  radius: 105,
                ),
              ),
              Padding(padding: const EdgeInsets.all(12),
                child: TextField(
                   decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter your Username",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.all(12),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter your CNIC",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.all(12),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter your Password",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 120),
                child: MaterialButton(
                  onPressed: () {},
                  color: Colors.green,
                  child: const Text('Log In', style: TextStyle(color: Colors.white)),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}