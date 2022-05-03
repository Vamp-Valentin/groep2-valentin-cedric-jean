import 'package:exam_app/models/my_user.dart';
import 'package:exam_app/screens/authenticate/authenticate.dart';
import 'package:exam_app/screens/authenticate/sign_in_student.dart';
import 'package:exam_app/screens/authenticate/sign_in_default.dart';
import 'package:exam_app/screens/students/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    print(user);

    //return home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
