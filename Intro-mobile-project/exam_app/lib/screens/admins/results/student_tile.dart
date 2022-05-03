import 'package:exam_app/models/my_exam.dart';
import 'package:flutter/material.dart';

class StudentTile extends StatelessWidget {
  //const ExamTile({Key? key}) : super(key: key);
  final MyExam? exam;
  final List? student;
  StudentTile({this.exam, this.student});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.red,
            child: Icon(Icons.domain_verification_outlined),
          ),
          title: Text(exam!.students.toString()),
        ),
      ),
    );
  }

  List<dynamic> splitStudents(String? students) {
    List splitList = [];
    final splitstudents = students?.split(';');
    if (splitstudents != null) {
      for (int i = 0; i < splitstudents.length; i++) {
        splitList.add(splitstudents[i]);
        debugPrint(splitList[i]);
      }
    }
    return splitList;
  }
}
