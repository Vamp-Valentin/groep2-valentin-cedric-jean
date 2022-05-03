import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_exam.dart';
import 'package:exam_app/models/my_user.dart';
import 'package:exam_app/screens/authenticate/authenticate.dart';
import 'package:exam_app/screens/authenticate/register.dart';
import 'package:exam_app/screens/students/dropdown/student_dropdown.dart';
import 'package:exam_app/screens/students/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:exam_app/services/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInStudent extends StatefulWidget {
  //final Function toggleView;
  //SignIn({required this.toggleView});

  @override
  State<SignInStudent> createState() => _SignInStudentState();
}

class _SignInStudentState extends State<SignInStudent> {
  //auth class
  //final AuthService _auth = AuthService();

  //from key
  //final _formkey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;

  //text field state
  String email = '';
  String password = '';

  User? user = FirebaseAuth.instance.currentUser;
  MyUser loggedInUser = MyUser();
  MyExam exam = MyExam();

  // @override
  // void initState() {
  //   super.initState();
  //   if(user?.uid != null){
  //   FirebaseFirestore.instance.collection("exams").doc(user!.uid).get().then(
  //       (value) => {
  //             this.exam = MyExam.fromMap(value.data()),
  //             setState(() {})
  //           });
  // }}

  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'One';
    //email
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      // auth class
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your email";
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return "Please enter a valid email";
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //password
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return "Password is required";
        }
        if (!regex.hasMatch(value)) {
          return "Please enter valid password, min 6 characters!";
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //button
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          //signIn(emailController.text, passwordController.text);
        },
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StudentDropdown(),
    );
    // return Scaffold(
    //     backgroundColor: Colors.white,
    //     body: Center(
    //       child: SingleChildScrollView(
    //           child: Container(
    //         color: Colors.white,
    //         child: Padding(
    //           padding: const EdgeInsets.all(36.0),
    //           child: Form(
    //               key: _formkey,
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: <Widget>[
    //                   SizedBox(
    //                       height: 200,
    //                       child: Image.asset(
    //                         "assets/apLogo.png",
    //                         fit: BoxFit.contain,
    //                       )),
    //                   SizedBox(height: 45),
    //                   emailField,
    //                   SizedBox(height: 25),
    //                   passwordField,
    //                   SizedBox(height: 35),
    //                   loginButton,
    //                   SizedBox(height: 15),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: <Widget>[
    //                       Text("Dont have an account? "),
    //                       GestureDetector(
    //                         onTap: () {
    //                           Navigator.push(context, MaterialPageRoute(builder: (context)=> Register()));
    //                         },
    //                         child: Text(
    //                           "SignUp",
    //                           style: TextStyle(
    //                             color: Colors.redAccent,
    //                               fontWeight: FontWeight.bold,
    //                               fontSize: 15),
    //                         ),
    //                       )
    //                     ],
    //                   )
    //                 ],
    //               )),
    //         ),
    //       )),
    //     ));
    // return Scaffold(
    //   backgroundColor: Color.fromARGB(255, 252, 237, 238),
    //   appBar: AppBar(
    //     backgroundColor: Colors.red[400],
    //     elevation: 0.0,
    //     title: Text('Sign in'),
    //     actions: <Widget>[
    //       FlatButton.icon(
    //         icon: Icon(Icons.person),
    //         label: Text('Register'),
    //         onPressed: () {
    //           widget.toggleView();
    //         })
    //     ],
    //   ),
    //   body: Container(
    //     padding: EdgeInsets.symmetric(vertical:20.0, horizontal: 50.0),
    //     child: Form(
    //       key: _fromkey,
    //       child: Column(
    //         children: <Widget>[
    //           SizedBox(height: 20.0),
    //           TextFormField(
    //             onChanged: (val) {
    //               setState(() => email = val);
    //             }
    //           ),
    //           SizedBox(height: 20.0),
    //           TextFormField(
    //             obscureText: true,
    //             onChanged: (val) {
    //               setState(() => password = val);

    //             },
    //           ),
    //           SizedBox(height: 20.0),
    //           ElevatedButton(
    //                 child: Text('Sign in'),
    //                 style: ButtonStyle(
    //                     backgroundColor:
    //                         MaterialStateProperty.all(Colors.pink[400]),
    //                     textStyle: MaterialStateProperty.all(
    //                         TextStyle(color: Colors.white))),
    //                 onPressed: () async {
    //                   if (_fromkey.currentState!.validate()){
    //                     print(email);
    //                     print(password);
    //                   }
    //                 },
    //               )
    //         ],
    //       ),
    //     )
    // ));
  }

  //login function ->> auth class
  // void signIn(String email, String password) async {
  //   if (_formkey.currentState!.validate()) {
  //     await _auth
  //         .signInWithEmailAndPassword(email: email, password: password)
  //         .then((uid) => {
  //               Fluttertoast.showToast(msg: "Login Successful!"),
  //               Navigator.of(context).pushReplacement(
  //                   MaterialPageRoute(builder: (context) => Home())),
  //             })
  //         .catchError((e) {
  //       Fluttertoast.showToast(msg: e!.message);
  //     });
  //   }
  // }
}
