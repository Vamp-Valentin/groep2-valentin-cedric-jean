import 'package:exam_app/models/my_exam.dart';
import 'package:exam_app/screens/admins/home/exam_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExamList extends StatefulWidget {
  const ExamList({Key? key}) : super(key: key);

  @override
  State<ExamList> createState() => _ExamListState();
}

class _ExamListState extends State<ExamList> {
  @override
  Widget build(BuildContext context) {

    final exams = Provider.of<List<MyExam>>(context);
    return ListView.builder(
      itemCount: exams.length,
      itemBuilder: (context, index) {
        return ExamTile(exam: exams[index]);
      },
    );
  }
}