import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Image.asset(
            //   'assets/logo.png',
            // height: 200,
            // ),
            Text(
              '香港基督少年軍第78分隊',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
            ),
            Text(
              '謝佩妏',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
