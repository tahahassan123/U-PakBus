import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pakistanbusapp/main.dart';
import 'mainDriver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_51NCzkJI3GjRc0k0GRc5SfTIoeaHzyaYirzzindw9IkPdbw7la71lCzcx26PDJw4LPhajCk9zqrjarb2Hhxdq5t0D00QNf1VOpH';
  await Firebase.initializeApp(
  );
  runApp(MaterialApp(
    title: "LoginPage",
    home: Main(),
  ));}

// Stream<List<User>> readUsers() => FirebaseFirestore.instance
//     .collection('normalusers')
//     .snapshots()
//     .map((snapshots) =>
//       snapshots.docs.map((doc) => UserSignUp.fromJson(doc.data())).toList());

class Main extends StatelessWidget{
  const Main({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          else if (snapshot.hasError){
            return Center(child: Text('Something went wrong!'),);
          }
          else if (snapshot.hasData){
            return MainMenu();
          }
          else{
            return LoginOrSignUp();
          }
        }
    ),
  );
}
//final navigatorKey = GlobalKey<NavigatorState>();
class Login extends StatefulWidget {
  final VoidCallback onClickSignup;
  const Login({
    Key? key,
    required this.onClickSignup,
  }) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login> {
  final oneController = TextEditingController();
  final twoController = TextEditingController();
  final threeController = TextEditingController();
  String email = '';
  String cnic = '';
  String password = '';
  bool doc1=false,doc2=false;
  String cnicfromdb=" ",servicefromdb=" ",namefromdb=" ";
  //async {}
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/login21.jpeg'),
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.9), BlendMode.dstATop),
                  ),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(29),
                            child: CircleAvatar(
                              backgroundColor: Colors.green[900],
                              radius: 105,
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                backgroundImage: AssetImage('images/pp21.png'),
                                radius: 95,
                              ),
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
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(color: Colors.grey[100]),
                                  text: 'No account? ',
                                  children: [
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()..onTap = widget.onClickSignup,
                                      style: TextStyle(color: Colors.green[700]),
                                      text: 'Sign Up',
                                    ),
                                  ],
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
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainMenu(),));
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
            ],
          ),
        ),
      ),
    );
  }
}
class SignUp extends StatefulWidget {
  final VoidCallback onClickSignup;
  const SignUp({
    Key? key,
    required this.onClickSignup,
  }) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  final oneController = TextEditingController();
  final twoController = TextEditingController();
  final threeController = TextEditingController();
  final fourController = TextEditingController();
  String email = '';
  String cnic = '';
  String password = '';
  String username = '';
  //async {}
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      //navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/login3.jpeg'),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.9), BlendMode.dstATop),
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              reverse: true,
              padding: EdgeInsets.all(12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(email),
                    Text(cnic),
                    Text(password),
                    CircleAvatar(
                      backgroundColor: Colors.green[900],
                      radius: 90,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        backgroundImage: AssetImage('images/pp21.png'),
                        radius: 80,
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(12),
                      child: TextField(
                        controller: oneController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Enter your Name",
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
                          hintText: "Enter your Email",
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
                          hintText: "Enter your CNIC",
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
                    Padding(padding: const EdgeInsets.all(12),
                      child: TextField(
                        controller: fourController,
                        decoration: InputDecoration(

                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Enter your Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              fourController.clear();
                            },
                            icon: const Icon(Icons.clear),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.grey[800]),
                            text: 'Have an account? ',
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()..onTap = widget.onClickSignup,
                                style: TextStyle(color: Colors.green[600]),
                                text: 'Login',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 120),
                      child: MaterialButton(
                        onPressed: () async {
                          username = oneController.text;
                          email = twoController.text;
                          cnic = threeController.text;
                          password = fourController.text;
                          if(username != null || email != null || cnic != null || password != null){
                          Future SignUp() async {
                            final user = UserSignUp(
                              cnic: int.parse(threeController.text),
                              name: oneController.text,
                            );
                            createUser(user);
                          }
                            // showDialog(
                            //     context: context,
                            //   barrierDismissible: false,
                            //   builder: (context) => Center(child: CircularProgressIndicator(),),
                            // );
                            try{
                              await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: twoController.text.trim(),
                                password: password.trim(),
                              );

                            } on FirebaseAuthException catch (e) {
                              print(e);
                            }
                            //navigatorKey.currentState!.popUntil((route) => route.isFirst);
                          }
                          },
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          //clipBehaviour: Clip.antiAliasWithSaveLayer,
                        ),
                        child: const Text('Sign Up', style: TextStyle(fontSize: 18, color: Colors.white)),
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
class UserSignUp{
  String id;
  final String name;
  final int cnic;
  final int amount;
  final String date;
  final String email;
  final String destination;
  final String pickup;
  final int passengers;
  final String service;
  final String serviceid;
  UserSignUp({
    this.id = '',
    required this.name,
    required this.cnic,
    required this.amount,
    required this.date,
    required this.email,
    required this.destination,
    required this.pickup,
    required this.passengers,
    required this.service,
    required this.serviceid,
  });
  Map<String, dynamic> toJson() => {
  'id': id,
  'name': name,
  'cnic': cnic,
  'amount':amount,
  'date': date,
  'email': email,
  'destination': destination,
  'pickup': pickup,
  'passengers': passengers,
  'service': service,
  'serviceid': serviceid,
  };
static UserSignUp fromJson(Map<String, dynamic> json) => UserSignUp(
  cnic: json['cnic'],
  amount: json['amount'],
  date: json['date'],// as Timestamp).toData(),
  destination: json['destination'],
  email: json['email'],
  id: json['id'],
  name: json['name'],
  passengers: json['passengers'],
  pickup: json['pickup'],
  service: json['service'],
  serviceid: json['serviceid'],
);
}
Future createUser(UserSignUp user) async{
  final docUser = FirebaseFirestore.instance.collection('normalusers').doc();
  user.id = docUser.id;
  final json = user.toJson();
  await docUser.set(json);
  }
class LoginOrSignUp extends StatefulWidget {
  LoginOrSignUp({Key? key}) : super(key: key);
  @override
  _LoginOrSignUpState createState() => _LoginOrSignUpState();
}
class _LoginOrSignUpState extends State<LoginOrSignUp> {
  bool login = true;
  @override
  Widget build(BuildContext context) =>
      login ? Login(onClickSignup: toggle) : SignUp(onClickSignup: toggle);
  void toggle() => setState(() => login = !login);
}

class DefaultFirebaseOptions {
}
