import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'menu.dart';
import 'main.dart';

class Ticket extends StatefulWidget {
  late var tid,email,cnicfromdb,namefromdb,tdate,tdest,tpassengers,tpickup,tserviceid,tbus,ticketnum;
  Ticket({Key? key,@required this.tid,@required this.email,@required this.cnicfromdb,@required this.namefromdb,this.tdate,this.tdest,this.tpassengers,this.tpickup,this.tserviceid,this.tbus,this.ticketnum}) : super(key: key);
  @override
  _TicketState createState() => _TicketState(tid,email,cnicfromdb,namefromdb,tdate,tdest,tpassengers,tpickup,tserviceid,tbus,ticketnum);
}

var selectedService;

void main() {
  runApp(Ticket());
}

class _TicketState extends State<Ticket> {
  bool isticketused=false;
  late Timer timer;
  Future<void> checkticketused() async {
    try {
      var collectionRef3=await FirebaseFirestore.instance;
      var cnicinticketsornot = collectionRef3.collection('tickets');
      await cnicinticketsornot.doc(cnicfromdb).get().then((doc) {
        isticketused = doc.exists;
        print("Used:"+isticketused.toString());
      });
    }
    catch(e) {
    }
    if(isticketused) {
      //dispose();
    }
    else {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) =>
              MainMenu(email: email,
                  cnicfromdb: cnicfromdb,
                  namefromdb: namefromdb)), (_) => false);
    }
  }
  @override
  void initState() {
    super.initState();
    checkticketused();
    timer = Timer.periodic(Duration(seconds: 1), (_) => checkticketused());
  }
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  String tid,email,cnicfromdb,namefromdb,tdate,tdest,tpassengers,tpickup,tserviceid,tbus,ticketnum;
  String serviceImage = 'images/login31.jpeg';
  _TicketState(this.tid,this.email,this.cnicfromdb,this.namefromdb,this.tdate,this.tdest,this.tpassengers,this.tpickup,this.tserviceid,this.tbus,this.ticketnum);
  @override
  Widget build(BuildContext context) {
    if (tserviceid == '1'){
      serviceImage = 'images/peoplesbus.jpg';
      selectedService = 'Peoples Bus';
    }
    else if (tserviceid == '2'){
      serviceImage = 'images/evbus.jpg';
      selectedService = 'EV Bus';
    }
    else if (tserviceid == '3'){
      serviceImage = 'images/login31.jpeg';
      selectedService = 'Greenline Metro';
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('Your Ticket'),
            centerTitle: true,
            backgroundColor: Colors.green[900],
            actions: [
              PopupMenuButton<MenuItem>(
                onSelected: (item) => onSelected(context, item),
                itemBuilder: (context) => [
                  ...MenuItems.items.map(buildItem).toList(),
                ],
              ),
            ]
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(serviceImage),
              fit: BoxFit.cover, colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.75), BlendMode.dstATop),
            ),
          ),
          height: 1000,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment:MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/ticket4.jpg'),
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.greenAccent.withOpacity(0.87), BlendMode.dstATop),
                      ),
                    ),
                    width: 550,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                      child: Padding(
                        padding: const EdgeInsets.only(top:10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: ExpansionTile(
                            children: [
                              Container(
                                height: 600,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 500,
                                        height: 600,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Stack(
                                                  children: [
                                                    Image.asset('images/ticket21.jpg',
                                                      fit: BoxFit.cover,
                                                      //opacity: const AlwaysStoppedAnimation(.8),
                                                    ),
                                                    Container(
                                                      width: 500,
                                                      height: 600,
                                                      child: SingleChildScrollView(
                                                        scrollDirection: Axis.horizontal,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 30, bottom: 12, left: 12, right: 12),
                                                              child: Row(
                                                                  children: [
                                                                    Text('Holder: ',
                                                                      style: TextStyle(fontSize: 16, fontFamily: 'killedInk', fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                                                                    ),
                                                                    Text( namefromdb,
                                                                      style: TextStyle(fontSize: 16, fontFamily: 'killedInk', fontWeight: FontWeight.bold),
                                                                    ),
                                                                  ]
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
                                                              child: Row(
                                                                  children: [
                                                                    Text('Purchased On: ',
                                                                      style: TextStyle(fontSize: 16, fontFamily: 'killedInk', fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                                                                    ),
                                                                    Text( tdate,
                                                                      style: TextStyle(fontSize: 16, fontFamily: 'killedInk', fontWeight: FontWeight.bold),
                                                                    ),
                                                                  ]
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
                                                              child: Row(
                                                                  children: [
                                                                    Text('Pick Up: ',
                                                                      style: TextStyle(fontSize: 16, fontFamily: 'killedInk', fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                                                                    ),
                                                                    Text( tpickup,
                                                                      style: TextStyle(fontSize: 16, fontFamily: 'killedInk', fontWeight: FontWeight.bold),
                                                                    ),
                                                                  ]
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
                                                              child: Row(
                                                                  children: [
                                                                    Text('Destination: ',
                                                                      style: TextStyle(fontSize: 16, fontFamily: 'killedInk', fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                                                                    ),
                                                                    Text( tdest,
                                                                      style: TextStyle(fontSize: 16, fontFamily: 'killedInk', fontWeight: FontWeight.bold),
                                                                    ),
                                                                  ]
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
                                                              child: Row(
                                                                  children: [
                                                                    Text('Passengers: ',
                                                                      style: TextStyle(fontSize: 16, fontFamily: 'killedInk', fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                                                                    ),
                                                                    Text( '$tpassengers',
                                                                      style: TextStyle(fontSize: 16, fontFamily: 'killedInk', fontWeight: FontWeight.bold),
                                                                    ),
                                                                  ]
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
                                                              child: Row(
                                                                  children: [
                                                                    Text('Service: ',
                                                                      style: TextStyle(fontSize: 16, fontFamily: 'killedInk', fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                                                                    ),
                                                                    Text( selectedService,
                                                                      style: TextStyle(fontSize: 16, fontFamily: 'killedInk', fontWeight: FontWeight.bold),
                                                                    ),
                                                                  ]
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
                                                              child: Row(
                                                                  children: [
                                                                    Text('Bus No: ',
                                                                      style: TextStyle(fontSize: 16, fontFamily: 'killedInk', fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                                                                    ),
                                                                    Text( tbus,
                                                                      style: TextStyle(fontSize: 16, fontFamily: 'killedInk', fontWeight: FontWeight.bold),
                                                                    ),
                                                                  ]
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
                                                              child: Row(
                                                                  children: [
                                                                    Text('Payment ID: ',
                                                                      style: TextStyle(fontSize: 16, fontFamily: 'killedInk', fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                                                                    ),
                                                                    Text( tid,
                                                                      style: TextStyle(fontSize: 16, fontFamily: 'killedInk', fontWeight: FontWeight.bold),
                                                                    ),
                                                                  ]
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ]
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            //backgroundColor: Colors.green,
                            title: Padding(
                              padding: const EdgeInsets.only(left: 35),
                              child: Center(
                                child: Text('Ticket No: $ticketnum',
                                  style: TextStyle(fontSize: 22, fontFamily: 'killedInk', fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(''),
                  Text(''),
                  Text(''),
                  Text(''),
                ],
              ),
            ),
          ),
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
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Main()), (_) => false);
        break;
    }
  }
}