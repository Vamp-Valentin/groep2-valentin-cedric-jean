import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/screens/students/exam/startExam.dart';
import 'package:exam_app/screens/students/location/location.dart';
import 'package:flutter/material.dart';

import 'package:exam_app/models/my_exam.dart';
import 'package:provider/provider.dart';

class TimerWidget extends StatefulWidget {
  //const StartExam({ Key? key }) : super(key: key);

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  final MyExam? exam;
  _TimerWidgetState({this.exam});

  Timer? countdownTimer;
  Duration myDuration = Duration(days: 5);
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(days: 5));
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(num? n) => n.toString().padLeft(2, '0');
    num minute = 0;

    final hours = strDigits(myDuration.inHours.remainder(1));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Material(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => CompleteExam(student: "",))),
          ),
          backgroundColor: Colors.red,
          title: Text("time Left"),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('exams').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return Text("");
              minute = snapshot.data!.docs[0].get('timer');
              String minutes =
                  strDigits(myDuration.inMinutes.remainder(minute));
              return Container(
                  child: Text(
                '$hours:$minutes:$seconds',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 50),
              ));
            }),
      ),
    );
  }
}
