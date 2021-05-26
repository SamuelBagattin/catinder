import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class CatProfilesRecord {
  static CollectionReference collection = FirebaseFirestore.instance.collection(
      "cat_profiles");

  String id;
  String name;
  String picture;
  num age;
  String description;
  String breed;
  String sexe;
  String userId;

  CatProfilesRecord({this.id,
    this.name,
    this.picture,
    this.age,
    this.description,
    this.breed,
    this.sexe, this.userId});

  factory CatProfilesRecord.fromMap(String id, Map map) {
    return new CatProfilesRecord(
        age: map["age"],
        breed: map["breed"],
        description: map["description"],
        id: map["id"],
        name: map["name"],
        picture: map["picture"],
        sexe: map["sexe"],
        userId: map["userId"]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'age': this.age,
      'breed': this.breed,
      'description': this.description,
      'id': this.id,
      'name': this.name,
      'picture': this.picture,
      'sexe': this.sexe,
      'userId': this.userId,
    };
  }

}

class InsertCatProfileQuery {
  static CollectionReference collection = FirebaseFirestore.instance.collection(
      "cat_profiles");

  String name;
  String picture;
  num age;
  String description;
  String breed;
  String sexe;
  String userId;

  InsertCatProfileQuery({
    this.name,
    this.picture,
    this.age,
    this.description,
    this.breed,
    this.sexe,
    this.userId});

  factory InsertCatProfileQuery.fromMap(String id, Map map) {
    return new InsertCatProfileQuery(
        age: map["age"],
        breed: map["breed"],
        description: map["description"],
        name: map["name"],
        picture: map["picture"],
        sexe: map["sexe"],
        userId: map["userId"]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'age': this.age,
      'breed': this.breed,
      'description': this.description,
      'name': this.name,
      'picture': this.picture,
      'sexe': this.sexe,
      'userId': this.userId,
    };
  }

}

Stream<List<CatProfilesRecord>> queryCatProfilesRecord() {
  return FirebaseFirestore.instance.collection('cat_profiles').snapshots().map(
          (event) =>
          event.docs
              .map((e) => CatProfilesRecord.fromMap(e.id, e.data()))
              .toList());
}

Future<void> addOrModifyCatProfile(InsertCatProfileQuery catProfile) async {
  final doc = await CatProfilesRecord.collection.where('userId', isEqualTo: catProfile.userId).get();
  if (doc.size != 0) {
    await CatProfilesRecord.collection.doc(doc.docs.first.id).set(catProfile.toMap());
  } else {
    await CatProfilesRecord.collection.add(catProfile.toMap());
  }
}

Future<CatProfilesRecord> getCatProfileFromUserId(String userId) async {
  final doc =  (await CatProfilesRecord.collection.where('userId', isEqualTo: userId).get()).docs.first;
  if(doc.exists) {
    return CatProfilesRecord.fromMap(doc.id, doc.data());
  }
  return null;
}

List<CatProfilesRecord> createDummyCatProfilesRecord({num count}) {
  return Iterable<int>.generate(10).toList().map((e) =>
      CatProfilesRecord(
          id: "",
          breed: "Breed",
          age: 10,
          description: "Description",
          name: "Name",
          picture:
          "data:image/jpeg;base64,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",
          sexe: "Rien"));
}
