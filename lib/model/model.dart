import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  final String studentID;
  final String status;
  final Timestamp createdAt;

  Attendance(this.status, this.studentID, this.createdAt);

  Attendance.fromFirestore(DocumentSnapshot document)
      : studentID = document.id,
        status = document.data()['status'],
        createdAt = document.data()['createdAt'];
}

class UniformCS {
  final String id;
  final String newID;
  final String shirt;
  final String pants;
  final String belt;
  final String shoe;
  final String other;
  final Timestamp createdAt;

  UniformCS(this.id, this.shirt, this.pants, this.other, this.belt, this.shoe,
      this.newID, this.createdAt);

  UniformCS.fromFirestore(DocumentSnapshot document)
      : id = document.id,
        newID = document.id,
        shirt = document.data()['shirt'],
        pants = document.data()['pants'],
        belt = document.data()['belt'],
        shoe = document.data()['shoe'],
        other = document.data()['other'],
        createdAt = document.data()['createdAt'];
}

class UniformJS {
  final String id;
  final String newID;
  final String shirt;
  final String pants;
  final String shoe;
  final String other;
  final Timestamp createdAt;

  UniformJS(this.id, this.shirt, this.pants, this.other, this.shoe, this.newID,
      this.createdAt);

  UniformJS.fromFirestore(DocumentSnapshot document)
      : id = document.id,
        newID = document.id,
        shirt = document.data()['shirt'],
        pants = document.data()['pants'],
        shoe = document.data()['shoe'],
        other = document.data()['other'],
        createdAt = document.data()['createdAt'];
}
