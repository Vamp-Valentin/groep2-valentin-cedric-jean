import 'dart:ffi';

import 'package:exam_app/models/my_student.dart';

class MyUser {
  String? uid;
  String? sNumber;
  String? email;
  String? firstName;
  String? lastName;
  bool? isAdmin;

  MyUser({this.uid, this.sNumber, this.email, this.firstName, this.lastName, this.isAdmin});

  //get data from database
  factory MyUser.fromMap(map){
    return MyUser(
      uid: map['uid'],
      sNumber: map['sNumber'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      isAdmin: map['isAdmin'],
    );
  }

  //send data to database
  Map<String, dynamic> toMap(){
    return {
      'uid': uid,
      'sNumber': sNumber,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'isAdmin': isAdmin,
    };
  }
}