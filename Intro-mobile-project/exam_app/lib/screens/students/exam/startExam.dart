import 'dart:async';

import 'package:flutter/material.dart';

import 'package:exam_app/models/my_exam.dart';
import 'package:provider/provider.dart';

class StartExam extends StatefulWidget {
  //const StartExam({ Key? key }) : super(key: key);


  @override
  State<StartExam> createState() => _StartExamState();
}

class _StartExamState extends State<StartExam> {
final MyExam? exam;
_StartExamState({this.exam});
    
Timer? countdownTimer;
  Duration myDuration = Duration(days: 5);
  @override
  void initState() {
    super.initState();
  }
  /// Timer related methods ///
  // Step 3
  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }
  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }
  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(days: 5));
  }
  // Step 6
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
    final exams = Provider.of<List<MyExam>>(context);
    String strDigits(num? n) => n.toString().padLeft(2, '0');
    // Step 7
    num minutess = exam?.timer as num;
    
    final hours = strDigits(myDuration.inHours.remainder(1));
    final minutes = strDigits(myDuration.inMinutes.remainder(minutess));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            // Step 8
            Text(
              '$hours:$minutes:$seconds',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 50),
            ),
            SizedBox(height: 20),
            // Step 9
            ElevatedButton(
              onPressed: startTimer,
              child: Text(
                'Start',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}