import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_user.dart';
import 'package:exam_app/screens/admins/home/homeAdmin.dart';
import 'package:exam_app/screens/authenticate/register.dart';
import 'package:exam_app/screens/authenticate/sign_in_default.dart';
import 'package:exam_app/screens/authenticate/sign_in_student.dart';
import 'package:exam_app/screens/students/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loggedInUser.uid == null){
      debugPrint("defaultLoginPage in authenticate class");
      return defaultLoginPage();
    }
    if (loggedInUser.isAdmin == true && loggedInUser.uid != null) {
      debugPrint("homePageAdmin in authenticate class");
      return HomeAdmin();
    } 
    else {
    debugPrint("homePage in authenticate class");
     return Home();
    }
    }
  }
