import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Background());
}
class Background extends StatelessWidget{
  Background({super.key});
  String dropdownValue = 'PeoplesBus';
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
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.green.withOpacity(0.3), BlendMode.dstATop),
            ),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                //child: InkWell(
                //  onTap: () {},
                //  child: Ink.image(
                //splashColor: Colors.black26,
                //    image: AssetImage('images/button.png'),
                //     height: 100,
                //    width: 100,
                //    fit: BoxFit.cover,
                //),
                // ),
                child: GestureDetector(
                  onTap: () {
                    debugPrint('The image button has been tapped');
                  },
                  child: Image.asset('images/button.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);
  @override
  _MainMenuState createState() => _MainMenuState();
}
class _MainMenuState extends State<MainMenu> {
  final items = ["PeoplesBus", "EV_Bus", "GreenlineMetro"];
  String? value;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DropdownButton<String>(
            items: items.map(buildMenuItem).toList(),
            onChanged: (value) => setState(() => this.value = value),
          ),

        ]
    ),
  );
  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(
          value: item,
          child: Text(item, style: TextStyle(fontSize: 12,),)
      );
}
