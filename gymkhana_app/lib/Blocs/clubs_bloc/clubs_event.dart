part of 'clubs_bloc.dart';

@immutable
abstract class ClubSelectEvent {
  const ClubSelectEvent();
}

class ClubsFormLoaded extends ClubSelectEvent {}

class SocietyChanged extends ClubSelectEvent {
  const SocietyChanged({this.society,this.selected});
  final int selected;

  final String society;
}

class ClubChanged extends ClubSelectEvent {
  const ClubChanged({this.model});

  final String model;
}

class ClearAll extends ClubSelectEvent{}