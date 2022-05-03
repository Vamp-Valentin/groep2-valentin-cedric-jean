import 'package:exam_app/models/my_exam.dart';
import 'package:exam_app/screens/admins/home/exam_tile.dart';
import 'package:exam_app/screens/admins/results/student_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentList extends StatefulWidget {
  const StudentList({Key? key}) : super(key: key);
  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  MyExam? exam;
  List? student;
  @override
  Widget build(BuildContext context) {
    final exams = Provider.of<List<MyExam>>(context);
    final splitlist = splitStudents(exams[1].students.toString());
    return ListView.builder(
      itemCount: splitlist.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.red,
            child: Icon(Icons.domain_verification_outlined),
          ),
          title: Text(splitlist[index].toString()),
        );},
    );
  }

  List splitStudents(String? students) {
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
