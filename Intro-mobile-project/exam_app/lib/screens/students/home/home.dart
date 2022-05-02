import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_user.dart';
import 'package:exam_app/screens/admins/home/homeAdmin.dart';
import 'package:exam_app/screens/authenticate/authenticate.dart';
import 'package:exam_app/screens/authenticate/sign_in_student.dart';
import 'package:exam_app/screens/authenticate/sign_in_default.dart';
import 'package:exam_app/screens/wrapper.dart';
import 'package:exam_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
              Text(
                "Welcome back",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${loggedInUser.firstName} ${loggedInUser.lastName}",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w500),
              ),
              Text(
                "${loggedInUser.email}",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w500),
              ),
              Text(
                "${loggedInUser.isAdmin}",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
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
// class Home extends StatelessWidget {
//   final AuthService _auth = AuthService();
//   Home({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.red,
//         title: Text("Welcome"),
//         centerTitle: true,
//         actions: <Widget>[ActionChip(label: Text("Logout"), onPressed: (){
//           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
//         })],
//       ),
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(
//                 height: 180,
//                 child: Image.asset(
//                   "assets/apLogo.png",
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               Text(
//                 "Welcome back",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "Name",
//                 style: TextStyle(
//                     color: Colors.black54, fontWeight: FontWeight.w500),
//               ),
//               Text(
//                 "Email",
//                 style: TextStyle(
//                     color: Colors.black54, fontWeight: FontWeight.w500),
//               ),
//               SizedBox(height: 15,),
//             ],
//           ),
//         ),
//       ),
//     );
    //   return Scaffold(
    //     backgroundColor: Colors.red[50],
    //     appBar: AppBar(
    //       title: Text("Student"),
    //       backgroundColor: Colors.red[400],
    //       elevation: 0.0,
    //       actions: <Widget>[
    //         FlatButton.icon(
    //           icon: Icon(Icons.person),
    //           label: Text('Logout'),
    //           onPressed: () async{
    //             await _auth.signOut();
    //           },
    //         )
    //       ],
    //     ),
    //   );
    // }
  //}
