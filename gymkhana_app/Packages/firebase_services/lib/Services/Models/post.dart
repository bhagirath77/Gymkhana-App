import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class PostItem extends Equatable {
  factory PostItem.fromUserData(QueryDocumentSnapshot doc,
      {@required Stream<QuerySnapshot> commentsStream}) {
    var data = doc.data();
    return PostItem._(
        title: data['title'].toString(),
        clubName: data['club'].toString(),
        id: doc.id,
        description: data['description'] as String,
        photoUrl: data['photoUrl'].toString(),
        comments: commentsStream,
        enableFeedback: data['enableFeedback'] as bool);
  }

  const PostItem._(
      {@required this.id,
      @required this.title,
      @required this.clubName,
      @required this.description,
      @required this.photoUrl,
      @required this.comments,
      @required this.enableFeedback});

  final String id;
  final String title;
  final String clubName;
  final String description;
  final String photoUrl;
  final Stream<QuerySnapshot> comments;
  final bool enableFeedback;

  @override
  List<Object> get props => [
        title,
        clubName,
        description,
        id,
      ];
}
