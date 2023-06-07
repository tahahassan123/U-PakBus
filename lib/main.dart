import 'dart:ffi';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';






void main() => runApp(
    MaterialApp(
      title: "UserPage",
      home: MainMenu(),
    ));
class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);
  @override
  _MainMenuState createState() => _MainMenuState();
}

var data,serviceid;
class _MainMenuState extends State<MainMenu> {
  Map<String, dynamic>? paymentIntent;
  final passengerController = TextEditingController();
  var passenger = 0;
  var error = '';
  String selectedService= 'Select Service';
  String busImage = 'images/UPakBuslogo.png';
  final service={'Select Service': 0,'Peoples Bus': 1, 'EV Bus': 2,'Greenline Metro': 3};
  List Service=[];
  ServiceDropDown(){
    service.forEach((key, value) {
      Service.add(key);
    });
  }
  String selectedBus= '';
  String routeImage = 'images/pakistan.jpg';
  double routeHeight = 250;
  final bus={'R-1': 1, 'R-2': 1,'R-3': 1, 'R-4': 1, 'EV-1': 2, 'EV-2': 2, 'BRT': 3};
  List Bus=[];
  BusDropDown(serviceID){
    bus.forEach((key, value) {
      if(serviceID==value){
        Bus.add(key);
      }
    });
    selectedBus= Bus[0];
  }
  String selectedPickup= '';
  final pickup={
    'Model Mor': 'R-1', 'Malir Halt': 'R-1', 'Colony Gate': 'R-1', 'Nata Khan Bridge': 'R-1', 'Drigh Road Station': 'R-1', 'PAF Base Faisal': 'R-1', 'Laal Kothi': 'R-1', 'Karsaz': 'R-1', 'Nursery': 'R-1', 'FTC': 'R-1', 'Regent Plaza': 'R-1', 'Metropole': 'R-1', 'Fawwara Chowk': 'R-1', 'Arts Council': 'R-1', 'Shaheen Complex': 'R-1', 'I.I.Chundrigar': 'R-1', 'Tower': 'R-1', 'Fisheries': 'R-1','Dockyard': 'R-1',
    'Nagan Chowrangi' : 'R-2', 'Shafiq Morr' : 'R-2', 'Sohrab Goth' : 'R-2', 'Gulshan Chowranei' : 'R-2', 'NIPA': 'R-2', 'Johar Morr': 'R-2', 'COD': 'R-2', 'Drigh Road Station': 'R-2', 'Colony Gate': 'R-2', 'Shah Faisal Colony': 'R-2', 'Singer Chowrangi': 'R-2', 'Landhi Road': 'R-2',
    'Power House': 'R-3', 'UP More': 'R-3', 'Nagan Chowrangi': 'R-3', 'Sakhi Hasan': 'R-3', '5 Star Chowrangi': 'R-3', 'KDA Chowrangi': 'R-3', 'Nazimabad Eid Gah Ground': 'R-3', 'Liaquatabad 10 Number': 'R-3', 'Essa Nagri': 'R-3', 'Civic Centre': 'R-3', 'National stadium': 'R-3', 'Karsaz': 'R-3', 'Nursery': 'R-3', 'FTC': 'R-3', 'Korangi Road': 'R-3', 'KPT Interchange': 'R-3', 'Shan Chowrangi': 'R-3',
    'Power House': 'R-4', 'UP Mor': 'R-4', 'Nagan Chowrangi': 'R-4', 'Shafiq Mor': 'R-4', 'Sohrab Goth': 'R-4', 'Shahrah e Pakistan': 'R-4', 'Ayesha Manzil': 'R-4','Liaqautabad 10': 'R-4', 'Laloo Khait': 'R-4', 'Teen Hati': 'R-4', 'Jehangir Road': 'R-4', 'Numaish': 'R-4', 'Mobile Market': 'R-4', 'Urdu Bazar': 'R-4', 'Civil Hospital': 'R-4', 'City Court': 'R-4', 'Light House': 'R-4', 'Bolton Market': 'R-4', 'Tower': 'R-4',
    'Tank Chowk': 'EV-1', 'Model Colony Mor': 'EV-1', 'Jinnah Ave': 'EV-1', 'Airport': 'EV-1', 'Colony Gate': 'EV-1', 'Nata Khan Bridge': 'EV-1', 'Drigh Road Station': 'EV-1', 'PAF Base Faisal': 'EV-1', 'Laal Kothi': 'EV-1', 'Karsaz': 'EV-1', 'Nursery': 'EV-1', 'FTC': 'EV-1', 'Korangi Road': 'EV-1', 'DHA Phase 1': 'EV-1', 'Masjid e Ayesha': 'EV-1', 'Clock Tower DHA': 'EV-1',
    'Bahria Town': 'EV-2', 'Damba Goth': 'EV-2', 'Toll Plaza': 'EV-2', 'Baqai University': 'EV-2', 'Malir Cantt Gate 5': 'EV-2', 'Malir Cantt Gate 6': 'EV-2', 'Tank Chowk': 'EV-2', 'Model Mor': 'EV-2', 'Jinnah Ave': 'EV-2', 'Malir Halt': 'EV-2',
    'Numaish Chowrangi': 'BRT', 'Patel Para (Guru Mandir) Station': 'BRT', 'Lasbela Chowk Station': 'BRT', 'Sanitary Market (Gulbahar) Station': 'BRT', 'Nazimabad No.1 Station': 'BRT', 'Enquiry Office Station': 'BRT', 'Annu Bhai Park Station': 'BRT', 'Board Office Station (to Orange Line)': 'BRT', 'Hyderi Station': 'BRT', 'Five Star Chowrangi Station': 'BRT', 'Jummah Bazaar (Bayani Center) Station': 'BRT', 'Erum Shopping Mall (Shadman No.2) Station': 'BRT', 'Nagan Chowrangi Station': 'BRT', 'U.P. More Station': 'BRT', 'Road 4200 (Saleem Center) Station': 'BRT', 'Power House Chowrangi Station': 'BRT', 'Road 2400 (Aisha Complex) Station': 'BRT', '2 Minute Chowrangi Station': 'BRT', 'Surjani Chowrangi (4K) Station': 'BRT', 'Karimi Chowrangi Station': 'BRT', 'KDA Flats Station': 'BRT', 'Abdullah Chowk Station': 'BRT',
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
    'Model Mor': 'R-1', 'Malir Halt': 'R-1', 'Colony Gate': 'R-1', 'Nata Khan Bridge': 'R-1', 'Drigh Road Station': 'R-1', 'PAF Base Faisal': 'R-1', 'Laal Kothi': 'R-1', 'Karsaz': 'R-1', 'Nursery': 'R-1', 'FTC': 'R-1', 'Regent Plaza': 'R-1', 'Metropole': 'R-1', 'Fawwara Chowk': 'R-1', 'Arts Council': 'R-1', 'Shaheen Complex': 'R-1', 'I.I.Chundrigar': 'R-1', 'Tower': 'R-1', 'Fisheries': 'R-1','Dockyard': 'R-1',
    'Nagan Chowrangi' : 'R-2', 'Shafiq Morr' : 'R-2', 'Sohrab Goth' : 'R-2', 'Gulshan Chowranei' : 'R-2', 'NIPA': 'R-2', 'Johar Morr': 'R-2', 'COD': 'R-2', 'Drigh Road Station': 'R-2', 'Colony Gate': 'R-2', 'Shah Faisal Colony': 'R-2', 'Singer Chowrangi': 'R-2', 'Landhi Road': 'R-2',
    'Power House': 'R-3', 'UP More': 'R-3', 'Nagan Chowrangi': 'R-3', 'Sakhi Hasan': 'R-3', '5 Star Chowrangi': 'R-3', 'KDA Chowrangi': 'R-3', 'Nazimabad Eid Gah Ground': 'R-3', 'Liaquatabad 10 Number': 'R-3', 'Essa Nagri': 'R-3', 'Civic Centre': 'R-3', 'National stadium': 'R-3', 'Karsaz': 'R-3', 'Nursery': 'R-3', 'FTC': 'R-3', 'Korangi Road': 'R-3', 'KPT Interchange': 'R-3', 'Shan Chowrangi': 'R-3',
    'Power House': 'R-4', 'UP Mor': 'R-4', 'Nagan Chowrangi': 'R-4', 'Shafiq Mor': 'R-4', 'Sohrab Goth': 'R-4', 'Shahrah e Pakistan': 'R-4', 'Ayesha Manzil': 'R-4','Liaqautabad 10': 'R-4', 'Laloo Khait': 'R-4', 'Teen Hati': 'R-4', 'Jehangir Road': 'R-4', 'Numaish': 'R-4', 'Mobile Market': 'R-4', 'Urdu Bazar': 'R-4', 'Civil Hospital': 'R-4', 'City Court': 'R-4', 'Light House': 'R-4', 'Bolton Market': 'R-4', 'Tower': 'R-4',
    'Tank Chowk': 'EV-1', 'Model Colony Mor': 'EV-1', 'Jinnah Ave': 'EV-1', 'Airport': 'EV-1', 'Colony Gate': 'EV-1', 'Nata Khan Bridge': 'EV-1', 'Drigh Road Station': 'EV-1', 'PAF Base Faisal': 'EV-1', 'Laal Kothi': 'EV-1', 'Karsaz': 'EV-1', 'Nursery': 'EV-1', 'FTC': 'EV-1', 'Korangi Road': 'EV-1', 'DHA Phase 1': 'EV-1', 'Masjid e Ayesha': 'EV-1', 'Clock Tower DHA': 'EV-1',
    'Bahria Town': 'EV-2', 'Damba Goth': 'EV-2', 'Toll Plaza': 'EV-2', 'Baqai University': 'EV-2', 'Malir Cantt Gate 5': 'EV-2', 'Malir Cantt Gate 6': 'EV-2', 'Tank Chowk': 'EV-2', 'Model Mor': 'EV-2', 'Jinnah Ave': 'EV-2', 'Malir Halt': 'EV-2',
    'Numaish Chowrangi': 'BRT', 'Patel Para (Guru Mandir) Station': 'BRT', 'Lasbela Chowk Station': 'BRT', 'Sanitary Market (Gulbahar) Station': 'BRT', 'Nazimabad No.1 Station': 'BRT', 'Enquiry Office Station': 'BRT', 'Annu Bhai Park Station': 'BRT', 'Board Office Station (to Orange Line)': 'BRT', 'Hyderi Station': 'BRT', 'Five Star Chowrangi Station': 'BRT', 'Jummah Bazaar (Bayani Center) Station': 'BRT', 'Erum Shopping Mall (Shadman No.2) Station': 'BRT', 'Nagan Chowrangi Station': 'BRT', 'U.P. More Station': 'BRT', 'Road 4200 (Saleem Center) Station': 'BRT', 'Power House Chowrangi Station': 'BRT', 'Road 2400 (Aisha Complex) Station': 'BRT', '2 Minute Chowrangi Station': 'BRT', 'Surjani Chowrangi (4K) Station': 'BRT', 'Karimi Chowrangi Station': 'BRT', 'KDA Flats Station': 'BRT', 'Abdullah Chowk Station': 'BRT',
  };
  List Destination=[];
  DestinationDropDown(busNumber){
    pickup.forEach((key, value) {
      if(busNumber==value){
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
                                  if (newValue == 'Peoples Bus'){
                                    busImage = 'images/peoplesbus.jpg';
                                  };
                                  if (newValue == 'EV Bus'){
                                    busImage = 'images/evbus.jpg';
                                  };
                                  if (newValue == 'Greenline Metro'){
                                    busImage = 'images/greenline.jpg';
                                  };
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
                            width: 155,
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
                                  if (newValue == 'R-1'){
                                    routeImage = 'images/r1.jpg';
                                  };
                                  if (newValue == 'R-2'){
                                    routeImage = 'images/r2.jpg';
                                    routeHeight = 450;
                                  }
                                  else{
                                    routeHeight = 250;
                                  }
                                  if (newValue == 'BRT'){
                                    routeImage = 'images/brt.jpg';
                                  }
                                  else{
                                    if (newValue == 'R-3' || newValue == 'R-4'|| newValue == 'EV-1'|| newValue == 'EV-2'){
                                      routeImage = 'images/peoples_ev_routes.jpg';
                                    }
                                  }
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
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Container(
                        width: 100,
                        height: 220,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 4),
                            borderRadius: BorderRadius.circular(7)
                        ),
                        child: Image.asset(busImage ,
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Align(
                              alignment: Alignment.bottomLeft,
                              child:Text("Pickup At", style: TextStyle(fontWeight:FontWeight.bold,fontSize: 18),)
                          ),
                          Container(
                            width: 175,
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2,),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.green, width: 4),
                                borderRadius: BorderRadius.circular(25)
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
                        width: 20,
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
                            width: 175,
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2,),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.green, width: 4),
                                borderRadius: BorderRadius.circular(25)
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
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Container(
                        width: 100,
                        height: routeHeight,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 4),
                            borderRadius: BorderRadius.circular(7)
                        ),
                        child: Image.asset(routeImage ,
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: passengerController,
                      decoration: InputDecoration(
                        filled: false,
                        fillColor: Colors.white,
                        hintText: "Enter amount of passengers",
                        suffixIcon: IconButton(
                          onPressed: () {
                            passengerController.clear();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 4),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(child: Text(error, style: TextStyle(fontSize: 12, color: Colors.red,),)),
                      ),
                      GestureDetector(
                        onTap: () {
                          passenger = int.parse(passengerController.text);
                          if (selectedService != null || selectedBus != null || selectedPickup != null || selectedDestination != null || passenger != 0){

                            //Navigator.of(context).push(MaterialPageRoute( builder: (context) => HomeScreen2(passenger: passenger,),));

                            if(selectedService=='Peoples Bus')
                              serviceid=1;
                            if(selectedService=='EV Bus')
                              serviceid=2;
                            if(selectedService=='Greenline Metro')
                              serviceid=3;



                            makePayment();
                          }//passenger: passenger
                          else{
                            if (selectedPickup == selectedDestination){
                              error = "";
                              var snackBar = SnackBar(content: Text('Pickup and destination cannot be same!'));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                            else{
                              error = "Please complete all fields!";
                              var snackBar = SnackBar(content: Text('Please complete all fields!'));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          }
                        },
                        child: SizedBox(
                          width: 100,
                          height: 50,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Image.asset('images/button2.png'),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Center(child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 15),)),
                                  ),
                                ],
                              ),
                            ],
                          ),
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

  Future<void> makePayment() async {
    try {
      // WidgetsFlutterBinding.ensureInitialized();
      // Stripe.publishableKey = 'pk_test_51NCzkJI3GjRc0k0GRc5SfTIoeaHzyaYirzzindw9IkPdbw7la71lCzcx26PDJw4LPhajCk9zqrjarb2Hhxdq5t0D00QNf1VOpH';
      int totalamount=((50000*passenger));
      String totalamountstring=totalamount.toString();
      paymentIntent = await createPaymentIntent(totalamountstring, 'PKR');
      //Payment Sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
              // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
              style: ThemeMode.dark,
              merchantDisplayName: 'Adnan')).then((value) {});

      ///now finally display payment sheet









      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }
  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet(
      ).then((value) async {
        showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.check_circle, color: Colors.green,),
                          Text("Payment Successfull"),
                        ],
                      ),
                    ],
                  ),
                ));
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));
        paymentIntent = null;

        // String id=data["id"];
        // var amount2=(data["amount"]/100);
        //

        //final data2 = {"id":id,"name": "-", "passengers":passengers.text,"date": FieldValue.serverTimestamp(),"email":"-","amount":amount2,"service":bus,"pickup":pickup,"destination":destination};
        //db.collection(bus).doc("1").set(data2);
        var id=data["id"];
        var amount2=(data["amount"]/100);
        final db = FirebaseFirestore.instance;
        final data2 = {"id":id,"name": "-", "passengers":passenger,"date": FieldValue.serverTimestamp(),"email":"-","amount":amount2,"service":selectedService,"pickup":selectedPickup,"destination":selectedDestination,"serviceid":serviceid.toString()};
        db.collection("tickets").doc("1").set(data2);
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) =>
          const AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }
  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      int amount2=int.parse(amount);
      double amount3=amount2/10;
      Map<String, dynamic> body = {
        'amount': amount3.round().toString(),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer sk_test_51NCzkJI3GjRc0k0GX7SaP3JV30KCmrCpKWxGWitExO0yAh8LShdMk8cisb6uD7sncqdNMSvuZ66RMZoWh0uCsz3900QsFbIT17',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // data=jsonDecode(response.body);
      print('Payment Intent Body->>> ${response.body.toString()}');
      data=jsonDecode(response.body);
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }
  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100*passenger;
    return calculatedAmout.toString();
  }
  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem(
    value: item,
    child: Text(item.text),
  );
  void onSelected(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.itemLogout:
        FirebaseAuth.instance.signOut();
        break;
    }
  }
}