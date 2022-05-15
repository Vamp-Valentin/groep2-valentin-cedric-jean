import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_student.dart';
import 'package:exam_app/screens/students/dropdown/student_dropdown.dart';
import 'package:exam_app/screens/students/home/home.dart';
import 'package:exam_app/services/auth.dart';
import 'package:exam_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

class Grading{

  int gradeQuestion(String answer, String studentAnswer, int result) {
    if (answer == studentAnswer){
      result += 1;
    }
    return result;
  }
}
