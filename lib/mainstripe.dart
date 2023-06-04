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

var data;

class _HomeScreenState extends State<HomeScreen> {
  late String bus;


  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe Payment'),
      ),
      body: Center(
        child:Column(

          children: [
            ElevatedButton(onPressed: () { bus="GREENLINE";makePayment(); }, child: Text("GREENLINE"),),
            ElevatedButton(onPressed: () { bus="PEOPLE BUS";makePayment(); }, child: Text("PEOPLE BUS"),),
            ElevatedButton(onPressed: (){}, child: Text("VIEW YOUR TICKETS"))

          ],

        ),
      )
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent('200', 'PKR');
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
        var amount2=data["amount"]/100;
        //


        final db = FirebaseFirestore.instance;
        final data2 = {"id":id,"name": "-", "date": FieldValue.serverTimestamp(),"email":"-","amount":amount2,"service":bus};
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
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
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
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }




}




