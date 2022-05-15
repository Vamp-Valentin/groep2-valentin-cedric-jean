import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/screens/admins/results/results.dart';
import 'package:exam_app/screens/students/location/location.dart';
import 'package:flutter/material.dart';

class GradeWidget extends StatelessWidget {
  GradeWidget({
    required this.student,
    Key? key,
  }) : super(key: key);

  final String student;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Results())),
          ),
          backgroundColor: Colors.red,
          title: Text(student),
          centerTitle: true,
        ),
      ),
    );
  }
}
