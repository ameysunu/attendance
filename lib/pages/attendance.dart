import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'uniform.dart';
import 'day.dart';

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  List<String> attendance = ['present', 'absent', 'sick'];
  String dropdownValue;
  Stream studentStream;

  dropDownItem(String string, int value) {
    return DropdownMenuItem(
      child: Text(string),
      value: value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '出席率', //attendance page title
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.grey[100],
      ),
      body: Container(
        child: ListView(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("student")
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
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      return AttendanceTile(
                        name: document.data()['name'],
                        group: document.data()['group'],
                        id: document.data()['id'],
                      );
                    }).toList(),
                  );
                }),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: Colors.lightBlue[900],
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 120),
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => Day()),
                  );
                },
                child: Text(
                  'save', //submit
                  style: TextStyle(fontSize: 20),
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

class _AttendanceTileState extends State<AttendanceTile> {
  List<String> attendance = ['present', 'absent', 'sick'];

  String dropdownValue;
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
        child: Text(
          widget.name,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      subtitle: Text(
        widget.group,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: DropdownButton(
        hint: Text("select"),
        value: dropdownValue,
        onChanged: (val) {
          setState(() {
            dropdownValue = val;
          });

          FirebaseFirestore.instance
              .collection("student")
              .doc(widget.id)
              .collection("studentattendance")
              .add({
            'date': "${now.day}/${now.month}/${now.year}",
            'studentAttendance': dropdownValue,
          });

          //  for day
          FirebaseFirestore.instance.collection("day").doc(widget.id).set({
            'name': widget.name,
            'group': widget.group,
            "status": dropdownValue,
            "totalMark": ""
          });
        },
        items: attendance.map((attend) {
          return DropdownMenuItem(
            child: Text(attend),
            value: attend,
          );
        }).toList(),
      ),
    );
  }
}
