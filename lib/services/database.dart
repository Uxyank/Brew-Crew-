import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService(this.uid);

  final CollectionReference<Map<String, dynamic>> brewCollection =
      FirebaseFirestore.instance.collection("brews");

  Future<void> updateUserData(String name, String sugars, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  List<Brew> _brewListFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      var data = doc.data();
      return Brew(
        //uid: uid,
        name: data['name'] ?? '',
        sugars: data['sugars'] ?? '0',
        strength: data['strength'] ?? 0,
      );
    }).toList();
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  UserData _userDataFromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("User not found");
    return UserData(
      uid: uid,
      name: data['name'] ?? '',
      sugars: data['sugars'] ?? '0',
      strength: data['strength'] ?? 0,
    );
  }

  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
