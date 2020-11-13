import 'package:boysbrigade/pages/group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String groupvalue = "CS";
Stream<QuerySnapshot> newStream;

class HalfYear extends StatefulWidget {
  final String id;

  const HalfYear({Key key, this.id}) : super(key: key);
  @override
  _HalfYearState createState() => _HalfYearState();
}

class _HalfYearState extends State<HalfYear> {
  @override
  void initState() {
    super.initState();
    if (groupvalue == 'CS') {
      newStream = FirebaseFirestore.instance
          .collection('day')
          .orderBy('group')
          .snapshots();
    } else if (groupvalue == 'JS') {
      newStream = FirebaseFirestore.instance
          .collection('dayjs')
          .orderBy('group')
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width;
    var _width = (_screenWidth - 20) / 2;
    var _aspectRatio = _width / 250;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: DropdownButton<String>(
              value: groupvalue,
              onChanged: (String newValue) {
                setState(() {
                  groupvalue = newValue;

                  if (groupvalue == 'CS') {
                    print('CS');
                    newStream = FirebaseFirestore.instance
                        .collection('day')
                        .orderBy('group')
                        .snapshots();
                  } else if (groupvalue == 'JS') {
                    newStream = FirebaseFirestore.instance
                        .collection('dayjs')
                        .orderBy('group')
                        .snapshots();
                  }
                });
              },
              items: <String>['CS', 'JS']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        title: Text(
          '上半年', //half year
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.blueGrey[50],
      body: StreamBuilder(
        stream: newStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var totalgroupCount = 0;
          List<DocumentSnapshot> groupUsers;
          if (snapshot.hasData) {
            groupUsers = snapshot.data.documents;
            totalgroupCount = groupUsers.length;
            return GridView.builder(
              padding: const EdgeInsets.all(30),
              itemCount: snapshot.data.documents.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 30,
                  crossAxisCount: 2,
                  childAspectRatio: _aspectRatio),
              itemBuilder: (context, int index) => InkWell(
                child: Container(
                  height: 290.0,
                  padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        groupUsers[index].data()['group'],
                        style: TextStyle(
                          color: Colors.indigo[900],
                          fontSize: 35,
                          fontFamily: "OpenSans Regular",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '出席率',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: "OpenSans Regular",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                            height: 40,
                          ),
                          Text(
                            '制服', //uniform
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans Regular",
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '13%',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '40%',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 3,
                        offset: Offset(8, 5), // changes position of shadow
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Group(
                                group: groupUsers[index].data()['group'],
                                name: groupUsers[index].data()['name'],
                                date: groupUsers[index].data()['date'],
                                status: groupUsers[index].data()['status'],
                                total: groupUsers[index].data()['totalMark'],
                                id: widget.id,
                              )));
                },
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
