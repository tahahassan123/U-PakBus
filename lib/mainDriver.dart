import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'menu.dart';
import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('tickets').get();
  runApp(MaterialApp(
    title: "LoginPage",
    home: Driver(),
  ));
}

class Driver extends StatefulWidget {
  late var myID;
  Driver({Key? key, @required this.myID}) : super(key: key);
  @override
  _DriverState createState() => _DriverState(myID);
}
class _DriverState extends State<Driver> {
  String myID;
  _DriverState(this.myID);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Universal Driver'),
          centerTitle: true,
          backgroundColor: Colors.green[800],
          actions: [
            PopupMenuButton<MenuItem>(
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                ...MenuItems.items.map(buildItem).toList(),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('tickets').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/drivermainmenu21.jpeg'),
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(
                                Colors.greenAccent.withOpacity(0.9),
                                BlendMode.dstATop),
                          ),
                        ),
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> ticketMap = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                              if (myID == ticketMap['serviceid']) {
                                final Ticketno = ticketMap['ticketnum'];
                                final name = ticketMap['name'];
                                final date = ticketMap['date']; //now.toString();
                                final passenger = ticketMap['passengers'];
                                final selectedBus = ticketMap['busNumber'];
                                final selectedPickup = ticketMap['pickup'];
                                final selectedDestination = ticketMap['destination'];
                                return SingleChildScrollView(
                                  //scrollDirection: Axis.horizontal,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage('images/ticket4.jpg'),
                                            fit: BoxFit.cover,
                                            colorFilter: new ColorFilter.mode(
                                                Colors.greenAccent.withOpacity(0.9), BlendMode.dstATop),
                                          ),
                                        ),
                                        width: 400,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                          child: ClipRRect(
                                            //borderRadius: BorderRadius.circular(60),
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 10),
                                              child: SingleChildScrollView(
                                                child: ExpansionTile(
                                                  //backgroundColor: Colors.white,
                                                  children: [
                                                    Container(
                                                      width: 450,
                                                      height: 500,
                                                      child: Stack(children: [
                                                        Image.asset('images/ticket2.jpg',
                                                          fit: BoxFit.cover,
                                                          //opacity: const AlwaysStoppedAnimation(.8),
                                                        ),
                                                        SingleChildScrollView(
                                                          scrollDirection: Axis.horizontal,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.only(top: 30, bottom: 12, left: 12, right: 12),
                                                                child: Row(
                                                                    children: [
                                                                      Text('Holder: ',
                                                                        style: TextStyle(
                                                                            fontSize: 16,
                                                                            fontFamily: 'killedInk',
                                                                            fontWeight: FontWeight.bold,
                                                                            decoration: TextDecoration.underline
                                                                        ),
                                                                      ),
                                                                      Text(name,
                                                                        style: TextStyle(
                                                                            fontSize: 16,
                                                                            fontFamily: 'killedInk',
                                                                            fontWeight: FontWeight.bold
                                                                        ),
                                                                      ),
                                                                    ]),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
                                                                child: Row(
                                                                    children: [
                                                                      Text('Purchased On: ',
                                                                        style: TextStyle(
                                                                            fontSize: 16,
                                                                            fontFamily: 'killedInk',
                                                                            fontWeight: FontWeight.bold,
                                                                            decoration: TextDecoration.underline
                                                                        ),
                                                                      ),
                                                                      Text(date,
                                                                        style: TextStyle(
                                                                            fontSize: 16,
                                                                            fontFamily: 'killedInk',
                                                                            fontWeight: FontWeight.bold
                                                                        ),
                                                                      ),
                                                                    ]),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
                                                                child: Row(
                                                                    children: [
                                                                      Text('Pick Up: ',
                                                                        style: TextStyle(
                                                                            fontSize: 16,
                                                                            fontFamily: 'killedInk',
                                                                            fontWeight: FontWeight.bold,
                                                                            decoration: TextDecoration.underline),
                                                                      ),
                                                                      Text(
                                                                        selectedPickup,
                                                                        style: TextStyle(
                                                                            fontSize: 16,
                                                                            fontFamily: 'killedInk',
                                                                            fontWeight: FontWeight.bold
                                                                        ),
                                                                      ),
                                                                    ]),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
                                                                child: Row(
                                                                    children: [
                                                                      Text('Destination: ',
                                                                        style: TextStyle(
                                                                            fontSize: 16,
                                                                            fontFamily: 'killedInk',
                                                                            fontWeight: FontWeight.bold,
                                                                            decoration: TextDecoration.underline
                                                                        ),
                                                                      ),
                                                                      Text(selectedDestination,
                                                                        style: TextStyle(
                                                                            fontSize: 16,
                                                                            fontFamily: 'killedInk',
                                                                            fontWeight: FontWeight.bold
                                                                        ),
                                                                      ),
                                                                    ]),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
                                                                child: Row(
                                                                    children: [
                                                                      Text('Passengers: ',
                                                                        style: TextStyle(
                                                                            fontSize: 16,
                                                                            fontFamily: 'killedInk',
                                                                            fontWeight: FontWeight.bold,
                                                                            decoration: TextDecoration.underline
                                                                        ),
                                                                      ),
                                                                      Text('$passenger',
                                                                        style: TextStyle(
                                                                            fontSize: 16,
                                                                            fontFamily: 'killedInk',
                                                                            fontWeight:
                                                                            FontWeight.bold
                                                                        ),
                                                                      ),
                                                                    ]),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
                                                                child: Row(
                                                                    children: [
                                                                      Text('Bus No: ',
                                                                        style: TextStyle(
                                                                            fontSize: 16,
                                                                            fontFamily: 'killedInk',
                                                                            fontWeight:
                                                                            FontWeight.bold,
                                                                            decoration: TextDecoration.underline
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        selectedBus,
                                                                        style: TextStyle(
                                                                            fontSize: 16,
                                                                            fontFamily: 'killedInk',
                                                                            fontWeight:
                                                                            FontWeight.bold
                                                                        ),
                                                                      ),
                                                                    ]),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(left: 20),
                                                                child: Center(
                                                                  child: MaterialButton(
                                                                    onPressed: () async {
                                                                      setUsed(snapshot.data!.docs[index].id);
                                                                    },
                                                                    color: Colors.red,
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(15),
                                                                      //clipBehaviour: Clip.antiAliasWithSaveLayer,
                                                                    ),
                                                                    child: const Text('Set Used',
                                                                        style: TextStyle(
                                                                            fontSize: 18,
                                                                            color: Colors.white)
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ]),
                                                    ),
                                                  ],
                                                  //backgroundColor: Colors.green,
                                                  title: Padding(
                                                    padding: const EdgeInsets.only(left: 35),
                                                    child: Center(
                                                      child: Text(
                                                        'Ticket No: $Ticketno',
                                                        style: TextStyle(
                                                            fontSize: 22,
                                                            fontFamily: 'killedInk',
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text('No data found!'),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem(
        value: item,
        child: Text(item.text),
      );
  void onSelected(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.itemLogout:
        FirebaseAuth.instance.signOut();
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Main()), (_) => false);
        break;
    }
  }

  void setUsed(id) {
    FirebaseFirestore.instance.collection('tickets').doc(id).delete();
  }
}

class DefaultFirebaseOptions {}
