import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_exam.dart';
import 'package:exam_app/screens/admins/questions/code_correction.dart';
import 'package:exam_app/screens/admins/questions/multiple_choice.dart';
import 'package:exam_app/screens/admins/questions/open.dart';
import 'package:exam_app/screens/admins/questions/question_home.dart';
import 'package:exam_app/screens/admins/students/add_students.dart';
import 'package:exam_app/screens/authenticate/authenticate.dart';
import 'package:exam_app/screens/authenticate/sign_in_admin.dart';
import 'package:exam_app/screens/authenticate/sign_in_default.dart';
import 'package:exam_app/screens/wrapper.dart';
import 'package:exam_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeAdmin extends StatefulWidget {
  HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
  
}

class _HomeAdminState extends State<HomeAdmin> {
  //final _auth = FirebaseAuth.instance;
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
          "Exams",
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
          "Students",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("Exams"),
          centerTitle: true,
          actions: <Widget>[
            ActionChip(
                label: Text("Logout"),
                onPressed: () async{
                  //logout(context);
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
                ],
              )),
            ),
          )),
        )
        );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => defaultLoginPage()));
  }
}
