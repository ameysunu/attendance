import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'half_year.dart' as halfyear;

var now = new DateTime.now();
String finalMarks = "0";
String shirt, pant, belt, shoe, other;

class Update extends StatefulWidget {
  final String name, group, id;

  const Update({Key key, this.name, this.group, this.id}) : super(key: key);
  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  List<String> attendance = ['出席', '遲到', '請假', '缺席'];
  String dropdownValue;
  Stream studentStream;

  dropDownItem(String string, int value) {
    return DropdownMenuItem(
      child: Text(string),
      value: value,
    );
  }

  List<String> update = ['1', '2', '3'];

  void calcCS() {
    int total = int.parse(shirt) +
        int.parse(pant) +
        int.parse(belt) +
        int.parse(shoe) +
        int.parse(other);
    setState(() {
      finalMarks = total.toString();
    });
    print(finalMarks);
  }

  void calcJS() {
    int total =
        int.parse(shirt) + int.parse(pant) + int.parse(shoe) + int.parse(other);
    setState(() {
      finalMarks = total.toString();
    });
    print(finalMarks);
  }

  @override
  void initState() {
    super.initState();
    if (halfyear.groupvalue == 'CS') {
      halfyear.newStream = FirebaseFirestore.instance
          .collection('student')
          .orderBy('group')
          .snapshots();
    } else if (halfyear.groupvalue == 'JS') {
      halfyear.newStream = FirebaseFirestore.instance
          .collection('attendancejs')
          .orderBy('group')
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (halfyear.groupvalue == 'CS') {
      return Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
            'Update',
            style:
                TextStyle(fontFamily: 'OpenSans SemiBold', color: Colors.black),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Column(
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: "OpenSans Regular",
                            ),
                          ),
                          Text(
                            widget.group,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "OpenSans Regular",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        ListTile(
                          title: Text(
                            '襯衫',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "OpenSans Regular",
                            ),
                          ),
                          trailing: DropdownButton(
                            hint: Text("選擇"),
                            value: shirt,
                            onChanged: (val) {
                              setState(() {
                                shirt = val;
                              });
                            },
                            items: update.map((attend) {
                              return DropdownMenuItem(
                                child: Text("${attend}"),
                                value: attend,
                              );
                            }).toList(),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            '裙/褲',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "OpenSans Regular",
                            ),
                          ),
                          trailing: DropdownButton(
                            hint: Text("選擇"),
                            value: pant,
                            onChanged: (val) {
                              setState(() {
                                pant = val;
                              });
                            },
                            items: update.map((attend) {
                              return DropdownMenuItem(
                                child: Text("$attend"),
                                value: attend,
                              );
                            }).toList(),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            '皮帶',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "OpenSans Regular",
                            ),
                          ),
                          trailing: DropdownButton(
                            hint: Text("選擇"),
                            value: belt,
                            onChanged: (val) {
                              setState(() {
                                belt = val;
                              });
                            },
                            items: update.map((attend) {
                              return DropdownMenuItem(
                                child: Text("${attend}"),
                                value: attend,
                              );
                            }).toList(),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            '皮鞋',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "OpenSans Regular",
                            ),
                          ),
                          trailing: DropdownButton(
                            hint: Text("選擇"),
                            value: shoe,
                            onChanged: (val) {
                              setState(() {
                                shoe = val;
                              });
                            },
                            items: update.map((attend) {
                              return DropdownMenuItem(
                                child: Text("${attend}"),
                                value: attend,
                              );
                            }).toList(),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            '其他',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "OpenSans Regular",
                            ),
                          ),
                          trailing: DropdownButton(
                            hint: Text("選擇"),
                            value: other,
                            onChanged: (val) {
                              setState(() {
                                other = val;
                              });
                            },
                            items: update.map((attend) {
                              return DropdownMenuItem(
                                child: Text("${attend}"),
                                value: attend,
                              );
                            }).toList(),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Attendance',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "OpenSans Regular",
                            ),
                          ),
                          trailing: DropdownButton(
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

                              if (halfyear.groupvalue == 'CS') {
                                FirebaseFirestore.instance
                                    .collection("student")
                                    .doc(widget.id)
                                    .collection("attendance")
                                    .add({
                                  'date': "${now.day}/${now.month}/${now.year}",
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
                                  "date": "${now.day}/${now.month}/${now.year}",
                                });
                              } else if (halfyear.groupvalue == 'JS') {
                                FirebaseFirestore.instance
                                    .collection("attendancejs")
                                    .doc(widget.id)
                                    .collection("attendance")
                                    .add({
                                  'date': "${now.day}/${now.month}/${now.year}",
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
                                  "date": "${now.day}/${now.month}/${now.year}",
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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Colors.blueGrey[900],
                      textColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 120),
                      onPressed: () {
                        setState(() {});

                        FirebaseFirestore.instance
                            .collection("uniform")
                            .doc(widget.id)
                            .set({
                          "name": widget.name,
                          "group": widget.group,
                        });
                        FirebaseFirestore.instance
                            .collection("student")
                            .doc(widget.id)
                            .collection("marks")
                            .add({
                          'Date': "${now.day}/${now.month}/${now.year}",
                          'Shirt': shirt,
                          'Pant': pant,
                          'Belt': belt,
                          'Shoe': shoe,
                          'Other': other,
                        });

                        calcCS();

                        FirebaseFirestore.instance
                            .collection("day")
                            .doc(widget.id)
                            .update({
                          'totalMark': finalMarks,
                        });

                        Navigator.pop(context);
                      },
                      child: Text(
                        '提交',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (halfyear.groupvalue == 'JS') {
      return Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
            'Update',
            style:
                TextStyle(fontFamily: 'OpenSans SemiBold', color: Colors.black),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Column(
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: "OpenSans Regular",
                            ),
                          ),
                          Text(
                            widget.group,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "OpenSans Regular",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        ListTile(
                          title: Text(
                            '襯衫',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "OpenSans Regular",
                            ),
                          ),
                          trailing: DropdownButton(
                            hint: Text("選擇"),
                            value: shirt,
                            onChanged: (val) {
                              setState(() {
                                shirt = val;
                              });
                            },
                            items: update.map((attend) {
                              return DropdownMenuItem(
                                child: Text("${attend}"),
                                value: attend,
                              );
                            }).toList(),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            '裙/褲',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "OpenSans Regular",
                            ),
                          ),
                          trailing: DropdownButton(
                            hint: Text("選擇"),
                            value: pant,
                            onChanged: (val) {
                              setState(() {
                                pant = val;
                              });
                            },
                            items: update.map((attend) {
                              return DropdownMenuItem(
                                child: Text("$attend"),
                                value: attend,
                              );
                            }).toList(),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            '皮鞋',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "OpenSans Regular",
                            ),
                          ),
                          trailing: DropdownButton(
                            hint: Text("選擇"),
                            value: shoe,
                            onChanged: (val) {
                              setState(() {
                                shoe = val;
                              });
                            },
                            items: update.map((attend) {
                              return DropdownMenuItem(
                                child: Text("${attend}"),
                                value: attend,
                              );
                            }).toList(),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            '其他',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "OpenSans Regular",
                            ),
                          ),
                          trailing: DropdownButton(
                            hint: Text("選擇"),
                            value: other,
                            onChanged: (val) {
                              setState(() {
                                other = val;
                              });
                            },
                            items: update.map((attend) {
                              return DropdownMenuItem(
                                child: Text("${attend}"),
                                value: attend,
                              );
                            }).toList(),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Attendance',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "OpenSans Regular",
                            ),
                          ),
                          trailing: DropdownButton(
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

                              if (halfyear.groupvalue == 'CS') {
                                FirebaseFirestore.instance
                                    .collection("student")
                                    .doc(widget.id)
                                    .collection("attendance")
                                    .add({
                                  'date': "${now.day}/${now.month}/${now.year}",
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
                                  "date": "${now.day}/${now.month}/${now.year}",
                                });
                              } else if (halfyear.groupvalue == 'JS') {
                                FirebaseFirestore.instance
                                    .collection("attendancejs")
                                    .doc(widget.id)
                                    .collection("attendance")
                                    .add({
                                  'date': "${now.day}/${now.month}/${now.year}",
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
                                  "date": "${now.day}/${now.month}/${now.year}",
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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Colors.blueGrey[900],
                      textColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 120),
                      onPressed: () {
                        setState(() {});

                        FirebaseFirestore.instance
                            .collection("uniform")
                            .doc(widget.id)
                            .set({
                          "name": widget.name,
                          "group": widget.group,
                        });
                        FirebaseFirestore.instance
                            .collection("student")
                            .doc(widget.id)
                            .collection("marks")
                            .add({
                          'Date': "${now.day}/${now.month}/${now.year}",
                          'Shirt': shirt,
                          'Pant': pant,
                          'Shoe': shoe,
                          'Other': other,
                        });

                        calcJS();

                        FirebaseFirestore.instance
                            .collection("day")
                            .doc(widget.id)
                            .update({
                          'totalMark': finalMarks,
                        });

                        Navigator.pop(context);
                      },
                      child: Text(
                        '提交',
                        style: TextStyle(fontSize: 20),
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
}
