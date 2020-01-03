import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Your Order",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.amberAccent,
      ),
      body: Center(
        child: SingleChildScrollView(

        child: Container(
          child: Padding(padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              Padding(padding: EdgeInsets.only( bottom: 20),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Insert your tracking code',
                  ),
                  enabled: true,
                  // maxLength: 16,
                  //maxLengthEnforced: true,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.red

                  ),
                ),
              ),
              ],
            ),
          ),
        )
      ),
      ),
    );
  }
}
