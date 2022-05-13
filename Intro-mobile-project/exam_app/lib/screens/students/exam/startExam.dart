import 'package:exam_app/models/my_student.dart';
import 'package:flutter/material.dart';

class CompleteExam extends StatefulWidget {
  CompleteExam({Key? key, this.sNumber, this.student}) : super(key: key);

  final String? sNumber;
  final MyStudent? student;
  @override
  State<CompleteExam> createState() => _CompleteExamState();
}

class _CompleteExamState extends State<CompleteExam> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}