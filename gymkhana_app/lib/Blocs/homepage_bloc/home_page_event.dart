part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class HomepageInit extends HomePageEvent {}

class SearchFilterEvent extends HomePageEvent {
  final text;

  SearchFilterEvent(this.text);

  @override
  // TODO: implement props
  List<Object> get props => [text];
}

class ClubFilterEvent extends HomePageEvent{
  final club;

  ClubFilterEvent(this.club);

  @override
  List<Object> get props => [this.club];
}

class FilterEvent extends HomePageEvent{
  final club;
  final text;

  FilterEvent({this.club, this.text});
}

class TimerEvent extends HomePageEvent{

}