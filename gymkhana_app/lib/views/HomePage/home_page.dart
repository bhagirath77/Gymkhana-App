import 'package:firebase_services/firebase_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymkhana_app/Blocs/blocs.dart';
import 'package:gymkhana_app/Pedantic%20Pack/pedantic.dart';
import 'package:gymkhana_app/constants.dart';
import '../NewPostPage/new_post.dart';
import 'Home_widgets/home_widgets.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<FirestoreRepository>(
      create: (context) => FirestoreRepository(
          uid: context
              .repository<AuthenticationRepository>()
              .currentCustomUser
              .id),
      child: BlocProvider(
        lazy: false,
        create: (context) =>
            HomePageBloc(context.repository<FirestoreRepository>())
              ..add(HomepageInit()),
        child: HomePageView(),
      ),
    );
  }
}

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  ScrollController scrollController = ScrollController();
  bool closeTopContainer = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      setState(() {
        closeTopContainer = scrollController.offset > 100;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        drawer: AppDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => NewPost()));
          },
          child: Icon(
            Icons.add,
            color: currentTheme =='light' ? Colors.black : Colors.white,
            size: 30,
          ),
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              AnimatedContainer(
                  width: size.width,
                  duration: const Duration(milliseconds: 200),
                  height: closeTopContainer ? 0 : 150,
                  child: HomePageTop(
                    size: size,
                  )),
              SizedBox(
                height: 5,
              ),
              BlocProvider(
                create: (context) => ClubsBloc(),
                child: Container(
                  child: ClubsSlider(),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: BlocBuilder<HomePageBloc, HomePageState>(
                  builder: (context, state) {
                    if (state is HomePageLoading) {
                      context.bloc<HomePageBloc>().add(TimerEvent());
                      context.bloc<HomePageBloc>().stopwatch.start();
                      return const Center(
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (state is HomePageError) {
                      return const Center(
                        child: const Text("oh oh error"),
                      );
                    }
                    if (state is HomePageLoaded) {
                      return StreamBuilder(
                        stream: state.postItems,
                        builder:
                            (context, AsyncSnapshot<List<PostItem>> snapshot) {
                          if (!snapshot.hasData ||
                              (snapshot.data.length == 0)) {
                            return Center(
                                child: Text(
                              'No data Received yet',
                              style: Theme.of(context).textTheme.headline5,
                            ));
                          } else {
                            context.bloc<HomePageBloc>().stopwatch.stop();
                            print(context.bloc<HomePageBloc>().stopwatch.elapsed);
                            context.bloc<HomePageBloc>().stopwatch.reset();
                            return ListView(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                controller: scrollController,
                                shrinkWrap: true,
                                children: snapshot.data.map((PostItem post) {
                                  return PostTile(
                                    postItem: post,
                                  );
                                }).toList());
                          }
                        },
                      );
                    }
                    if (state is HomePageEmpty) {
                      return Text(
                        'Empty',
                        style: Theme.of(context).textTheme.headline6,
                      );
                    } else {
                      return Text('something happened');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
