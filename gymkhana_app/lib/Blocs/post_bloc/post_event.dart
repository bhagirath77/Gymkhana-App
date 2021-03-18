part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class LoadPost extends PostEvent {}

class PostViewEvent extends PostEvent {
  final PostItem postItem;

  const PostViewEvent(this.postItem);
}

class PostEditEvent extends PostEvent {
  final PostItem postItem;

  const PostEditEvent(this.postItem);
}
