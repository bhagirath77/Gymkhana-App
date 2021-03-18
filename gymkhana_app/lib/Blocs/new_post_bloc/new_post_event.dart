part of 'new_post_bloc.dart';

abstract class NewPostEvent extends Equatable {
  const NewPostEvent();

  @override
  List get props => [];
}

class TitleChanged extends NewPostEvent {
  final String title;

  TitleChanged(this.title);
}

class BodyChanged extends NewPostEvent {
  final String body;

  BodyChanged(this.body);
}

class FeedBackChanged extends NewPostEvent{
  final bool feedback;

  FeedBackChanged(this.feedback);
}
