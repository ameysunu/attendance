import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'half_year.dart' as halfyear;

class Day extends StatefulWidget {
  @override
  _DayState createState() => _DayState();
}

class _DayState extends State<Day> {
  @override
  void initState() {
    super.initState();
    if (halfyear.groupvalue == 'CS') {
      halfyear.newStream = FirebaseFirestore.instance
          .collection('day')
          .orderBy('group')
          .snapshots();
    } else if (halfyear.groupvalue == 'JS') {
      halfyear.newStream = FirebaseFirestore.instance
          .collection('dayjs')
          .orderBy('group')
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  '當天',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          elevation: 0,
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: halfyear.newStream,
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
                        totalMark: doc.data()['totalMark'],
                        date: doc.data()['date'],
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
  final String name, group, status, totalMark, date;

  const StatusBar(
      {Key key, this.name, this.group, this.status, this.totalMark, this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getColor(attendance) {
      if (status == "出席" || status == "遲到") {
        return Colors.blueGrey[900];
      } else
        return Colors.grey[400];
    }

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
                style: TextStyle(
                    fontFamily: 'OpenSans SemiBold',
                    fontSize: 20,
                    color: getColor(status)),
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
                        fontWeight: FontWeight.bold,
                        color: getColor(status)),
                  ),
                  Text(
                    status,
                    style: TextStyle(
                        fontFamily: 'OpenSans SemiBold',
                        fontSize: 20,
                        color: getColor(status)),
                  ),
                  Text(
                    totalMark,
                    style: TextStyle(
                        fontFamily: 'OpenSans SemiBold',
                        fontSize: 20,
                        color: getColor(status)),
                  ),
                  // IconButton(
                  //   icon: Icon(Icons.edit),
                  //   onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => Update(
                  //                   name: name,
                  //                   group: group,
                  //                 )));
                  //   },
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
