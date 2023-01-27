

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sig_mobile_project/models/response.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference _collection = firestore.collection('missionLivreur');

class FirebaseServices {
  //////////////////////////////////////////// Create Mission record //////////////////////////////////
  static Future<Response> addMission(
      {required String desc,
      required String quant,
      required String nameLivreur,
      required String lnglat}) async {
    Response response = Response();
    DocumentReference documentReference = _collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "description": desc,
      "quantite": quant.toString(),
      "nameLivreur": nameLivreur,
      "lnglat": lnglat
    };
    var result = await documentReference.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Successfully added to db";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });
    return response;
  }
  //////////////////////////////////////////// Read Mission record //////////////////////////////////

  static Stream<QuerySnapshot> readMission() {
    CollectionReference notesItemCollection = _collection;

    return notesItemCollection.snapshots();
  }

  //////////////////////////////////////////// Read Livreurs record //////////////////////////////////


  //////////////////////////////////////////// Update Mission record //////////////////////////////////

  static Future<Response> updateMission({
    required String desc,
    required String quant,
    required String nameLivreur,
    required String lnglat,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReference = _collection.doc(docId);
    Map<String, dynamic> data = <String, dynamic>{
      "description": desc,
      "quantite": quant.toString(),
      "nameLivreur": nameLivreur,
      "coord": lnglat
    };

    await documentReference.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Successfully updated Misson";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });
    return response;
  }

  //////////////////////////////////////////// Delete Mission record //////////////////////////////////
  static Future<Response> deleteMission({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReference = _collection.doc(docId);

    await documentReference.delete().whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully Deleted Mission";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
