import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_services/firebase_repository.dart';
import 'package:flutter/material.dart';
import 'package:gymkhana_app/WIdgets/all_widgets.dart';
import 'package:gymkhana_app/constants.dart';
import 'package:gymkhana_app/views/post_view/post_view.dart';

class PostTile extends StatelessWidget {
  const PostTile( {@required PostItem postItem})
      : _postItem = postItem;
  final PostItem _postItem;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PostView(
                      postItem: _postItem,
                    )));
      },
      child: Container(
        decoration: neumorphicBorderDecoration(context,
            borderRadius: 40, offset1: 8, spreadRadius: 0, blurRadius: 8),
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.only(bottom: 20, top: 20),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: currentTheme == 'light'
                              ? Colors.black
                              : Colors.white,
                          width: 2),
                      borderRadius: BorderRadius.circular(100)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      _postItem.photoUrl,
                      height: 45,
                      width: 45,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    _postItem.title,
                    style: theme.textTheme.headline6,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              _postItem.description.length > 600
                  ? '${_postItem.description.substring(0, 600)}... Read Further'
                  : _postItem.description,
              style: theme.textTheme.subtitle1,
            ),
            SizedBox(
              height: 5,
            ),
            StreamBuilder(
              stream: _postItem.comments,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      !snapshot.hasData
                          ? 'Loading Comments'
                          : '${snapshot.data.docs.length} comments',
                      style: theme.textTheme.subtitle2,
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
