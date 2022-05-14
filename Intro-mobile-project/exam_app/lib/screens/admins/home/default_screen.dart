import 'package:exam_app/models/my_exam.dart';
import 'package:exam_app/screens/admins/change_password/change_pass.dart';
import 'package:exam_app/screens/admins/exam_preview/exam.dart';
import 'package:exam_app/screens/admins/exam_preview/exam_preview.dart';
import 'package:exam_app/screens/admins/home/homeAdmin.dart';
import 'package:exam_app/screens/admins/questions/question_home.dart';
import 'package:exam_app/screens/admins/results/results.dart';
import 'package:exam_app/screens/admins/students/add_students.dart';
import 'package:exam_app/screens/authenticate/sign_in_default.dart';
import 'package:exam_app/services/auth.dart';
import 'package:exam_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exam_app/screens/admins/home/exam_list.dart';


class HomeAdmin extends StatefulWidget {
  //const HomeAdmin1({Key? key}) : super(key: key);
  final toggleView;
  const HomeAdmin({Key? key, this.toggleView}) : super(key: key);  

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
  
}

class _HomeAdminState extends State<HomeAdmin> {
  final AuthService _auth = AuthService();
  final examNameEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    //exam button
    final examButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MainQuestions()));
        },
        child: Text(
          "Create exam",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    //students button
    final studentButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AddStudent()));
        },
        child: Text(
          "Grade",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    //results button
    final resultButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Results()));
        },
        child: Text(
          "Results",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    //preview button
    final previewButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Exam()));
        },
        child: const Text(
          "Exam preview",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    //change password button
    final passwordButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => ChangePass()));
        },
        child: const Text(
          "Change Password",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return StreamProvider<List<MyExam>?>.value(
      initialData: [],
      value: DatabaseService().exams,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text("Menu"),
            centerTitle: true,
            actions: <Widget>[
              ActionChip(
                  label: Text("Logout"),
                  onPressed: () async{
                    await _auth.signOut();
                  })
            ],
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
                    SizedBox(height: 25),
                    examButton,
                    SizedBox(height: 25),
                    studentButton,
                    SizedBox(height: 25),
                    resultButton,
                    SizedBox(height: 25),
                    previewButton,
                    SizedBox(height: 25),
                    passwordButton
                  ],
                )),
              ),
            )),
          )
          ),
    );
  }
}