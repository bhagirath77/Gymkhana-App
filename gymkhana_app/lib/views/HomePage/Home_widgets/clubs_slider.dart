import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymkhana_app/Blocs/clubs_bloc/clubs_bloc.dart';
import 'package:gymkhana_app/Blocs/homepage_bloc/home_page_bloc.dart';

import '../../../Widgets/All_widgets/widgets.dart';

class ClubsSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClubsBloc, ClubsListState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              height: 130,
              child: ListView(
                addAutomaticKeepAlives: true,
                padding: EdgeInsets.symmetric(vertical: 10),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  ClubTile(
                    imageLoc: 'assets/images/cult.jpg',
                    title: 'Cult and Lit',
                    myNor: 1,
                  ),
                  ClubTile(
                    imageLoc: 'assets/images/sctch.jpg',
                    title: 'Science and Tech',
                    myNor: 2,
                  ),
                  ClubTile(
                    imageLoc: 'assets/images/camplife.jpg',
                    title: 'Campus Life',
                    myNor: 3,
                  ),
                  ClubTile(
                    imageLoc: 'assets/images/acads.jpg',
                    title: 'Academics and Career',
                    myNor: 4,
                  ),
                  ClubTile(
                    imageLoc: 'assets/images/sports.jpg',
                    title: 'Sports and Games',
                    myNor: 5,
                  ),
                  ClubTile(
                    imageLoc: 'assets/images/design.jpg',
                    title: 'Design and Arts',
                    myNor: 6,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            AnimatedContainer(
              padding: EdgeInsets.only(right: 30),
              height: state.selected == 0 ? 0 : 50,
              duration: const Duration(milliseconds: 300),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.bloc<HomePageBloc>().add(HomepageInit());
                      context
                          .bloc<ClubsBloc>()
                          .add(SocietyChanged(society: null, selected: 0));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      decoration: neumorphicBorderDecoration(context,borderRadius: 10,offset1: 4,offset2: 3,spreadRadius: 0,blurRadius: 7),
                      child: Text('Clear',style: Theme.of(context).textTheme.subtitle2),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

class ClubTile extends StatefulWidget {
  final String title;
  final String imageLoc;
  final int myNor;

  const ClubTile({Key key, this.title, this.imageLoc, this.myNor})
      : super(key: key);

  @override
  _ClubTileState createState() => _ClubTileState();
}

class _ClubTileState extends State<ClubTile>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (context.bloc<ClubsBloc>().state.selected == widget.myNor) {
          } else {
            context.bloc<ClubsBloc>().add(
                SocietyChanged(society: widget.title, selected: widget.myNor));
            context
                .bloc<HomePageBloc>()
                .add(FilterEvent(text: null, club: widget.title));
          }
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        decoration: context.bloc<ClubsBloc>().state.selected == widget.myNor
            ? innerShadow(20)
            : neumorphicBorderDecoration(context,
            borderRadius: 20, offset1: 10,offset2: 2, spreadRadius: 0, blurRadius: 10),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              widget.imageLoc,
              height: 100,
              width: 140,
              fit: BoxFit.cover,
            ),
          ),
          Container(
              height: 100,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black26,
              ),
              alignment: Alignment.center,
              child: Text(
                widget.title,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))
        ]),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
