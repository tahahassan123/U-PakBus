import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'menu.dart';

class Ticket extends StatefulWidget {
  late var email,cnicfromdb,namefromdb,tamount,tdate,tdest,tid,tpassengers,tpickup,tserviceid,tbus,ticketnum;
  Ticket({Key? key,@required this.email,@required this.cnicfromdb,@required this.namefromdb,this.tamount,this.tdate,this.tdest,this.tid,this.tpassengers,this.tpickup,this.tserviceid,this.tbus,this.ticketnum}) : super(key: key);
  @override
  _TicketState createState() => _TicketState(email,cnicfromdb,namefromdb,tamount,tdate,tdest,tid,tpassengers,tpickup,tserviceid,tbus,ticketnum);
}

var selectedService = 'Peoples Bus'; //dummy data

void main() {
  const oneMinute = Duration(seconds: 2);
  Timer.periodic(oneMinute, (Timer t) {
    print("ali");
  });

  runApp(Ticket());}
class _TicketState extends State<Ticket> {
  String email,cnicfromdb,namefromdb,tamount,tdate,tdest,tid,tpassengers,tpickup,tserviceid,tbus,ticketnum;

  _TicketState(this.email,this.cnicfromdb,this.namefromdb,this.tamount,this.tdate,this.tdest,this.tid,this.tpassengers,this.tpickup,this.tserviceid,this.tbus,this.ticketnum);
  @override
  Widget build(BuildContext context) {
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
            image: DecorationImage(image: AssetImage('images/login31.jpeg'),
              fit: BoxFit.cover, colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.85), BlendMode.dstATop),
            ),
          ),
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
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
                  child: ClipRRect(
                    //borderRadius: BorderRadius.circular(50),
                    child: Padding(
                      padding: const EdgeInsets.only(top:10),
                      child: SingleChildScrollView(
                        child: ExpansionTile(
                          //backgroundColor: Colors.white,
                          children: [
                            Container(
                              width: 450,
                              height: 470,
                              child: Stack(
                                  children: [
                                    Image.asset('images/ticket2.jpg',
                                      fit: BoxFit.cover,
                                      //opacity: const AlwaysStoppedAnimation(.8),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                                      ],
                                    ),
                                  ]
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
              ),
            ],
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