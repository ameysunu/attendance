import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '制服', //uniform
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
                      'Uniform',
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
                        "Marks",
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
                //shoes
                ListTile(
                  title: Text(
                    'Shoes',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "OpenSans Regular",
                    ),
                  ),
                  trailing: DropdownButton(
                    hint: Text("marks"),
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

                //  shirt
                ListTile(
                  title: Text(
                    'Shirt',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "OpenSans Regular",
                    ),
                  ),
                  trailing: DropdownButton(
                    hint: Text("marks"),
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
                //  pant
                ListTile(
                  title: Text(
                    'Pant',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "OpenSans Regular",
                    ),
                  ),
                  trailing: DropdownButton(
                    hint: Text("marks"),
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
                //  tye
                ListTile(
                  title: Text(
                    'Tie',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "OpenSans Regular",
                    ),
                  ),
                  trailing: DropdownButton(
                    hint: Text("marks"),
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

                //  skirt

                ListTile(
                  title: Text(
                    'Skirt',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "OpenSans Regular",
                    ),
                  ),
                  trailing: DropdownButton(
                    hint: Text("marks"),
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
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: Colors.indigo[900],
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
                '提交', //submit
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
