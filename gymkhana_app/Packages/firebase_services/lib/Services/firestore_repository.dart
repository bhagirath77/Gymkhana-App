import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_services/firebase_repository.dart';
import 'package:flutter/cupertino.dart';

class FirestoreRepository {
  FirestoreRepository({@required String uid}) : _uid = uid;
  final _firestoreInstance = FirebaseFirestore.instance;
  final String _uid;
  final CollectionReference _postsCollection =
      FirebaseFirestore.instance.collection('posts');

  String get id => _uid;

  Future<DocumentSnapshot> get currentUser async {
    print('$_uid is the user id');
    return await _firestoreInstance.collection('users').doc(_uid).get();
  }

  Stream<List<PostItem>> get snapshotStream =>
      _postsCollection.snapshots().map(_getPostItem);

  Stream getCommentsStream(String id) {
    return _firestoreInstance
        .collection('posts/$id/comments')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Stream<List<PostItem>> searchPosts({String searchTerm, String clubName}) {
    print('function called');
    if (clubName == null) {
      print('running searches');
      return _postsCollection
          .where('description', isGreaterThanOrEqualTo: searchTerm)
          .where('description', isLessThanOrEqualTo:'$searchTerm\uf8ff')
          .snapshots()
          .map(_getPostItem) ?? null;
    } else {
      print('getting clubs');
      return _postsCollection
          .where('club', isEqualTo: clubName)
          .snapshots()
          .map(_getPostItem);
    }
  }

  List<PostItem> _getPostItem(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map(((doc) {
      var comments =
          _firestoreInstance.collection('posts/${doc.id}/comments').snapshots();
      return PostItem.fromUserData(doc, commentsStream: comments);
    })).toList();
  }

  Future<void> updatePost({String id, Map<String, dynamic> postData}) async {
    if (id == null) {
      await _postsCollection.add(postData);
    } else {
      await _postsCollection.doc(id).update(postData);
    }
  }
}
