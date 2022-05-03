import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_exam.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference examCollection =
      FirebaseFirestore.instance.collection('exams');

  Future updateUserData(
      String examName, String openQuestion, String students) async {
    return await examCollection.doc(uid).set({
      'uid': uid,
      'examName': examName,
      'openQuestion': openQuestion,
      'students': students,
    });
  }

  //exam list from snapshot
  List<MyExam> _examListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return MyExam(
        uid: doc.get('uid'),
        examName: doc.get('examName'),
        openQuestion: doc.get('openQuestion'),
        students: doc.get('students'),
      );
    }).toList();
  }

  //get exam stream
  Stream<List<MyExam>> get exams {
    return examCollection.snapshots()
    .map(_examListFromSnapshot);
  }
}
