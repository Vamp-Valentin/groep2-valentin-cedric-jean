import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_exam.dart';
import 'package:exam_app/models/my_user.dart';
import 'package:exam_app/screens/admins/home/default_screen.dart';
import 'package:exam_app/screens/admins/home/homeAdmin.dart';
import 'package:exam_app/screens/admins/questions/code_correction.dart';
import 'package:exam_app/screens/admins/questions/multiple_choice.dart';
import 'package:exam_app/screens/admins/questions/open.dart';
import 'package:exam_app/screens/admins/students/add_students.dart';
import 'package:exam_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class MainQuestions extends StatefulWidget {
  MainQuestions({Key? key}) : super(key: key);
  @override
  State<MainQuestions> createState() => _MainQuestionsState();
}

class _MainQuestionsState extends State<MainQuestions> {
  final _auth = FirebaseAuth.instance;
  final examNameEditingController = new TextEditingController();
  final timerEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final MyExam exam;
    final user = Provider.of<MyUser>(context);
    //exam Name
    final examNameField = TextFormField(
      autofocus: false,
      controller: examNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{2,}$');
        if (value!.isEmpty) {
          return "Question name is required!";
        }
        if (!regex.hasMatch(value)) {
          return "Please enter valid question!";
        }
        return null;
      },
      onSaved: (value) {
        examNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Exam name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //timer
    final timerField = TextFormField(
      autofocus: false,
      controller: timerEditingController,
      keyboardType: TextInputType.number,
      validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Please enter amount of minutes';
              }
              return null;
            },
      onSaved: (value) {
        timerEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.timer),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Minutes",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //open Question
    final openQuestionButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => Open()));
        },
        child: Text(
          "Open Question",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    //multiple choise question
    final multipleChoiseQuestionButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MultipleChoice()));
        },
        child: Text(
          "Multiple choise question",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    //multiple choise question
    final codeCorrectionQuestionButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => CodeCorrection()));
        },
        child: Text(
          "Code correction question",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    //add students
    final addStudentsButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.green,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width / 3,
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AddStudent()));
        },
        child: Text(
          "Add students",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    //save button
    final saveButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width / 3,
        onPressed: () async {
          DatabaseService(uid: user.uid).updateExamName(examNameEditingController.text);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeAdmin()));
        },
        child: Text(
          "save",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    //save button
    final cancelButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.grey,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width / 3,
        onPressed: () async {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeAdmin()));
        },
        child: Text(
          "cancel",
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
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeAdmin())),
          ),
          backgroundColor: Colors.red,
          title: Text("Exams"),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Container(
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
                  examNameField,
                  SizedBox(height: 25),
                  timerField,
                  SizedBox(height: 25),
                  openQuestionButton,
                  SizedBox(height: 25),
                  multipleChoiseQuestionButton,
                  SizedBox(height: 25),
                  codeCorrectionQuestionButton,
                  SizedBox(height: 100),
                  addStudentsButton,
                  SizedBox(height: 25),
                  saveButton,
                  SizedBox(height: 25),
                  cancelButton,
                ],
              )),
            ),
          )),
        ));
  }
}
