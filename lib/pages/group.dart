import 'package:flutter/material.dart';

class Group extends StatefulWidget {
  final String name, group, id, date, status, total;
  const Group(
      {Key key,
      this.name,
      this.status,
      this.total,
      this.date,
      this.group,
      this.id})
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
            Column(
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.05,
                      child: Center(child: Text("1")),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Card(
                                color: Colors.blueGrey[900],
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            "13%",
                                            style: TextStyle(
                                                fontFamily: 'OpenSans Regular',
                                                color: Colors.white,
                                                fontSize: 18),
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
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            "80%",
                                            style: TextStyle(
                                                fontFamily: 'OpenSans Regular',
                                                color: Colors.white,
                                                fontSize: 18),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        widget.date,
                                        style: TextStyle(
                                          fontFamily: 'OpenSans SemiBold',
                                        ),
                                      ),
                                      Text(
                                        widget.status,
                                        style: TextStyle(
                                            fontFamily: 'OpenSans SemiBold',
                                            fontSize: 20),
                                      ),
                                      Text(
                                        widget.total,
                                        style: TextStyle(
                                            fontFamily: 'OpenSans SemiBold',
                                            fontSize: 25),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        widget.date,
                                        style: TextStyle(
                                          fontFamily: 'OpenSans SemiBold',
                                        ),
                                      ),
                                      Text(
                                        widget.status,
                                        style: TextStyle(
                                            fontFamily: 'OpenSans SemiBold',
                                            fontSize: 20),
                                      ),
                                      Text(
                                        widget.total,
                                        style: TextStyle(
                                            fontFamily: 'OpenSans SemiBold',
                                            fontSize: 25),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        widget.date,
                                        style: TextStyle(
                                          fontFamily: 'OpenSans SemiBold',
                                        ),
                                      ),
                                      Text(
                                        widget.status,
                                        style: TextStyle(
                                            fontFamily: 'OpenSans SemiBold',
                                            fontSize: 20),
                                      ),
                                      Text(
                                        widget.total,
                                        style: TextStyle(
                                            fontFamily: 'OpenSans SemiBold',
                                            fontSize: 25),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
