import 'package:firebase_services/firebase_repository.dart';
import 'package:flutter/material.dart';
import 'package:gymkhana_app/Widgets/all_widgets.dart';
import 'package:gymkhana_app/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymkhana_app/views/SearchPage/search_view.dart';

class HomePageTop extends StatelessWidget {
  final Size size;

  const HomePageTop({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.menu,
                size: 30,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
            FittedBox(fit: BoxFit.fill, child: LogoutButton()),
          ],
        ),
      ),
      Positioned(
          top: 55,
          child: GestureDetector(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => SearchView())),
            child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(20),
                width: size.width,
                child: SearchField()),
          )),
    ]);
  }
}

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(1),
      decoration: neumorphicBorderDecoration(context,
          borderRadius: 10, offset1: 5, spreadRadius: 0, blurRadius: 7),
      child: IconButton(
        icon: Icon(
          Icons.arrow_forward,
        ),
        onPressed: () =>
            context.repository<AuthenticationRepository>().logout(),
      ),
    );
  }
}
