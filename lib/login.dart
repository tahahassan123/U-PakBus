import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pakistanbusapp/main.dart';
import 'mainDriver.dart';

void main() => runApp(MaterialApp(
  title: "App",
  home: Login(),
));
class Login extends StatelessWidget{
  Login({super.key});
  final oneController = TextEditingController();
  final twoController = TextEditingController();
  final threeController = TextEditingController();
  String email = '';
  String cnic = '';
  String password = '';
  bool doc1=false,doc2=false;
  String cnicfromdb=" ",servicefromdb=" ",namefromdb=" ";

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
                        onPressed: () async {
                          doc1=false;
                          doc2=false;
                          cnicfromdb = " ";
                          namefromdb=" ";
                          servicefromdb=" ";
                          email = oneController.text;
                          cnic = twoController.text;
                          password = threeController.text;
                          WidgetsFlutterBinding.ensureInitialized();
                          await Firebase.initializeApp(
                              );
                          try {
                            FirebaseAuth.instance.signOut();
                            FirebaseAuth auth = FirebaseAuth.instance;
                            UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: email,
                                password: password
                            );
                            FirebaseAuth.instance
                                .authStateChanges()
                                .listen((User? user) async {
                              if (user == null) {
                                print('User is currently signed out!');
                              } else {
                                print('User is signed in!');
                                DocumentSnapshot snapshot;
                                try {
                                  var collectionRef = FirebaseFirestore.instance.collection('normalusers');
                                  await collectionRef.doc(email).get().then((doc) {
                                    doc1 = doc.exists;
                                  });
                                }
                                catch(e)
                              {
                              }
                              try {
                                var collectionRef = FirebaseFirestore.instance.collection('drivers');
                                await collectionRef.doc(email).get().then((doc) {
                                  doc2 = doc.exists;
                                });
                              }
                              catch(e)
                              {
                              }
                              if(doc1)
                                {
                                  final data = await FirebaseFirestore.instance
                                      .collection("normalusers")
                                      .doc(email)
                                      .get();
                                  snapshot = data;
                                  cnicfromdb=snapshot.get("cnic").toString();
                                  namefromdb=snapshot.get("name").toString();
                                }
                                else if(doc2)
                                {
                                  final data = await FirebaseFirestore.instance
                                      .collection("drivers")
                                      .doc(email)
                                      .get();
                                  snapshot = data;
                                  cnicfromdb=snapshot.get("cnic").toString();
                                  namefromdb=snapshot.get("name").toString();
                                  servicefromdb=snapshot.get("service").toString();
                                }
                                else {
                                cnicfromdb = " ";
                                namefromdb=" ";
                                servicefromdb=" ";
                              }
                               if(cnic==cnicfromdb)
                                 {
                                   print("successful authentication");

                                   if(doc2){
                                     print("cnic: "+cnicfromdb+" name: "+namefromdb+" service: "+servicefromdb+" email: "+email);
                                     Navigator.of(context).push(MaterialPageRoute( builder: (context) => Driver(),));
                                 }
                                   else if(doc1){
                                     print("cnic: "+cnicfromdb+" name: "+namefromdb+" service: "+servicefromdb+" email: "+email);
                                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainMenu()));
                                   }
                                 }
                               else
                                 {
                                   print("cnic does not match with login credentials");
                                   FirebaseAuth.instance.signOut();
                                 }
                              }
                            });
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                            }
                            else
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Sending Message"),
                              ));
                          }
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

class DefaultFirebaseOptions {
}
