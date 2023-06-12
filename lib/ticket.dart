import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Ticket extends StatefulWidget {
  const Ticket({Key? key}) : super(key: key);
  @override
  _TicketState createState() => _TicketState();
}
var Ticketno = 0400;
var name = 'Taha Hassan';
var date = '01/02/2023';
var passenger = 0;
var selectedService = 'Peoples Bus';
var selectedBus = 'R-1';
var selectedPickup = 'Qaidabad';
var selectedDestination = 'Johur';

void main(){runApp(Ticket());}
class _TicketState extends State<Ticket> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Your Ticket'),
          centerTitle: true,
          backgroundColor: Colors.green[900],
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
                                height: 450,
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
                                                  Text( name,
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
                                                  Text( date,
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
                                                  Text( selectedPickup,
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
                                                  Text( selectedDestination,
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
                                                  Text( '$passenger',
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
                                                  Text( selectedBus,
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
                                child: Text('Ticket No: $Ticketno',
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
}