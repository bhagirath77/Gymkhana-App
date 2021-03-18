part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HomePageLoading extends HomePageState {}

class HomePageEmpty extends HomePageState {}

class HomePageLoaded extends HomePageState {
  final Stream<List<PostItem>> postItems;

  const HomePageLoaded(this.postItems);

  @override
  List<Object> get props => [postItems];
}

class HomePageError extends HomePageState{}
