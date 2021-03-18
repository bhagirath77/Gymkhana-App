import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_services/firebase_repository.dart';
import 'package:gymkhana_app/Blocs/authentication_bloc/authentication_bloc.dart';
import 'package:gymkhana_app/Blocs/themeBloc/theme_bloc.dart';
import 'package:gymkhana_app/constants.dart';
import 'package:gymkhana_app/views/MainActivity/main_activity.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(
          currentTheme == 'light' ? ThemeStates.light() : ThemeStates.dark()),
      child: RepositoryProvider(
        create: (context) => AuthenticationRepository(),
        child: BlocProvider(
          create: (context) => AuthenticationBloc(
              authenticationRepository:
                  context.repository<AuthenticationRepository>()),
          child: MainActivity(),
        ),
      ),
    );
  }
}
