import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// name: doc.data()['name'],
// strength: doc.data()['strenght'],
// sugars: doc.data()['sugars'],

class DatabaseService {
  final String uid;

  DatabaseService(this.uid);

  final CollectionReference<Map<String, dynamic>> brewCollection =
      FirebaseFirestore.instance.collection("brews");

  Future<void> updateUserData(String sugars, String name, int strenght) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strenght': strenght,
    });
  }

  Brew _brewFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("Brew not found");
    print('-------------------------');
    print(uid.runtimeType);
    return Brew(
      uid: uid,
      name: data['name'] ?? '',
      sugars: data['sugars'] ?? '0',
      strength: data['strength'] ?? 0,
    );
  }

  Stream<Brew> get brew {
    return brewCollection.doc(uid).snapshots().map(_brewFromSnapshot);
  }

  List<Brew> _brewListFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return _brewFromSnapshot(doc);
    }).toList();
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }
}
