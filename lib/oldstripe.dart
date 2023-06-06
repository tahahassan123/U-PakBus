import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
var data,pickup,destination;

class _HomeScreenState extends State<HomeScreen> {
  var bus='none';
  final passengers = TextEditingController(text: '0');
  bool show=false;

  var p1='nill1',p2='nill2',p3='nill3',p4='nill4',p5='none';
  var d1='nill5',d2='nill6',d3='nill7',d4='nill8',d5='none';
  var newValue1='none';
  var newValue2='none';

  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Stripe Payment'),
        ),
        body: Center(
          child:SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text("CLICK ON BUS SERVICE AND THEN CHOOSE ROUTES"),
                ),
                TextField(
                  controller: passengers,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter number of passengers",
                    suffixIcon: IconButton(
                      onPressed: () {
                        passengers.clear();
                      },
                      icon: const Icon(Icons.clear),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                ),
                Visibility(
                    visible: show,
                  child: DropdownButton<String>(

                      hint: Text('Choose'),
                      onChanged: (String? changedValue) {
                        newValue1=changedValue!;
                        setState(() {
                          newValue1;
                          pickup=newValue1;
                          print(newValue1);
                        });
                      },
                      value: newValue1,
                      items: <String>[p1,p2,p3,p4,p5]
                          .map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())
                ),
                        Visibility(
                            visible: show,
                          child: DropdownButton<String>(
                              hint: Text('Choose'),
                              onChanged: (String? changedValue) {
                                newValue2=changedValue!;
                                setState(() {
                                  newValue2;
                                  destination=newValue2;
                                  print(newValue2);
                                });
                              },
                              value: newValue2,
                              items: <String>[d1,d2,d3,d4,d5]
                                  .map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList())
                        ),
                         ElevatedButton(onPressed: () {
                           bus="GREENLINE"; setState(() {
                             p1='A';
                             p2='B';
                             p3='C';
                             p4='D';
                             p5='none';
                             newValue1='none';
                             show=true;
                             d1='A';
                             d2='B';
                             d3='C';
                             d4='D';
                             d5='none';
                             newValue2='none';
                           }); }, child: Text("GREENLINE"),),
                         ElevatedButton(onPressed: () { bus="PEOPLE BUS";setState(() {
                           p1='E';
                           p2='F';
                           p3='G';
                           p4='H';
                           p5='none';
                           newValue1='none';
                           show=true;
                           d1='E';
                           d2='F';
                           d3='G';
                           d4='H';
                           d5='none';
                           newValue2='none';
                         }); }, child: Text("PEOPLE BUS"),),
                         ElevatedButton(onPressed: (){}, child: Text("VIEW YOUR TICKETS")),
                ElevatedButton(onPressed: (){
                    if(bus=='none'||newValue1=='nill' || newValue2=='nill' ||newValue1=='none' || newValue2=='none' || newValue1=='nill1'||newValue1=='nill2'||newValue1=='nill3'||newValue1=='nill4' || newValue2=='nill5'|| newValue2=='nill6'
                      || newValue2=='nill7'|| newValue2=='nill8' || int.parse(passengers.text)==0){
                    var snackBar = SnackBar(content: Text('HAVE YOU SELECTED BUS SERVICE,ROUTES? ENTERED NUMBER OF PASSENGERS?'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }else
                  makePayment();}, child: Text("Pay"))
              ],
            ),
          ),
        )
    );
  }

  Future<void> makePayment() async {
    try {
      int totalamount=((50000*int.parse(passengers.text)));


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


      ///now finally display payment sheeet
      ///



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



        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp(
        );


        String id=data["id"];
        var amount2=(data["amount"]/100);
        //


        final db = FirebaseFirestore.instance;
        final data2 = {"id":id,"name": "-", "passengers":passengers.text,"date": FieldValue.serverTimestamp(),"email":"-","amount":amount2,"service":bus,"pickup":pickup,"destination":destination};
        db.collection(bus).doc("1").set(data2);

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
          'Authorization': 'Bearer sk_test_51NCzkJI3GjRc0k0Gke4rcq5Aq61auu3Tel6fceIW8GdefxyMU8Wa2WgjfnfHHYbevbJ7RwG1s4d3PnrIO0FvOJVB00mdyakBmI',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      data=jsonDecode(response.body);
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100*int.parse(passengers.text);
    return calculatedAmout.toString();
  }




}