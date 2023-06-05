import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainMenu());
}
class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);
  @override
  _MainMenuState createState() => _MainMenuState();
}
class _MainMenuState extends State<MainMenu> {
  String selectedService="Select Service";
  final service={'Select Service': 0,'Peoples Bus': 1, 'EV Bus': 2,'Greenline Metro': 3};
  List Service=[];
  ServiceDropDown(){
    service.forEach((key, value) {
      Service.add(key);
    });
  }
  String selectedBus="Select Bus";
  final bus={'Select Bus': 0, 'R-1': 1, 'R-2': 1,'R-3': 1, 'R-4': 1};
  List Bus=[];
  BusDropDown(serviceID){
    bus.forEach((key, value) {
      if(serviceID==value){
        Bus.add(key);
      }
    });
    selectedBus= Bus[0];
  }
  String selectedPickup="";
  final pickup={
    'Model Mor': 'R-1', 'Malir Halt': 'R-1', 'Colony Gate': 'R-1', 'Nata Khan Bridge': 'R-1', 'Drigh Road Station': 'R-1', 'PAF Base Faisal': 'R-1', 'Laal Kothi': 'R-1', 'Karsaz': 'R-1', 'Nursery': 'R-1', 'FTC': 'R-1', 'Regent Plaza': 'R-1', 'Metropole': 'R-1', 'Fawwara Chowk': 'R-1', 'Arts Council': 'R-1', 'Shaheen Complex': 'R-1', 'I.I.Chundrigar': 'R-1', 'Tower': 'R-1', 'Fisheries': 'R-1','Dockyard': 'R-1',
    'Nagan Chowrangi' : 'R-2', 'Shafiq Morr' : 'R-2', 'Sohrab Goth' : 'R-2', 'Gulshan Chowranei' : 'R-2', 'NIPA': 'R-2', 'Johar Morr': 'R-2', 'COD': 'R-2', 'Drigh Road Station': 'R-2', 'Colony Gate': 'R-2', 'Shah Faisal Colony': 'R-2', 'Singer Chowrangi': 'R-2', 'Landhi Road': 'R-2'
  };
  List Pickup=[];
  PickupDropDown(busNumber){
    pickup.forEach((key, value) {
      if(busNumber==value){
        Pickup.add(key);
      }
    });
    selectedPickup= Pickup[0];
  }
  String selectedDestination="";
  final destination={
  'Nagan Chowrangi' : 'R-2', 'Shafiq Morr' : 'R-2', 'Sohrab Goth' : 'R-2', 'Gulshan Chowranei' : 'R-2', 'NIPA': 'R-2', 'Johar Morr': 'R-2', 'COD': 'R-2', 'Drigh Road Station': 'R-2', 'Colony Gate': 'R-2', 'Shah Faisal Colony': 'R-2', 'Singer Chowrangi': 'R-2', 'Landhi Road': 'R-2',
  'Model Mor': 'R-1', 'Malir Halt': 'R-1', 'Colony Gate': 'R-1', 'Nata Khan Bridge': 'R-1', 'Drigh Road Station': 'R-1', 'PAF Base Faisal': 'R-1', 'Laal Kothi': 'R-1', 'Karsaz': 'R-1', 'Nursery': 'R-1', 'FTC': 'R-1', 'Regent Plaza': 'R-1', 'Metropole': 'R-1', 'Fawwara Chowk': 'R-1', 'Arts Council': 'R-1', 'Shaheen Complex': 'R-1', 'I.I.Chundrigar': 'R-1', 'Tower': 'R-1', 'Fisheries': 'R-1','Dockyard': 'R-1',
  };
  List Destination=[];
  DestinationDropDown(busNumber2){
    pickup.forEach((key, value) {
      if(busNumber2==value){
        Destination.add(key);
      }
    });
    selectedDestination= Destination[0];
  }
  @override
  void initState() {
    super.initState();
    ServiceDropDown();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Universal Pak Bus',),
          backgroundColor: Colors.green[800],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/mainmenu2.jpg'),
              fit: BoxFit.cover, colorFilter: new ColorFilter.mode(Colors.green.withOpacity(0.3), BlendMode.dstATop),
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            reverse: false,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 23,),
                  Row(
                    children: [
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child:Text("Service",  style: TextStyle(fontWeight:FontWeight.bold,fontSize: 18),),
                          ),
                          Container(
                            width: 200,
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2,),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.green, width: 4),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              value: selectedService,
                              onChanged: (newValue){
                                setState(() {
                                  Destination=[];
                                  Pickup=[];
                                  Bus=[];
                                  BusDropDown(service[newValue]);
                                  selectedService="$newValue";
                                  print(selectedService);
                                });
                              },
                              items: Service.map((service){
                                return DropdownMenuItem(
                                  child: new Text(service),
                                  value:service,
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 15,),
                      Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child:Text("Bus Number", style: TextStyle(fontWeight:FontWeight.bold,fontSize: 18),)
                          ),
                          Container(
                            width: 170,
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2,),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.green, width: 4),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              value: selectedBus,
                              onChanged: (newValue){
                                print(newValue);
                                setState(() {
                                  print(newValue);
                                  Pickup=[];
                                  Destination=[];
                                  PickupDropDown(newValue);
                                  DestinationDropDown(newValue);
                                  selectedBus="$newValue";
                                });
                              },
                              items:Bus.map((bus){
                                return DropdownMenuItem(
                                  child: new Text(bus),
                                  value:bus,
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 50,),
                  Row(
                    children: [
                      Column(
                        children: [
                          Align(
                              alignment: Alignment.bottomLeft,
                              child:Text("Pickup At", style: TextStyle(fontWeight:FontWeight.bold,fontSize: 18),)
                          ),
                          Container(
                            width: 180,
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2,),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.green, width: 4),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              value: selectedPickup,
                              onChanged: (newValue){
                                setState(() {
                                  selectedPickup="$newValue";
                                });
                              },
                              items:Pickup.map((pickup){
                                return DropdownMenuItem(
                                  child: new Text(pickup),
                                  value:pickup,
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 30,
                        height: 25,
                        child: Center(child: Text("To", style: TextStyle(fontSize: 15,),)),
                      ),
                      Column(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child:Text("Destination", style: TextStyle(fontWeight:FontWeight.bold,fontSize: 18),)
                          ),
                          Container(
                            width: 180,
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2,),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.green, width: 4),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              value: selectedDestination,
                              onChanged: (newValue){
                                setState(() {
                                  selectedDestination="$newValue";
                                });
                              },
                              items:Destination.map((destination){
                                return DropdownMenuItem(
                                  child: new Text(destination),
                                  value:destination,
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          debugPrint('The image button has been tapped');
                        },
                        child: SizedBox(
                          width: 100,
                          height: 50,
                          child: Image.asset('images/button2.png',),
                        ),
                      ),
                    ],
                  ),
                ]
            ),
          ),
        ),
      ),
    );
  }
}