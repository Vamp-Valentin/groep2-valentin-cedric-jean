import 'package:exam_app/screens/authenticate/sign_in_default.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeAdmin extends StatefulWidget {
  HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Welcome"),
        centerTitle: true,
        actions: <Widget>[
          ActionChip(
              label: Text("Logout"),
              onPressed: () {
                logout(context);
              })
        ],
      ),
    );
  }
    Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => defaultLoginPage()));
  }
}