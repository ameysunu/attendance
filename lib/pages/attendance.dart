import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'uniform.dart';
import 'day.dart';
import 'half_year.dart' as halfyear;

final firestoreInstance = FirebaseFirestore.instance;
var currentDate = new DateTime.now();
StreamSubscription<DocumentSnapshot> subscription;

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  List<String> attendance = ['出席', '遲到', '請假', '缺席'];
  String dropdownValue;
  Stream studentStream;

  dropDownItem(String string, int value) {
    return DropdownMenuItem(
      child: Text(string),
      value: value,
    );
  }

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
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    '出席率',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    child: Text(
                      "${currentDate.day}/${currentDate.month}/${currentDate.year}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'OpenSans SemiBold'),
                    ),
                  ),
                )
              ],
            ),
          ),
          elevation: 0,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: halfyear.newStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        return ListView(
                          shrinkWrap: true,
                          children: snapshot.data.docs
                              .map((DocumentSnapshot document) {
                            return AttendanceTile(
                              name: document.data()['name'],
                              group: document.data()['group'],
                              id: document.data()['id'],
                            );
                          }).toList(),
                        );
                      }),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Colors.blueGrey[900],
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 120),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context) => Day()),
                      );
                      //_AttendanceTileState().add();
                    },
                    child: Text(
                      '提交',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "OpenSans Regular",
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceTile extends StatefulWidget {
  final String name, group, id;

  AttendanceTile({Key key, this.name, this.group, this.id}) : super(key: key);

  @override
  _AttendanceTileState createState() => _AttendanceTileState();
}

String dropdownValue;

class _AttendanceTileState extends State<AttendanceTile> {
  List<String> attendance = ['出席', '遲到', '請假', '缺席'];

  var now = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Uniform(
                        name: widget.name,
                        group: widget.group,
                        id: widget.id,
                      )));
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.group,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: "OpenSans Regular",
                ),
              ),
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: "OpenSans Regular",
                ),
              ),
              DropdownButton(
                hint: Text(
                  "選擇",
                  style: TextStyle(
                    fontFamily: "OpenSans SemiBold",
                  ),
                ),
                value: dropdownValue,
                onChanged: (val) {
                  setState(() {
                    dropdownValue = val;
                  });

                  // FirebaseFirestore.instance
                  //     .collection("student")
                  //     .doc(widget.id)
                  //     .collection("attendance")
                  //     .add({
                  //   'date': "${now.day}/${now.month}/${now.year}",
                  //   'studentAttendance': dropdownValue,
                  // });
                  if (halfyear.groupvalue == 'CS') {
                    // FirebaseFirestore.instance
                    //     .collection("student")
                    //     .doc(widget.id)
                    //     .collection("attendance")
                    //     .add({
                    //   'date': "${now.day}/${now.month}/${now.year}",
                    //   'studentAttendance': dropdownValue,
                    // });
                    // //  for day
                    // FirebaseFirestore.instance
                    //     .collection("day")
                    //     .doc(widget.id)
                    //     .set({
                    //   'name': widget.name,
                    //   'group': widget.group,
                    //   "status": dropdownValue,
                    //   "totalMark": "0",
                    //   "date": "${now.day}/${now.month}/${now.year}",
                    // });

                    final DocumentReference documentReference =
                        FirebaseFirestore.instance.doc("data/${widget.id}");
                    subscription =
                        documentReference.snapshots().listen((datasnapshot) {
                      print(documentReference);
                      if (datasnapshot.data()['date'] !=
                          "${now.day}/${now.month}/${now.year}") {
                        print("need to add");
                        FirebaseFirestore.instance
                            .collection("CS")
                            .doc(widget.id)
                            .collection("attendance")
                            .add({
                          'date': "${now.day}/${now.month}/${now.year}",
                          'id': widget.id,
                          'studentAttendance': dropdownValue,
                        });
                        //  for day
                        FirebaseFirestore.instance
                            .collection("day")
                            .doc(widget.id)
                            .set({
                          'name': widget.name,
                          'group': widget.group,
                          "status": dropdownValue,
                          "totalMark": "0",
                          "id": widget.id,
                          "date": "${now.day}/${now.month}/${now.year}",
                        });
                        //check DB
                        FirebaseFirestore.instance
                            .collection("data")
                            .doc(widget.id)
                            .set({
                          'name': widget.name,
                          'group': widget.group,
                          'id': widget.id,
                          "status": dropdownValue,
                          "date": "${now.day}/${now.month}/${now.year}",
                        });
                      } else if (datasnapshot.data()['date'] ==
                          "${now.day}/${now.month}/${now.year}") {
                        print("error");
                      }
                    });
                  } else if (halfyear.groupvalue == 'JS') {
                    // FirebaseFirestore.instance
                    //     .collection("attendancejs")
                    //     .doc(widget.id)
                    //     .collection("attendance")
                    //     .add({
                    //   'date': "${now.day}/${now.month}/${now.year}",
                    //   'studentAttendance': dropdownValue,
                    // });
                    // //  for day
                    // FirebaseFirestore.instance
                    //     .collection("dayjs")
                    //     .doc(widget.id)
                    //     .set({
                    //   'name': widget.name,
                    //   'group': widget.group,
                    //   "status": dropdownValue,
                    //   "totalMark": "0",
                    //   "date": "${now.day}/${now.month}/${now.year}",
                    // });

                    final DocumentReference documentReference =
                        FirebaseFirestore.instance.doc("datajs/${widget.id}");
                    subscription =
                        documentReference.snapshots().listen((datasnapshot) {
                      print(datasnapshot.data()['date']);
                      if (datasnapshot.data()['date'] !=
                          "${now.day}/${now.month}/${now.year}") {
                        print("need to add");
                        FirebaseFirestore.instance
                            .collection("JS")
                            .doc(widget.id)
                            .collection("attendance")
                            .add({
                          'date': "${now.day}/${now.month}/${now.year}",
                          'id': widget.id,
                          'studentAttendance': dropdownValue,
                        });
                        //  for day
                        FirebaseFirestore.instance
                            .collection("dayjs")
                            .doc(widget.id)
                            .set({
                          'name': widget.name,
                          'group': widget.group,
                          "status": dropdownValue,
                          "id": widget.id,
                          "totalMark": "0",
                          "date": "${now.day}/${now.month}/${now.year}",
                        });
                        //check DB
                        FirebaseFirestore.instance
                            .collection("datajs")
                            .doc(widget.id)
                            .set({
                          'name': widget.name,
                          'group': widget.group,
                          'id': widget.id,
                          "status": dropdownValue,
                          "date": "${now.day}/${now.month}/${now.year}",
                        });
                      } else if (datasnapshot.data()['date'] ==
                          "${now.day}/${now.month}/${now.year}") {
                        print("error");
                      }
                    });
                  }
                },
                items: attendance.map((attend) {
                  return DropdownMenuItem(
                    child: Text(attend),
                    value: attend,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
