import 'package:brew_crew/models/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  // Colection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');
  Future updateUserData(String sugars, String name, int strenght) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strenght': strenght,
    });
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print('-----------------------------------------');
      //print('name : ${doc['name']}');
      //print('sugars : ${doc['sugars']}');
      //print('strenght : ${doc['strength']}'); //error is here!
      //print('=========================================');
      return Brew(
        name: doc['name'] ?? '',
        sugars: doc['sugars'] ?? '0',
        strength: doc['strength'] ?? 0, //error is here!
      );
    }).toList();
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }
}

// name: doc.data()['name'],
// strength: doc.data()['strenght'],
// sugars: doc.data()['sugars'],
