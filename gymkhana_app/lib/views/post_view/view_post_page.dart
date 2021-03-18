import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_services/firebase_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymkhana_app/Blocs/post_bloc/post_bloc.dart';
import 'package:gymkhana_app/Widgets/all_widgets.dart';
import 'package:gymkhana_app/views/post_view/comments.dart';
import '../../constants.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

enum Comments { feedback, comment }

class ViewPostPage extends StatefulWidget {
  final PostItem _postItem;
  final String presentTheme;

  ViewPostPage(this._postItem, this.presentTheme);

  @override
  _ViewPostPageState createState() => _ViewPostPageState();
}

class _ViewPostPageState extends State<ViewPostPage>
    with TickerProviderStateMixin {
  TabController _tabController;
  int _currentTab = 0;
  List<String> _description;
  List<TextSpan> _textSpanList = <TextSpan>[];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleChanges);
    _description = widget._postItem.description.split('```');
    _createTextSpanList();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          decoration: neumorphicBorderDecoration(context,
              borderRadius: 40,
              offset1: 1,
              spreadRadius: 0,
              blurRadius: 10,
              offset2: 3),
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.network(
                    widget._postItem.photoUrl,
                    height: 70,
                    width: 70,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Text(
                    widget._postItem.title,
                    style: theme.textTheme.headline5,
                  )),
                ],
              ),
              Divider(
                color: theme.accentColor,
                thickness: 1,
              ),
              Text.rich(TextSpan(children: _textSpanList)),
              Divider(
                color: theme.accentColor,
                thickness: 1,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: TabBar(
              onTap: (index) {
                setState(() {
                  _currentTab = index;
                });
              },
              indicatorColor: theme.accentColor,
              controller: _tabController,
              tabs: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(13),
                      decoration: _currentTab == 0
                          ? innerShadow(5)
                          : neumorphicBorderDecoration(context,
                              borderRadius: 10,
                              offset1: 4,
                              offset2: 3,
                              spreadRadius: 0,
                              blurRadius: 7),
                      child: Text(
                        'comments',
                        style: theme.textTheme.subtitle1,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(13),
                      decoration: _currentTab == 1
                          ? innerShadow(5)
                          : neumorphicBorderDecoration(context,
                              borderRadius: 10,
                              offset1: 4,
                              offset2: 3,
                              spreadRadius: 0,
                              blurRadius: 7),
                      child: Text(
                        'feedback',
                        style: theme.textTheme.subtitle1,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                )
              ]),
        ),
        SizedBox(height: 10,),
        Container(
          height: 350,
          margin: EdgeInsets.symmetric(horizontal: 11),
          child: TabBarView(controller: _tabController, children: [
            Stack(
              children: [
                CFVIew.comments(widget._postItem.id, context),
                Positioned(
                  bottom: 0,
                  child: CommentButton(widget._postItem, Comments.comment),
                )
              ],
            ),
            Container(
              child: widget._postItem.enableFeedback
                  ? Stack(
                      children: [
                        CFVIew.feedback(widget._postItem.id, context),
                        Positioned(
                          bottom: 0,
                          child: CommentButton(
                              widget._postItem, Comments.feedback),
                        )
                      ],
                    )
                  : Center(
                      child: Text(
                        'Feedback has been disabled for this post',
                        style: theme.textTheme.subtitle1,
                      ),
                    ),
            )
          ]),
        )
      ],
    );
  }

  void _handleChanges() {
    setState(() {
      _currentTab = _tabController.index;
    });
  }

  _createTextSpanList() {
    var tempTextSpanList = <TextSpan>[];
    _description.forEach((desc) {
      if (RegExp(urlPattern).hasMatch(desc)) {
        tempTextSpanList.add(TextSpan(
            text: 'Link',
            style: TextStyle(fontSize: 18, color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                if (await canLaunch(desc)) {
                  await launch(desc);
                } else {
                  throw '$desc not launched';
                }
              }));
      } else {
        tempTextSpanList.add(TextSpan(
            text: desc,
            style: widget.presentTheme == 'light'
                ? TextStyle(color: Colors.black, fontSize: 19)
                : TextStyle(color: Colors.white, fontSize: 19)));
      }
    });
    setState(() {
      _textSpanList = tempTextSpanList;
    });
  }
}

class CommentButton extends StatefulWidget {
  final PostItem _postItem;
  final Comments _comments;

  const CommentButton(this._postItem, this._comments);

  @override
  _CommentButtonState createState() => _CommentButtonState();
}

class _CommentButtonState extends State<CommentButton> {
  bool anonymous = false;
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentUser =
        context.repository<AuthenticationRepository>().currentCustomUser;
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.remove_red_eye),
          Switch(
            value: anonymous,
            onChanged: (val) => setState(() => anonymous = val),
          ),
          Container(
              width: MediaQuery.of(context).size.width / 1.8,
              child: TextField(
                controller: _textEditingController,
                onChanged: (val) => setState(() => null),
              )),
          RaisedButton(
            disabledColor: Colors.grey,
            color: Colors.blueGrey,
            onPressed: _textEditingController.text.length > 4
                ? () => _postComment(widget._comments, currentUser)
                : null,
            child: Text(
              'post',
              style: theme.textTheme.subtitle2,
            ),
          )
        ],
      ),
    );
  }

  Future<void> _postComment(Comments comments, CustomUser customUser) async {
    bool isComment = comments == Comments.comment;
    var commentData = {
      'byUrl': anonymous ? null : customUser.photoUrl,
      'by': anonymous ? 'Anonymous' : customUser.name,
      'comment': _textEditingController.text,
      'timestamp': Timestamp.now(),
    };
    await context.bloc<PostBloc>().databaseService.addComment(
        path: isComment
            ? '${widget._postItem.id}/comments'
            : '${widget._postItem.id}/feedback',
        commentData: commentData);
    setState(
      () {
        _textEditingController.text = '';
      },
    );
  }
}
