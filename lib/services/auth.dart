import 'package:signup_login/models/current_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signup_login/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CurrentUser? newUser;

  // create user object based on firebase user
  CurrentUser? _userFromFirebase(User? user) {
    return user != null ? CurrentUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<CurrentUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
    // .map((User user) => _userFromFirebaseUser(user));
  }

  // Get current user
  Future<CurrentUser?> currentUser() async {
    final user = _auth.currentUser;
    return _userFromFirebase(user!);
  }

  // sign in anonymously
  // Future signInAnon() async {
  //   try {
  //     UserCredential authResult = await _auth.signInAnonymously();
  //     User? user = authResult.user;
  //     return _userFromFirebase(user);
  //   } catch (error) {
  //     print(error.toString());
  //     return null;
  //   }
  // }

  // login with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebase(user!);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // create user account with email and password
  Future createUserWithEmailAndPassword(
      String email, String phoneNumber, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).createOrUpdateUserData(
          email: email, phoneNumber: phoneNumber, password: password);
      return _userFromFirebase(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future logout() async {
    try {
      print('logged out');
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
