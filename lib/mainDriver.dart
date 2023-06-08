import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'menu.dart';

void main() => runApp(
    MaterialApp(
      title: "UserPage",
      home: Driver(),
    ));
class Driver extends StatelessWidget {
  const Driver({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/drivermainmenu2.jpg'),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.greenAccent.withOpacity(0.75), BlendMode.dstATop),
            ),
          ),
        ),
        appBar: AppBar(
          title: Text('Universal Pak Bus',),
          centerTitle: true,
          backgroundColor: Colors.green[800],
          actions: [
            PopupMenuButton<MenuItem>(
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) =>
              [
                ...MenuItems.items.map(buildItem).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onSelected(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.itemLogout:
        FirebaseAuth.instance.signOut();
        break;
    }
  }
}
