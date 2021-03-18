import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gymkhana_app/constants.dart';

class ThemeStates extends Equatable {
  final ThemeData themeData;

  ThemeStates(this.themeData);

  factory ThemeStates.light() {
    return ThemeStates(lightTheme());
  }
  factory ThemeStates.dark() {
    return ThemeStates(darkTheme());
  }


  @override
  List<Object> get props => [themeData];
}

enum ThemeChange { light, dark }

class ThemeBloc extends Bloc<ThemeChange, ThemeStates> {
  ThemeBloc(ThemeStates initialState) : super(initialState);

  @override
  Stream<ThemeStates> mapEventToState(ThemeChange event) async*{
    if (event == ThemeChange.light) {
      yield ThemeStates.light();
    }else{
      yield ThemeStates.dark();
    }
  }
}
