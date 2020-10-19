import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Uniform extends StatefulWidget {
  final String name, group, id;

  const Uniform({Key key, this.name, this.group, this.id}) : super(key: key);

  @override
  _UniformState createState() => _UniformState();
}

class _UniformState extends State<Uniform> {
  List<String> uniform = ['1','2','3'];
  var now = new DateTime.now();

  String shoe, pant, shirt, skirt, tye;
  int total=0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        backgroundColor: Colors.grey[100],
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(30),
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
              child: Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        widget.group,
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        widget.name, //name
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
              child: Row(
                children: [
                  Text(
                    'Uniform',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    "mark",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                //shoes
                ListTile(
                  title: Text(
                    'shoes',
                    style: TextStyle(
                      fontSize: 30,
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
                    'shirt',
                    style: TextStyle(
                      fontSize: 30,
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
                    'pant',
                    style: TextStyle(
                      fontSize: 30,
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
                    'tye',
                    style: TextStyle(
                      fontSize: 30,
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
                    'skirt',
                    style: TextStyle(
                      fontSize: 30,
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
              color: Colors.lightBlue[900],
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 120),
              onPressed: () {
                setState(() {
                });
                FirebaseFirestore.instance
                    .collection("uniform")
                    .doc(widget.id)
                    .set({
                  "name": widget.name,
                  "group": widget.group,
                });

                FirebaseFirestore.instance
                    .collection("uniform")
                    .doc(widget.id)
                    .collection("marks")
                    .add({
                  'date': "${now.day}/${now.month}/${now.year}",
                  'shirt': shirt,
                  'skirt': skirt,
                  'shoe': shoe,
                  'pant': pant,
                  'tye': tye,
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
