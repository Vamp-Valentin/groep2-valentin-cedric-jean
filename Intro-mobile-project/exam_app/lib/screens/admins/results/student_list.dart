import 'package:exam_app/models/my_exam.dart';
import 'package:exam_app/screens/admins/home/exam_tile.dart';
import 'package:exam_app/screens/admins/location/location_on_map.dart';
import 'package:exam_app/services/database.dart';
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
    final stulist = [];
    for (var ex in exams) {
      for (var stu in splitStudents(ex.students.toString())) {
        // if (stulist.contains(stu)) {
          stulist.add(stu);
          DatabaseService(uid: stu).updateStudentData(
              stu,
              "question",
              "openanswer",
              "codecoransw",
              "multiplAnswer",
              10,
              "lat",
              "longlat");
        }
      //}
    }
    for (int i = 0; i < stulist.length; i++) {
      return ListView.builder(
        itemCount: stulist.length,
        itemBuilder: (context, index) {
          debugPrint(stulist.toString());
          return ListTile(
            leading: const CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.red,
              child: Icon(Icons.account_circle),
            ),
            title: Text(stulist[index]),
            trailing: Wrap(children: [
              TextButton(
                  child: Text("Location"),
                  onPressed: () async {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => LocationOnMap()));
                  }),
              Icon(Icons.keyboard_arrow_right),
            ]),
          );
        },
      );
    }
    return Container();
  }

  List splitStudents(String? students) {
    List splitList = [];
    final splitstudents = students?.split(';');
    if (splitstudents != null) {
      for (int i = 0; i < splitstudents.length; i++) {
        splitList.add(splitstudents[i]);
      }
    }
    return splitList;
  }
}
