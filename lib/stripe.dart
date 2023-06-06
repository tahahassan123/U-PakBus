import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:pakistanbusapp/stripe.dart';
//import 'oldstripe.dart';
import 'mainstripe.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_51NCzkJI3GjRc0k0G7UYdLn0T3O9dUl2cIHzixhgztwcPz5bfAbaqknMWa5sTfKUo9X2Hx27VpqZH7y8LZoSNtChU000A6VQLAd';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
