import 'package:exam_app/models/my_exam.dart';
import 'package:exam_app/screens/admins/exam_preview/code_correction_tile.dart';
import 'package:exam_app/screens/admins/exam_preview/multiple_choice_tile.dart';
import 'package:exam_app/screens/admins/exam_preview/open_tile.dart';
import 'package:exam_app/screens/admins/home/default_screen.dart';
import 'package:exam_app/screens/admins/home/exam_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExamPreview extends StatefulWidget {
  const ExamPreview({Key? key}) : super(key: key);

  @override
  State<ExamPreview> createState() => _ExamPreview();
}

class _ExamPreview extends State<ExamPreview> {
  @override
  Widget build(BuildContext context) {
    final exams = Provider.of<List<MyExam>>(context);
    //bool show = false;
    final questionlist = [];
    debugPrint(questionlist.length.toString());
    return ListView.builder(
          itemCount: exams.length,
          itemBuilder: (context, index) {
            return Column(children: [
              OpenTile(exam: exams[index]),
              MultipleChoiceTile(exam: exams[index]),
              CodeCorrectionTile(exam: exams[index]),
            ],);
          },
          
        );
  }
}
