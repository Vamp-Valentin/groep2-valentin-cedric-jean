import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_user.dart';
import 'package:exam_app/screens/admins/exam_preview/exam.dart';
import 'package:exam_app/screens/admins/home/homeAdmin.dart';
import 'package:exam_app/screens/authenticate/authenticate.dart';
import 'package:exam_app/screens/authenticate/sign_in_student.dart';
import 'package:exam_app/screens/authenticate/sign_in_default.dart';
import 'package:exam_app/screens/students/exam/startExam.dart';
import 'package:exam_app/screens/students/exam/timer.dart';
import 'package:exam_app/screens/students/location/location.dart';
import 'package:exam_app/screens/wrapper.dart';
import 'package:exam_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../admins/questions/question_home.dart';

class Home extends StatefulWidget {
  //const Home({Key? key}) : super(key: key);
  final toggleView;
  const Home({Key? key, this.toggleView}) : super(key: key);  
  

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  User? user = FirebaseAuth.instance.currentUser;
  MyUser loggedInUser = MyUser();

  @override
  void initState() {
    super.initState();
    if(user?.uid != null){
    FirebaseFirestore.instance.collection("users").doc(user!.uid).get().then(
        (value) => {
              this.loggedInUser = MyUser.fromMap(value.data()),
              setState(() {})
            });
  }}

  @override
  Widget build(BuildContext context) {
    //startexam button
    final examButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: ()async {
          Navigator.of(context).pushReplacement(
               MaterialPageRoute(builder: (context) => CompleteExam()));
              //MaterialPageRoute(builder: (context) => TimerWidget()));
        },
        child: Text(
          "Start exam",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Welcome"),
        centerTitle: true,
        actions: <Widget>[
          ActionChip(
              label: Text("Logout"),
              onPressed: () async{
                //logout(context);
                _auth.signOut();
              })
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 180,
                child: Image.asset(
                  "assets/apLogo.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              examButton,
              
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        //MaterialPageRoute(builder: (context) => defaultLoginPage()));
        MaterialPageRoute(builder: (context) => Authenticate()));
  }
}
