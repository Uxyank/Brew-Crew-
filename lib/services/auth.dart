import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on userCredential
  UserOne? _useroneFromuserCredential(User? user) {
    return user != null ? UserOne(user.uid) : null;
  }

  // auth change stream
  Stream<User?> get user {
    return _auth.authStateChanges().map(
          (User? user) => (user != null) ? user : null,
        );
  }

  Stream<UserOne?> get user1 {
    return _auth.authStateChanges().map(_useroneFromuserCredential);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      //return _auth.currentUser;
      return _useroneFromuserCredential(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user!;

      await DatabaseService(user.uid)
          .updateUserData('New crew member', '0', 100);
      return _useroneFromuserCredential(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user!;

      // Create a new document for the user with the uid

      await DatabaseService(user.uid)
          .updateUserData('New crew member', '0', 100);

      return _useroneFromuserCredential(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('You are here: signOut, ${e.toString()}');
      return null;
    }
  }
}
