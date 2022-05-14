import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('exams').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return Container();
                  minute = snapshot.data!.docs[0].get('timer');
                  String minutes = strDigits(myDuration.inMinutes.remainder(minute));
                  // if (minute > 60){
                  //   double hour = minute/60;
                  //   double min = (minute%60)*6;
                  //   String hours = strDigits(myDuration.inHours.remainder(hour));
                  //   String minutes = strDigits(myDuration.inMinutes.remainder(min));
                  // }
                  // else {
                  //   String hours = strDigits(myDuration.inHours.remainder(1));
                  //   String minutes = strDigits(myDuration.inMinutes.remainder(minute));
                  // }
                  return Text(
                    '$hours:$minutes:$seconds',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 50),
                  );
                }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
