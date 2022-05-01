class MyUser {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;

  MyUser({this.uid, this.email, this.firstName, this.lastName});

  //get data from database
  factory MyUser.fromMap(map){
    return MyUser(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName']
    );
  }

  //send data to database
  Map<String, dynamic> toMap(){
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName
    };
  }
}