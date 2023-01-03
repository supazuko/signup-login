import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signup_login/models/user.dart';
import 'package:signup_login/models/current_user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> createOrUpdateUserData(
      {required String email,
      required String password,
      required String phoneNumber}) async {
    return await userCollection.doc(uid).set({
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
    });
  }

  // user list from snapshot
  // List<User> _userListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     //print(doc.data);
  //     return User(
  //         email: doc['email'] ?? '',
  //         phoneNumber: doc['phone number'] ?? '',
  //         password: doc['password'] ?? '');
  //   }).toList();
  // }

  // // get user stream
  // Stream<List<User>> get users {
  //   return userCollection.snapshots().map(_userListFromSnapshot);
  // }
}
