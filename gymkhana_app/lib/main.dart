import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:gymkhana_app/app.dart';
import 'package:gymkhana_app/simple_bloc_observer.dart';
import 'constants.dart';

Future<void> main() async{
  Bloc.observer=SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await getThemePreference();
  runApp(App());
}