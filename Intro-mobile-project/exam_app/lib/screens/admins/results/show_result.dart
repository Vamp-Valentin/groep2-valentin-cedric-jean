import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/screens/admins/grade/grading.dart';
import 'package:exam_app/screens/admins/results/results.dart';
import 'package:exam_app/services/database.dart';
import 'package:flutter/material.dart';

class ShowResult extends StatelessWidget {
  const ShowResult({Key? key, required this.student}) : super(key: key);
  final String student;

  @override
  Widget build(BuildContext context) {
    int result = 0;
    return MaterialApp(
      home: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('students')
                .orderBy('sNumber')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return Container();
              List students = [];
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                String stu = snapshot.data!.docs[i].get('sNumber');
                if (stu == student) {
                  result = snapshot.data!.docs[i].get('result');
                }
              }
              if (result.isNaN){
                return Text("Nog niet beoordeeld");
              }
              return Text(result.toString());
  })),
    );
  }
}