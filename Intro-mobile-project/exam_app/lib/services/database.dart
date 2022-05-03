import 'package:cloud_firestore/cloud_firestore.dart';

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

  //get exam stream
  Stream<QuerySnapshot> get exams {
    return examCollection.snapshots();
  }
}
