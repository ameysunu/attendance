import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'uniform.dart';

class Day extends StatefulWidget {
  @override
  _DayState createState() => _DayState();
}

class _DayState extends State<Day> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '當天', //day page that will show all data when teacher click submit
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontFamily: "OpenSans Regular",
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: ListView(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("day")
                    .orderBy("group")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return ListView(
                    shrinkWrap: true,
                    children: snapshot.data.docs.map((DocumentSnapshot doc) {
                      return StatusBar(
                        name: doc.data()['name'],
                        group: doc.data()['group'],
                        status: doc.data()['status'],
                      );
                    }).toList(),
                  );
                })
          ],
        ),
      ),
    );
  }
}

class StatusBar extends StatelessWidget {
  final String name, group, status;

  const StatusBar({Key key, this.name, this.group, this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                group,
                style: TextStyle(fontFamily: 'OpenSans SemiBold', fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        fontFamily: 'OpenSans SemiBold',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    status,
                    style: TextStyle(
                        fontFamily: 'OpenSans SemiBold', fontSize: 20),
                  ),
                  Text(
                    finalMarks,
                    style: TextStyle(
                        fontFamily: 'OpenSans SemiBold', fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
