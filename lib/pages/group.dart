import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Group extends StatefulWidget {
  final String name, group, id, date, status;
  const Group({Key key, this.name, this.status, this.date, this.group, this.id})
      : super(key: key);
  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          widget.group,
          style:
              TextStyle(fontFamily: 'OpenSans SemiBold', color: Colors.black),
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Center(child: Text("1")),
                ),
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Card(
                            color: Colors.blueGrey[900],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    widget.name,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Attendance",
                                        style: TextStyle(
                                          fontFamily: 'OpenSans Regular',
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "13%",
                                        style: TextStyle(
                                            fontFamily: 'OpenSans Regular',
                                            color: Colors.white,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Uniform",
                                        style: TextStyle(
                                          fontFamily: 'OpenSans Regular',
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "80%",
                                        style: TextStyle(
                                            fontFamily: 'OpenSans Regular',
                                            color: Colors.white,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.date,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'OpenSans SemiBold'),
                                    ),
                                    Text(
                                      widget.status,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'OpenSans SemiBold'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.date,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'OpenSans SemiBold'),
                                    ),
                                    Text(
                                      widget.status,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'OpenSans SemiBold'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.date,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'OpenSans SemiBold'),
                                    ),
                                    Text(
                                      widget.status,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'OpenSans SemiBold'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
