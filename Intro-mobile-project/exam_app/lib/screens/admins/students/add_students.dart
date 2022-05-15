import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_exam.dart';
import 'package:exam_app/models/my_user.dart';
import 'package:exam_app/screens/admins/home/default_screen.dart';
import 'package:exam_app/screens/admins/home/homeAdmin.dart';
import 'package:exam_app/screens/admins/questions/question_home.dart';
import 'package:exam_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddStudent extends StatefulWidget {
  AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final addStudentsEditingController = new TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    final addStudentsField = TextFormField(
      autofocus: false,
      controller: addStudentsEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{5,}$');
        if (value!.isEmpty) {
          return "S-Number is required!";
        }
        if (!regex.hasMatch(value)) {
          return "Please enter valid student!";
        }
        return null;
      },
      onSaved: (value) {
        addStudentsEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 80, 20, 80),
          hintText: "S-numbers, separated with ';' ",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //save button
    final saveButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          DatabaseService(uid: user.uid)
              .updateStudents(addStudentsEditingController.text);
          CreateStudents(addStudentsEditingController.text);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainQuestions()));
        },
        child: Text(
          "save",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MainQuestions())),
          ),
          backgroundColor: Colors.red,
          title: Text("Grade"),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
              child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                  //key: _formkey,
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  addStudentsField,
                  SizedBox(height: 40),
                  saveButton,
                ],
              )),
            ),
          )),
        ));
  }

  List CreateStudents(String? students) {
    List splitList = [];
    final splitstudents = students?.split(';');
    if (splitstudents != null) {
      for (int i = 0; i < splitstudents.length; i++) {
        splitList.add(splitstudents[i]);
        DatabaseService(uid: splitstudents[i]).updateStudentData(
            splitstudents[i],
            "question",
            "openanswer",
            "codecoransw",
            "multiplAnswer",
            0,
            "latitude",
            "longlatitude");
      }
    }
    return splitList;
  }
}
