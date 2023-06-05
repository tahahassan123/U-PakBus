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
  String selectedService = "Select Service";
  final service = {'Select Service': 'a','PeoplesBus': 'c', 'EV Bus': 'f', 'Greenline Metro Bus': 'g'};
  List Service = [];
  ServiceDropdown(){
    service.forEach((key, value) {
      Service.add(key);
    });
  }
  String selectedBus = "";
  final bus = {'Select Bus Number': 'dw','ff': 'tt', 'fd': 'gt', 'rt': 'c'};
  List Bus = [];
  BusDropdown(serviceID){
    bus.forEach((key, value) {
      if (serviceID == value){
        Bus.add(key);
      }
      selectedBus = Bus[0];
    });
  }
  @override
  void initState(){
    super.initState();
    ServiceDropdown();
    //BusDropdown(0);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
           child: Column(
               crossAxisAlignment: CrossAxisAlignment.stretch,
               children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 62),
                   child: DropdownButton(
                     value: selectedService,
                     onChanged: (newValue) {
                       setState((){
                         BusDropdown(Service[newValue]);
                         selectedService = '$newValue';
                       });},
                     items: Service.map((service) {
                       return DropdownMenuItem(
                         child: new Text(service),
                         value: service,
                       );
                     }).toList(),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 120,),
                   child: DropdownButton(
                     value: selectedBus,
                     onChanged: (newValue) {
                       setState((){

                         selectedBus = '$newValue';
                       });},
                     items: Bus.map((bus) {
                       return DropdownMenuItem(
                         child: new Text(bus),
                         value: bus,
                       );
                     }).toList(),
                   ),
                 ),
               ]
           ),
         ),
       ),
      ),
    );
  }
}