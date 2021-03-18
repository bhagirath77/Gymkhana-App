import 'package:flutter/material.dart';
import 'package:gymkhana_app/WIdgets/all_widgets.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            SearchField()
          ],
        ),
      ),
    );
  }
}
