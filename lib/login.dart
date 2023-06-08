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

var signupemail,signupname,signupcnic,signuppassword;

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
                    image: AssetImage('images/login3.jpeg'),
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
                                        var collectionRef1=await FirebaseFirestore.instance;
                                        var useremailornot = collectionRef1.collection('normalusers');
                                        await useremailornot.doc(email).get().then((doc) {
                                          doc1 = doc.exists;
                                        });
                                      }
                                      catch(e)
                                      {
                                      }
                                      try {
                                        var collectionRef2=await FirebaseFirestore.instance;
                                        var driveremailornot = collectionRef2.collection('drivers');
                                        await driveremailornot.doc(email).get().then((doc) {
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
                                        print(cnic+" inside"+cnicfromdb);
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
                                        FirebaseAuth.instance.signOut();
                                        createsnackbar("cnic does not match with login credentials");

                                      }
                                    }
                                  });
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    createsnackbar("No user found for that email.");
                                  } else if (e.code == 'wrong-password') {
                                   createsnackbar("Wrong password provided for that user.");
                                  }
                                  else
                                    createsnackbar("something wrong");

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
  void createsnackbar(String e)
  {
    final snackBar = SnackBar(content: Text(e));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
bool checkingemailbool=false;
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
                    Padding(padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 120),
                      child: MaterialButton(
                        onPressed: () async {
                          signupname = oneController.text;
                          signupemail = twoController.text;
                          signupcnic = threeController.text;
                          signuppassword = fourController.text;

    try {
     checkingemailbool=false;
    var checkingemail = FirebaseFirestore.instance.collection('normalusers');
    await checkingemail.doc(signupemail).get().then((doc) {
    checkingemailbool = doc.exists;

    });
    } on Exception catch (e) {
    // make it explicit that this function can throw exceptions

    }



                            // showDialog(
                            //     context: context,
                            //   barrierDismissible: false,
                            //   builder: (context) => Center(child: CircularProgressIndicator(),),
                            // );

                            if(!checkingemailbool)
                            try{


                              await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: signupemail,
                                password: signuppassword,
                              );


                              final signupdb = FirebaseFirestore.instance;
                              final signupdata = { "cnic":signupcnic,"name": signupname};
                              signupdb.collection("normalusers").doc(signupemail).set(signupdata);
                            } on FirebaseAuthException catch (e) {
                              createsnackbar(e.toString());
                            }
                            else
                             createsnackbar("email already registered") ;
                            },
                            //navigatorKey.currentState!.popUntil((route) => route.isFirst);


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
  void createsnackbar(String e)
  {
    final snackBar = SnackBar(content: Text(e));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


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





