import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymkhana_app/Blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymkhana_app/constants.dart';

import 'concave_decoration.dart';

BoxDecoration neumorphicBorderDecoration(
  BuildContext context, {
  @required double borderRadius,
  @required double offset1,
  @required double spreadRadius,
  @required double blurRadius,
  double offset2,
}) {
  bool lightTheme = currentTheme == 'light';
  return BoxDecoration(
      gradient: lightTheme
          ? null
          : LinearGradient(
              begin: Alignment(-0.5,-2),
              end: Alignment(-1,2),
              colors: [
                  Color.fromRGBO(38, 41, 45, 1),
                  Color.fromRGBO(45, 48, 54, 1),
                ]),
      color: lightTheme
          ? Theme.of(context).scaffoldBackgroundColor
          : Color.fromRGBO(43, 51, 56, .6),
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
            color: lightTheme
                ? LightShadow.primaryShadow
                : DarkShadow.primaryShadow,
            offset: Offset(-offset1, -offset1),
            spreadRadius: spreadRadius,
            blurRadius: blurRadius),
        BoxShadow(
            color: lightTheme
                ? LightShadow.secondaryShadow
                : DarkShadow.secondaryShadow,
            offset: Offset(offset2 ?? offset1, offset2 ?? offset1),
            spreadRadius: spreadRadius,
            blurRadius: blurRadius)
      ]);
}

Decoration innerShadow(double depth) {
  return ConcaveDecoration(
      colors: [
        Color.fromRGBO(250, 251, 255, .1),
        Color.fromRGBO(166, 171, 189, 1),
      ],
      opacity: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      depth: depth);
}

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: neumorphicBorderDecoration(context,
          borderRadius: 10, offset1: 5, spreadRadius: 0, blurRadius: 10),
      padding: EdgeInsets.all(9),
      child: Row(
        children: [
          SizedBox(
            width: 15,
          ),
          Icon(
            Icons.search,
            color: Colors.blue,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              'Search',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ],
      ),
    );
  }
}

class FeedbackConfirmation extends StatefulWidget {
  @override
  _FeedbackConfirmationState createState() => _FeedbackConfirmationState();
}

class _FeedbackConfirmationState extends State<FeedbackConfirmation> {
  bool val = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 5,
          ),
          Text('Feedback ?',style: Theme.of(context).textTheme.subtitle2,),
          SizedBox(
            width: 10,
          ),
          Switch(
              value: val,
              onChanged: (val) {
                context.bloc<NewPostBloc>().add(FeedBackChanged(val));
                setState(() => this.val = val);
              }),
          SizedBox(width: 10,)
        ],
      ),
    );
  }
}

void showDialogBox(BuildContext context, Function submitPost) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Submit post?'),
          content: Text('Are you sure to submit'),
          actions: [
            FlatButton(
              child: Text('cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: Text('yes'),
              onPressed: submitPost,
            )
          ],
        );
      });
}
