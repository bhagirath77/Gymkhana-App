import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CFVIew extends StatelessWidget {
  final String _id;
  final BuildContext context;
  final String route;

  const CFVIew(this._id, this.context, this.route);

  CFVIew.comments(String id, BuildContext context)
      : this(id, context, 'comments');

  CFVIew.feedback(String id, BuildContext context)
      : this(id, context, 'feedback');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts/$_id/$route')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        print(snapshot.toString());
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: snapshot.data.docs.map((doc) {
              var data = doc.data();
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    data['byUrl'] == null
                        ? Icon(Icons.account_circle)
                        : Image.network(
                            data["byUrl"],
                            height: 40,
                            width: 40,
                          ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        '${data["by"]}...',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(child: Text(data['comment'],style: Theme.of(context).textTheme.subtitle2,),)
                  ],
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }
}
