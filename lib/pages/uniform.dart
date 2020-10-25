import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

var currentDate = new DateTime.now();

class Uniform extends StatefulWidget {
  final String name, group, id;

  const Uniform({Key key, this.name, this.group, this.id}) : super(key: key);

  @override
  _UniformState createState() => _UniformState();
}

class _UniformState extends State<Uniform> {
  List<String> uniform = ['1', '2', '3'];
  var now = new DateTime.now();

  String shoe, pant, shirt, skirt, tye;
  int total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          title: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  '制服',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "${currentDate.day}/${currentDate.month}/${currentDate.year}",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'OpenSans SemiBold'),
                ),
              ),
            ],
          ),
          elevation: 0,
          backgroundColor: Colors.white,
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '制服',
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: "OpenSans SemiBold",
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              "分數",
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: "OpenSans SemiBold",
                              ),
                            ),
                          )
                        ],
                      ),
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
                          value: shoe,
                          onChanged: (val) {
                            setState(() {
                              shoe = val;
                            });
                          },
                          items: uniform.map((attend) {
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
                          value: shirt,
                          onChanged: (val) {
                            setState(() {
                              shirt = val;
                            });
                          },
                          items: uniform.map((attend) {
                            return DropdownMenuItem(
                              child: Text("${attend}"),
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
                          value: pant,
                          onChanged: (val) {
                            setState(() {
                              pant = val;
                            });
                          },
                          items: uniform.map((attend) {
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
                          value: tye,
                          onChanged: (val) {
                            setState(() {
                              tye = val;
                            });
                          },
                          items: uniform.map((attend) {
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
                          value: skirt,
                          onChanged: (val) {
                            setState(() {
                              skirt = val;
                            });
                          },
                          items: uniform.map((attend) {
                            return DropdownMenuItem(
                              child: Text("${attend}"),
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
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 120),
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
                          .doc("update")
                          .update({
                        'Date': "${now.day}/${now.month}/${now.year}",
                        'Shirt': shirt,
                        'Skirt': skirt,
                        'Shoe': shoe,
                        'Pant': pant,
                        'Tie': tye,
                      });

                      // FirebaseFirestore.instance
                      // .collection("day")
                      // .doc(widget.id)
                      // .update({'totalMark':"${}"});

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
