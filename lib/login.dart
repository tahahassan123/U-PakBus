import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  MyApp({super.key});
  final oneController = TextEditingController();
  final twoController = TextEditingController();
  final threeController = TextEditingController();
  String email = '';
  String cnic = '';
  String password = '';
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
          child: Center(
            child: SingleChildScrollView(
            reverse: true,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(email),
                  Text(cnic),
                  Text(password),
                  CircleAvatar(
                    backgroundColor: Colors.green[900],
                    radius: 115,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      backgroundImage: AssetImage('images/pp21.png'),
                      radius: 105,
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(12),
                    child: TextField(
                      controller: oneController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter your Email",
                        suffixIcon: IconButton(
                          onPressed: () {
                            oneController.clear();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(12),
                    child: TextField(
                      controller: twoController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter your CNIC",
                        suffixIcon: IconButton(
                          onPressed: () {
                            twoController.clear();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(12),
                    child: TextField(
                      controller: threeController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter your Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            threeController.clear();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 120),
                    child: MaterialButton(
                      onPressed: () {
                        email = oneController.text;
                        cnic = twoController.text;
                        password = threeController.text;
                      },
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        //clipBehaviour: Clip.antiAliasWithSaveLayer,
                      ),
                      child: const Text('Log In', style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}