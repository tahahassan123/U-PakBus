import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pakistanbusapp/main.dart';
import 'package:pakistanbusapp/ticket.dart';
import 'mainDriver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'API.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripeAPI;
  await Firebase.initializeApp(
  );
  collectionref4=await FirebaseFirestore.instance;
  runApp(MaterialApp(
    title: "LoginPage",
    home: Main(),
  ));}

var signupemail,signupname,signupcnic,signuppassword,collectionref4;

class Main extends StatelessWidget{
  const Main({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          return LoginOrSignUp();
        }
    ),
  );
}

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
  bool passwordVisible = false;
  @override
  void initState(){
    super.initState();
    passwordVisible = true;
  }
  //async {}
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: double.infinity,
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
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: CircleAvatar(
                        backgroundColor: Colors.green[900],
                        radius: 100,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          backgroundImage: AssetImage('images/pp21.png'),
                          radius: 90,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          color: Colors.transparent,
                          child: Stack(
                            children: [
                              BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 8.5,
                                  sigmaY: 8.5,
                                ),
                                child: Container(),
                              ),
                              Column(
                                children: [
                                  Padding(padding: const EdgeInsets.all(15),
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
                                  Padding(padding: const EdgeInsets.all(15),
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
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  Padding(padding: const EdgeInsets.all(15),
                                    child: TextField(
                                      obscureText: passwordVisible,
                                      controller: threeController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: "Enter your Password",
                                        suffixIcon: IconButton(
                                          icon: Icon(passwordVisible? Icons.visibility: Icons.visibility_off),
                                          onPressed: () {
                                            setState(() {
                                              passwordVisible = !passwordVisible;
                                            });
                                          },
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30)
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: GestureDetector(
                                      child: Text("Forgot Password?", style: TextStyle(fontSize: 14.5,color: Colors.blue[500], decoration: TextDecoration.underline),),
                                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPassword())),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 100),
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(color: Colors.white),
                                          text: 'No account? ',
                                          children: [
                                            TextSpan(
                                              recognizer: TapGestureRecognizer()..onTap = widget.onClickSignup,
                                              style: TextStyle(color: Colors.green[600], decoration: TextDecoration.underline),
                                              text: 'Sign Up',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 115),
                      child: MaterialButton(
                        onPressed: () async {
                          bool boolcnicinticket=false;
                          var collectionref4;
                          var tamount,tdate,tdest,tid,tpassengers,tpickup,tserviceid,tbus,ticketnum;
                          doc1=false;
                          doc2=false;
                          cnicfromdb = " ";
                          namefromdb=" ";
                          servicefromdb=" ";
                          email = oneController.text;
                          cnic = twoController.text;
                          password = threeController.text;
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Center(child: CircularProgressIndicator(),);
                              }
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
                                  var collectionRef1=await FirebaseFirestore.instance;
                                  var useremailornot = collectionRef1.collection('normalusers');
                                  await useremailornot.doc(email).get().then((doc) {
                                    doc1 = doc.exists;
                                  });
                                }
                                catch(e) {
                                }
                                try {
                                  var collectionRef2=await FirebaseFirestore.instance;
                                  var driveremailornot = collectionRef2.collection('drivers');
                                  await driveremailornot.doc(email).get().then((doc) {
                                    doc2 = doc.exists;
                                  });
                                }
                                catch(e) {
                                }
                                if(doc1) {
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
                                  servicefromdb=snapshot.get("serviceid").toString();
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
                                    DocumentSnapshot snapshot2;
                                    var data=await FirebaseFirestore.instance.collection('drivers').doc(email).get();
                                    snapshot2=data;
                                    final myID = snapshot2.get("serviceid");
                                    // print("cnic: "+cnicfromdb+" name: "+namefromdb+" service: "+servicefromdb+" email: "+email);
                                    // print("cnic: "+cnicfromdb+" name: "+namefromdb+" service: "+servicefromdb+" email: "+email);
                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Driver(myID: myID)), (_) => false);
                                  }
                                  else if(doc1){
                                    // print("cnic: "+cnicfromdb+" name: "+namefromdb+" service: "+servicefromdb+" email: "+email);
                                    try {
                                      var collectionRef3=await FirebaseFirestore.instance;
                                      var cnicinticketsornot = collectionRef3.collection('tickets');
                                      await cnicinticketsornot.doc(cnicfromdb).get().then((doc) {
                                        boolcnicinticket = doc.exists;
                                      });
                                    }
                                    catch(e) {
                                    }
                                    if(boolcnicinticket){
                                      DocumentSnapshot snapshot;
                                      var ticketdata=await FirebaseFirestore.instance.collection('tickets').doc(cnicfromdb).get();
                                      snapshot=ticketdata;
                                      //tamount=snapshot.get("amount").toString();
                                      tdate=snapshot.get("date").toString();
                                      tdest=snapshot.get("destination").toString();
                                      //tid=snapshot.get("id").toString();
                                      tpassengers=snapshot.get("passengers").toString();
                                      tpickup=snapshot.get("pickup").toString();
                                      tserviceid=snapshot.get("serviceid").toString();
                                      tbus=snapshot.get("busNumber").toString();
                                      ticketnum=snapshot.get("ticketnum").toString();
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Ticket(email:email,cnicfromdb:cnicfromdb,namefromdb:namefromdb,tdate:tdate,tdest:tdest,tpickup:tpickup,tpassengers:tpassengers,tserviceid:tserviceid,tbus:tbus,ticketnum: ticketnum,)), (_) => false);
                                    }
                                    else
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainMenu(email:email,cnicfromdb:cnicfromdb,namefromdb:namefromdb)), (_) => false);
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
                          Navigator.of(context).pop();
                        },
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          //clipBehaviour: Clip.antiAliasWithSaveLayer,
                        ),
                        child: const Text('Log In', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                    Text(''),
                    Text(''),
                    Text(''),
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }
  void createsnackbar(String e) {
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
  bool passwordVisible = false;
  @override
  void initState(){
    super.initState();
    passwordVisible = true;
  }
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
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: CircleAvatar(
                        backgroundColor: Colors.green[900],
                        radius: 90,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          backgroundImage: AssetImage('images/pp21.png'),
                          radius: 80,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          color: Colors.transparent,
                          child: Stack(
                            children: [
                              BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 8.5,
                                    sigmaY: 8.5,
                                  ),
                                child: Container(),
                              ),
                              Column(
                                children: [
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
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  Padding(padding: const EdgeInsets.all(12),
                                    child: TextField(
                                      obscureText: passwordVisible,
                                      controller: fourController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: "Enter your Password",
                                        suffixIcon: IconButton(
                                          icon: Icon(passwordVisible? Icons.visibility: Icons.visibility_off),
                                          onPressed: () {
                                            setState(() {
                                              passwordVisible = !passwordVisible;
                                            });
                                          },
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30)
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 70),
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(color: Colors.white),
                                          text: 'Have an account? ',
                                          children: [
                                            TextSpan(
                                              recognizer: TapGestureRecognizer()..onTap = widget.onClickSignup,
                                              style: TextStyle(color: Colors.green[600], decoration: TextDecoration.underline),
                                              text: 'Login',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 105),
                      child: MaterialButton(
                        onPressed: () async {
                          signupname = oneController.text;
                          signupemail = twoController.text;
                          signupcnic = threeController.text;
                          signuppassword = fourController.text;
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Center(child: CircularProgressIndicator(),);
                              }
                          );
                          try {
                            checkingemailbool=false;
                            var checkingemail = FirebaseFirestore.instance.collection('normalusers');
                            await checkingemail.doc(signupemail).get().then((doc) {
                              checkingemailbool = doc.exists;
                            });
                          } on Exception catch (e) {
                            // make it explicit that this function can throw exceptions
                          }

                          if(!checkingemailbool && signupcnic.toString().length == 13)
                            try{
                              await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: signupemail,
                                password: signuppassword,
                              );
                              Navigator.of(context).pop();
                              final signupdb = FirebaseFirestore.instance;
                              final signupdata = { "cnic":signupcnic,"name": signupname};
                              signupdb.collection("normalusers").doc(signupemail).set(signupdata);
                              createsnackbar("Account Successfully created! You May now Login!");
                              oneController.clear();
                              twoController.clear();
                              threeController.clear();
                              fourController.clear();
                              display();
                            } on FirebaseAuthException catch (e) {
                              createsnackbar(e.toString());
                            }
                          else
                            createsnackbar("email already registered or CNIC invalid");
                        },
                        //navigatorKey.currentState!.popUntil((route) => route.isFirst);
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          //clipBehaviour: Clip.antiAliasWithSaveLayer,
                        ),
                        child: const Text('Sign Up', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                    Text(''),
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

  void display() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Main()), (_) => false);
    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));
    // String id=data["id"];
    // var amount2=(data["amount"]/100);
    //
    //final data2 = {"id":id,"name": "-", "passengers":passengers.text,"date": FieldValue.serverTimestamp(),"email":"-","amount":amount2,"service":bus,"pickup":pickup,"destination":destination};
    //db.collection(bus).doc("1").set(data2);
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

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool login = true;
  final resetController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.green[900],
        //   title: Text('Reset Your Password'),
        //   centerTitle: true,
        // ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/UPakBusFbackground.png'),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.9), BlendMode.dstATop),
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      controller: resetController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter your Email",
                        suffixIcon: IconButton(
                          onPressed: () {
                            resetController.clear();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {verifyEmail();},
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: const Text('Reset Password', style: TextStyle(color: Colors.white, fontSize: 15),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future verifyEmail() async{
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator(),),
    );
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: resetController.text.trim()
      );
      Navigator.of(context).pop((route) => route.isFirst);
      ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text("Reset Email Sent!"), duration: Duration(milliseconds: 1700), ), );
    } on FirebaseAuthException catch (e) {
      print(e);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text(e as String), duration: Duration(milliseconds: 1500), ), );
    }
    Navigator.of(context).pop();
  }
}

class DefaultFirebaseOptions {
}







