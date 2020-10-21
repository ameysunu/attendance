import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '當天', //day page that will show all data when teacher click submit
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.blueGrey[50],
      ),
      body: Container(
        child: ListView(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("day").snapshots(),
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Card(
        elevation: 10.0,
        child: ListTile(
          leading: Text(
            group,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          title: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          trailing: Text(status),
        ),
      ),
    );
  }
}
