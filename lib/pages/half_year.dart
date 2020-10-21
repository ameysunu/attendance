import 'package:boysbrigade/pages/settings.dart';
import 'package:flutter/material.dart';

class HalfYear extends StatefulWidget {
  @override
  _HalfYearState createState() => _HalfYearState();
}

class _HalfYearState extends State<HalfYear> {
  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width;
    var _width = (_screenWidth - 20) / 2;
    var _aspectRatio = _width / 250;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '上半年', //half year
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 25,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.blueGrey[50],
      ),
      backgroundColor: Colors.blueGrey[50],
      body: GridView.builder(
        padding: const EdgeInsets.all(30),
        itemCount: 5,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 20,
            mainAxisSpacing: 30,
            crossAxisCount: 2,
            childAspectRatio: _aspectRatio),
        itemBuilder: (context, index) => Container(
          height: 280.0,
          padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'CS14',
                style: TextStyle(
                  color: Colors.indigo[900],
                  fontSize: 35,
                  fontFamily: "OpenSans Regular",
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '出席率', //attendance
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: "OpenSans Regular",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                    height: 40,
                  ),
                  Text(
                    '制服', //uniform
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: "OpenSans Regular",
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '13%',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '40%',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 3,
                offset: Offset(8, 5), // changes position of shadow
              ),
            ],
          ),
        ),
      ),
    );
  }
}
