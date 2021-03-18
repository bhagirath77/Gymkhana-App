import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymkhana_app/Blocs/blocs.dart';
import 'package:gymkhana_app/splash_page.dart';
import 'package:gymkhana_app/views/HomePage/home_page.dart';
import 'package:gymkhana_app/views/LoginPage/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

class MainActivity extends StatefulWidget {
  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc,ThemeStates>(
      builder:(context,state) => MaterialApp(
        theme: state.themeData,
        debugShowCheckedModeBanner: false,
        navigatorKey: _navigatorKey,
        builder: (context, child) {
          return FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: const Text('Something went wrong'),
                  ),
                );
              }
              if(snapshot.connectionState==ConnectionState.done){
                return BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state.status == AuthStatus.authenticated) {
                      return _navigator.pushAndRemoveUntil<void>(
                        HomePage.route(),
                            (route) => false,
                      );
                    } else {
                      return _navigator.pushAndRemoveUntil<void>(
                        LoginPage.route(),
                            (route) => false,
                      );
                    }
                  },
                  child: child,
                );
              }
              return Scaffold(
                body: Center(child: CircularProgressIndicator(),),
              );
            },
          );
        },
        onGenerateRoute: (_) => SplashPage.route(),
      ),
    );
  }
}
