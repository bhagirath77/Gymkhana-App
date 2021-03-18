import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class DatabaseServices {
  final _firestoreInstance = FirebaseFirestore.instance;

  Future<void> addUser({@required User user}) async {
    final collectionReference = _firestoreInstance.collection('users');
    await collectionReference.doc(user.uid).set(<String, dynamic>{
      'name': user.displayName,
      'email': user.email,
      'accountcreated': Timestamp.now(),
      'photoUrl': user.photoURL,
    });
  }

  Future<void> updatePostData(
      {Map<String, dynamic> postData, String id}) async {
    if (id == null) {
      await _firestoreInstance.collection('posts').add(postData);
    } else {
      await _firestoreInstance.doc('posts/$id').update(postData);
    }
  }

  Future<void> addComment(
      {@required String path,
      @required Map<String, dynamic> commentData}) async {
    print('posts/$path');
    await _firestoreInstance.collection('posts/$path').add(commentData);
  }
}
