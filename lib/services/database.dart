// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Project imports:
import 'package:smart_retail/constants.dart';
// import 'package:smart_retail/model/user_detail.dart';

// final CollectionReference _mainCollection = _firestore.collection('notes');

class Database {
  String? userUid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Future<void> addItem(
  //     {required UserDetail userDetail, required String collectionName}) async {
  //   DocumentReference documentReferencer =
  //       _firestore.collection(collectionName).doc(userUid);

  //   await documentReferencer
  //       .set(userDetail)
  //       .whenComplete(() => debugPrint("Notes item added to the database"))
  //       .catchError((e) => debugPrint(e));
  // }

  Stream<DocumentSnapshot<Map<String, dynamic>>> readItems(
      {required String collectionName}) {
    DocumentReference<Map<String, dynamic>> notesItemCollection =
        _firestore.collection(collectionName).doc(userUid);

    return notesItemCollection.snapshots();
  }

  Future<void> updateItem(
      {required String title,
      required String description,
      required String docId,
      required String collectionName}) async {
    DocumentReference documentReferencer =
        _firestore.collection(collectionName).doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => debugPrint("Note item updated in the database"))
        .catchError((e) => debugPrint(e));
  }

  Future<void> deleteItem(
      {required String docId, required String collectionName}) async {
    DocumentReference documentReferencer =
        _firestore.collection(collectionName).doc(docId);
    await documentReferencer
        .delete()
        .whenComplete(() => debugPrint('Item deleted from the database'))
        .catchError((e) => debugPrint(e));
  }

  static String? getCurrentUser() {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      debugPrint(auth.currentUser?.uid);
      return auth.currentUser?.uid;
    }
    return null;
  }

  void deleteFirebaseUser(String email, String password, String collectionName,
      String docId) async {
    try {
      UserCredential? userCredentials = await logInUser(email, password);
      if (userCredentials?.user != null) {
        await deleteItem(docId: docId, collectionName: collectionName);
        await userCredentials?.user?.delete();
        Fluttertoast.showToast(
            msg: 'Deleted Record Sucessfully', backgroundColor: kBtnColor);
      } else {
        Fluttertoast.showToast(
            msg: 'No Record deleted', backgroundColor: kBtnColor);
      }
      // await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        debugPrint(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }

  Future<UserCredential?> logInUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }
      return null;
    }
  }

  dynamic authenticaTeUser(String email, String password) async {
// Create a credential
    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: password);

// Reauthenticate
    await FirebaseAuth.instance.currentUser!
        .reauthenticateWithCredential(credential);
  }
}
