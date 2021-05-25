import 'package:cloud_firestore/cloud_firestore.dart';

class CatProfilesRecord {
  String id;
  String name;
  String picture;
  num age;
  String description;
  String breed;
  String sexe;

  CatProfilesRecord(
      {this.id,
      this.name,
      this.picture,
      this.age,
      this.description,
      this.breed,
      this.sexe});

  factory CatProfilesRecord.fromMap(String id, Map map) {
    return new CatProfilesRecord(
      age: map["age"],
      breed: map["breed"],
      description: map["description"],
      id: map["id"],
      name: map["name"],
      picture: map["picture"],
      sexe: map["sexe"],
    );
  }
}

Stream<List<CatProfilesRecord>> queryCatProfilesRecord() {
  return FirebaseFirestore.instance.collection('cat_profiles').snapshots().map(
      (event) =>
          event.docs.map((e) => CatProfilesRecord.fromMap(e.id, e.data())).toList());
}
