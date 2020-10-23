import 'package:boysbrigade/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          "設定",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.person),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Account",
                      style: TextStyle(
                          fontFamily: "OpenSans Regular", fontSize: 20),
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_right),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.help),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "About",
                      style: TextStyle(
                          fontFamily: "OpenSans Regular", fontSize: 20),
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_right),
                ],
              ),
            ),
          ),
          // Align(
          //   alignment: FractionalOffset.bottomCenter,
          //   child: Center(
          //     child: RaisedButton(
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(30),
          //       ),
          //       color: Colors.blueGrey[900],
          //       textColor: Colors.white,
          //       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 120),
          //       onPressed: () {
          //         signOut();
          //         Navigator.pushReplacement(context,
          //             MaterialPageRoute(builder: (context) => Login()));
          //       },
          //       child: Text(
          //         'Logout', //submit
          //         style: TextStyle(
          //           fontSize: 20,
          //           fontFamily: "OpenSans Regular",
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

void signOut() {
  FirebaseAuth.instance.signOut();
}
