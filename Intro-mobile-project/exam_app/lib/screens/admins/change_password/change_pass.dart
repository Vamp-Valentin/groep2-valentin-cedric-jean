import 'package:exam_app/screens/students/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/my_exam.dart';
import '../home/exam_tile.dart';

class ChangePass extends StatefulWidget {

  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {


    final formkey = GlobalKey<FormState>();

    var newPassword = " ";

    final newPasswordController = TextEditingController();

    @override
    void dispose() {
      newPasswordController.dispose();
      super.dispose();
    }

    final currentUser = FirebaseAuth.instance.currentUser;

    changePassword() async{
      try{
         await currentUser!.updatePassword(newPassword);
         FirebaseAuth.instance.signOut();
        Navigator.pushReplacement (context, MaterialPageRoute(builder: (context) => Home(),
        ),
        );
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black26,
            content: Text(' Your password has been Changed.. Login again!'),
         ),
         );
      } catch(error){ }
    }

  //       ElevatedButton (onPressed: (){
  //     if(_formkey.currentState!.validate()){
  //         setState((){
  //         newPassword=newPasswordController.text;
  //       });
  //         changePassword();
  //       }
  //     });
  // }
}
